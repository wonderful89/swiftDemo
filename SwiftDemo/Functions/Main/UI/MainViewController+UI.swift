//
//  MainViewController+UI.swift
//  SwiftDemo
//
//  Created by qianzhao on 2020/3/6.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import Foundation

private typealias MainViewControllerUI = MainViewController
extension MainViewControllerUI {
    func handleUI(type: String) {
        log.info("handleUI: \(type)")
        let typeA = TestConfig.UI(rawValue: type)
        switch typeA {
        case .autoLayout:
            autoLayoutTest()
        default:
            log.info("其他")
        }
    }
    
    func autoLayoutTest() {
        log.info("autoLayoutTest")
        let vc = LayoutViewController()
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
}
