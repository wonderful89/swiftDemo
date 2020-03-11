//
//  LayoutViewController.swift
//  SwiftDemo
//
//  Created by qianzhao on 2020/3/11.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import UIKit

enum Animal: Int {
    case cat = 0
    case dog = 1
}

class LayoutViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let _: Animal? = .cat
        title = "LayoutViewController"
    }

}
