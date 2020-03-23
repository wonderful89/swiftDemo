//
//  DocQLPreviewController.swift
//  SwiftDemo
//
//  Created by qianzhao on 2020/3/12.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import UIKit
import QuickLook

class DocQLPreviewController: QLPreviewController {
    var filePath: String?
    var showTitle: String?
    
    init(path: String?, title: String?) {
        self.filePath = path
        self.showTitle = title
        super.init(nibName: "DocQLPreviewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let buttonItem = UIBarButtonItem(title: "back2", style: .plain, target: self, action: #selector(backEvent(_:)))
        // 添加到这里会设置双重的leftbar
        
        self.navigationItem.leftBarButtonItems = [buttonItem]
        super.viewWillAppear(animated)
        // 添加到这里会被替换掉，有个闪现的过程
        // self.navigationItem.leftBarButtonItem = buttonItem
    }
    override func viewDidLoad() {
//        self.navigationController?.navigationBar.isHidden = true
//        self.navigationItem.hidesBackButton = false
        self.delegate = self
        self.dataSource = self
    }
    @objc func backEvent(_ sender: Any) {
        log.info("backEvent")
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
//        log.info("viewWillLayoutSubviews"
//        self.navigationController?.navigationBar.isHidden = false
    }
}

typealias DocQLPreviewController_Delegate = DocQLPreviewController
extension DocQLPreviewController_Delegate: QLPreviewControllerDelegate, QLPreviewControllerDataSource {
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
        if let path = filePath {
            let url = URL(fileURLWithPath: path)
            return PreviewItem(itemURL: url, itemTitle: self.title)
        } else {
            let url = URL(fileURLWithPath: "")
            self.showToastMessage("发生错误")
            return PreviewItem(itemURL: url, itemTitle: "发生错误")
        }
    }
}

typealias DocQLPreviewController_Nav = DocQLPreviewController
extension DocQLPreviewController_Nav: FileNavigationControllerProtocol {
    func fileNavigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        self.dismiss(animated: true, completion: nil)
        return false
    }
}
