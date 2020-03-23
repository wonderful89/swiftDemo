//
//  FileNavigationController.swift
//  SwiftDemo
//
//  Created by qianzhao on 2020/3/12.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import UIKit

class FileNavigationController: UINavigationController {
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    public override init(rootViewController: UIViewController) {
        super.init(navigationBarClass: FileNavigationBar.classForCoder(), toolbarClass: nil)
        viewControllers = [rootViewController]
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func backButtonEvent(_ sender: Any) {
        log.info("backButtonEvent")
        dismiss(animated: true, completion: nil)
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        (navigationBar as! FileNavigationBar).navBack = backButtonEvent
        (navigationBar as! FileNavigationBar).configBlack()
//        navigationBar.delegate = self
        // 这里设置的不起作用
        // navigationItem.backBarButtonItem = UIBarButtonItem(title: "11", style: .plain, target: self, action: #selector(backButtonEvent(_:)))
    }

    public override var prefersStatusBarHidden: Bool {
        return topViewController?.prefersStatusBarHidden ?? false
    }

    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }

    public override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return self.topViewController?.preferredStatusBarUpdateAnimation ?? .slide
    }

    open override var shouldAutorotate: Bool {
        return self.topViewController?.shouldAutorotate ?? super.shouldAutorotate
    }

    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.topViewController?.supportedInterfaceOrientations ?? super.supportedInterfaceOrientations
    }

    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if !children.isEmpty {
            viewController.hidesBottomBarWhenPushed = true
        }

        super.pushViewController(viewController, animated: animated)
    }
}

typealias FileNavigationController_BarDelegate = FileNavigationController
extension FileNavigationController_BarDelegate: UINavigationBarDelegate {
    func navigationBar(_ navigationBar: UINavigationBar, shouldPush item: UINavigationItem) -> Bool {
        log.info("shouldPushItem")
        return true
    }

    func navigationBar(_ navigationBar: UINavigationBar, didPush item: UINavigationItem) {
        log.info("didPushItem")
    }

    func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        /// 做保护
        if viewControllers.count < navigationBar.items?.count ?? 0 {
            return true
        }

        // Check if we have a view controller that wants to respond to being popped
        if let topViewController = self.topViewController as? FileNavigationControllerProtocol {
            guard topViewController.fileNavigationBar(navigationBar, shouldPop: item) != false else {
                // Prevent the back button from staying in an disabled state
                for view in navigationBar.subviews where view.alpha < 1.0 {
                    UIView.animate(withDuration: 0.25, animations: {
                        view.alpha = 1.0
                    })
                }
                return false
            }
        }

        for view in navigationBar.subviews where view.alpha < 1.0 {
            UIView.animate(withDuration: 0.25, animations: {
                view.alpha = 1.0
            })
        }
        DispatchQueue.main.async(execute: { [weak self] in
            self?.popViewController(animated: true)
        })

        return false
    }

    func navigationBar(_ navigationBar: UINavigationBar, didPop item: UINavigationItem) {
        log.info("didPopItem")
    }
}

extension UIImage {
    // 纯颜色图片
    public static func color(_ size: CGSize, _ color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }

        color.setFill()
        context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }
}
