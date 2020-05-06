//
//  UINavigationController.swift
//  SwiftDemo
//
//  Created by 赵千千 on 2020/5/6.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import Foundation

extension UINavigationController {
    open override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }

    open override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
}

extension UITabBarController {
    open override var childForStatusBarStyle: UIViewController? {
        return self.children.first
    }

    open override var childForStatusBarHidden: UIViewController? {
        return self.children.first
    }
}

extension UISplitViewController {
    open override var childForStatusBarStyle: UIViewController? {
        return self.children.first
    }

    open override var childForStatusBarHidden: UIViewController? {
        return self.children.first
    }
}
