//
//  FileDownloadViewController.swift
//  SwiftDemo
//
//  Created by qianzhao on 2020/3/13.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import UIKit

internal protocol FileDownloadViewControllerDelegate: class {
    func finishDownload(_ path: String?)
}

class FileDownloadViewController: UIViewController {
    fileprivate var session: Foundation.URLSession?
    fileprivate var downloadTask: URLSessionDownloadTask?

    fileprivate var url: String
    fileprivate var filePath: String

    @IBOutlet var processView: UIProgressView!
    internal weak var delegate: FileDownloadViewControllerDelegate?

    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    internal init(_ url2: String, _ path: String) {
        url = url2
        filePath = path
        super.init(nibName: "FileDownloadViewController", bundle: nil)
        session = Foundation.URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "文件预览"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "navigationBar_back"), style: .plain, target: self, action: #selector(actionBack))

        self.processView.progress = 0
        if let url = URL(string: self.url) {
            downloadTask = session?.downloadTask(with: URLRequest(url: url))
            downloadTask?.resume()
        }
    }

    @objc fileprivate func actionBack() {
        downloadTask?.cancel()
        session?.invalidateAndCancel()

        downloadTask = nil
//        delegate?.fileDownloadViewController(self, state: -1, attachment: attachment)
    }
}

private typealias FileDownloadViewController_Session = FileDownloadViewController
extension FileDownloadViewController_Session: URLSessionDownloadDelegate {
    internal func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        self.downloadTask = nil
        log.info("下载文件成功")
        let fielManager = FileManager.default
        let fileName: String = filePath.components(separatedBy: "/").last!

        let fileDir = String(filePath[filePath.startIndex ..< filePath.index(filePath.endIndex, offsetBy: -fileName.count)])

        if !fielManager.fileExists(atPath: fileDir) {
            try? fielManager.createDirectory(atPath: fileDir, withIntermediateDirectories: true, attributes: nil)
        }

        do {
            try fielManager.copyItem(at: location, to: URL(fileURLWithPath: filePath))
            log.info("复制文件成功")
            self.session?.invalidateAndCancel()
            self.session = nil
            DispatchQueue.main.async(execute: { [weak self] in
                self?.navigationController?.popViewController(animated: false)
                self?.delegate?.finishDownload(self?.filePath)
            })

        } catch let err as NSError {
            log.error("文件处理失败:e = \(err)")
            DispatchQueue.main.async(execute: { [weak self] in
                self?.showToastMessage("文件下载失败")
            })
        }
    }

    internal func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progressValue = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        setProgressValue(progressValue, total: totalBytesWritten)
    }

    internal func setProgressValue(_ value: Float, total: Int64) {
        DispatchQueue.main.sync { [weak self] () -> Void in
            self?.processView.progress = value
            self?.processView.isHidden = false
        }
    }
}
