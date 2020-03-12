//
//  MainViewController+Login.swift
//  SwiftDemo
//
//  Created by qianzhao on 2020/3/12.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import Foundation

private typealias MainViewController_Logic = MainViewController
extension MainViewController_Logic {
    func handleLogic(type: String) {
        let typeE = TestConfig.Logic(rawValue: type)
        switch typeE {
        case .openFile:
            openFile()
        default:
            log.info("默认")
        }
        log.info("handleLogic: \(type)")
    }

    func openFile() {
        let vc = FilePreViewController()
        let nav = FileNavigationController(rootViewController: vc)

        self.navigationController?.present(nav, animated: true, completion: nil)
    }
}
