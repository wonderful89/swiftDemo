//
//  MainViewController+UI.swift
//  SwiftDemo
//
//  Created by qianzhao on 2020/3/6.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import Foundation
#if USE_SWIFT_MODULE
    import Flutter
    import FlutterPluginRegistrant
#endif

private typealias MainViewControllerUI = MainViewController
extension MainViewControllerUI {
    func handleUI(type: String) {
        log.info("handleUI: \(type)")
        let typeA = TestConfig.UI(rawValue: type)
        switch typeA {
        case .autoLayout:
            autoLayoutTest()
        case .dnzEmpty:
            let tabNav = DZNTabBarViewController()
//            let nav = UINavigationController(rootViewController: tabNav)
//            self.present(nav, animated: true, completion: nil)
            navigationController?.pushViewController(tabNav, animated: true)
        case .flutterEntry:
            #if USE_SWIFT_MODULE
                let flutterViewController = DemoFlutterViewController()
//                present(flutterViewController, animated: true, completion: nil)
                navigationController?.pushViewController(flutterViewController, animated: true)
            #endif
        default:
            log.info("其他")
        }
    }

    func autoLayoutTest() {
        log.info("autoLayoutTest")
        let vc = LayoutViewController()
//        let nav = UINavigationController(rootViewController: vc)
//        present(nav, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}
