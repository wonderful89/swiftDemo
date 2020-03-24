//
//  DZNTabBarViewController.swift
//  SwiftDemo
//
//  Created by 赵千千 on 2020/3/24.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import UIKit

class DZNTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc1 = RefreshViewController()
        vc1.view.backgroundColor = .red
        vc1.title = "refresh"
        
        let vc2 = MessageListViewController()
        vc2.view.backgroundColor = .blue
        vc2.title = "vc2"
        
        let vc3 = DZNEmptyViewController()
        vc3.title = "vc3"
        viewControllers = [vc1, vc2, vc3]
    }
}
