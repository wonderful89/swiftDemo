//
//  DemoFlutterViewController.swift
//  SwiftDemo
//
//  Created by 赵千千 on 2020/5/8.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import Flutter
import FlutterPluginRegistrant
import UIKit

class DemoFlutterViewController: FlutterViewController {
    var name: String?
    init(pageName: String?) {
        self.name = pageName
        super.init(engine: SwiftFlutterEngine.shared, nibName: nil, bundle: nil)
    }
    
    deinit {
        log.info("DemoFlutterViewController deinit")
        SwiftFlutterEngine.shared.viewController = nil
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        SwiftFlutterEngine.shared.pushReplacement(self.name ?? "pageA", args: ["key1": "value1", "key2": 220])
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}
