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
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "预览页面"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)

        let previewController = DocQLPreviewController()
        previewController.navigationItem.hidesBackButton = false

        previewController.delegate = self
        previewController.dataSource = self
//        previewController.filePreDelegate = self
        navigationController?.pushViewController(previewController, animated: false)
    }
}

typealias FilePreViewController_Delegate = FilePreViewController
extension FilePreViewController_Delegate: QLPreviewControllerDelegate, QLPreviewControllerDataSource {
    fileprivate final class PreviewItem: NSObject, QLPreviewItem {
        var itemURL: URL = URL(string: "https://www.qq.com")!
        var itemTitle: String?

        init(itemURL: URL, itemTitle: String?) {
            self.itemURL = itemURL
            self.itemTitle = itemTitle
        }

        @objc var previewItemURL: URL? { return itemURL }
        @objc var previewItemTitle: String? { return itemTitle }
    }

    internal func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        controller.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        return 1
    }

    internal func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {

        let filePath = Bundle.main.path(forResource: "test", ofType: "xlsx") ?? ""
        let titleName = "test.pdf"
        let url = URL(fileURLWithPath: filePath)
        return PreviewItem(itemURL: url, itemTitle: titleName)
    }
}
