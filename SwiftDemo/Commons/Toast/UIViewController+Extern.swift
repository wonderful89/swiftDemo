//
//  UIViewController+Extern.swift
//  SwiftDemo
//
//  Created by qianzhao on 2020/3/13.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import UIKit

extension UIViewController {
    public func showToastMessage(_ message: String, duration: TimeInterval = 2.0) {
        view.makeToast(message, duration: duration, position: CSToastPositionCenter)
    }

    public func showToastMessageOnWindow(_ message: String, duration: TimeInterval = 2.0) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.makeToast(message, duration: duration, position: CSToastPositionCenter)
    }
}
