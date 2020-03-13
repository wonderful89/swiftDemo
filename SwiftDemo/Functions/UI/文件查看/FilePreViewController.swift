//
//  FilePreViewController.swift
//  SwiftDemo
//
//  Created by qianzhao on 2020/3/12.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import QuickLook
import UIKit

class FilePreViewController: UIViewController {
    var file: DemoFile
    init(fileT: DemoFile) {
        file = fileT
        super.init(nibName: "FilePreViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "预览主页面"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        openFile()
    }

    private func openFile() {
        if file.isLocal {
            switch file.fileType {
            case .pdf: fallthrough
            case .excel:
                let previewController = DocQLPreviewController(path: file.filePath, title: "文件title")
                navigationController?.pushViewController(previewController, animated: false)
            case .audio:
                log.info("audio")
            default:
                log.info("other")
            }
        } else {
            let fielManager = FileManager.default
            let filePath = NSHomeDirectory() + "/Documents/download/test.pdf"
            if (fielManager.fileExists(atPath: filePath)){
                log.info("文件已经存在，先删除")
                try? fielManager.removeItem(atPath: filePath)
            }
            let downloadController = FileDownloadViewController(file.url!, filePath)
            downloadController.delegate = self
            self.navigationController?.pushViewController(downloadController, animated: true)
        }
    }
}

extension FilePreViewController: FileDownloadViewControllerDelegate{
    func finishDownload(_ path: String?) {
        self.file.filePath = path
        self.file.isLocal = true
        self.openFile()
        
        /// 修复NavigationBar在下载之后不显示的bug
        let delay = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: delay) {
            log.info("显示navigationBar")
            self.navigationController?.navigationBar.isHidden = false
            self.navigationController?.navigationBar.setNeedsLayout()
            self.navigationController?.navigationBar.setNeedsDisplay()
        }
    }
}
