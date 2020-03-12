//
//  FileNavigationController.swift
//  SwiftDemo
//
//  Created by qianzhao on 2020/3/12.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import UIKit

public class FileNavigationBar: UINavigationBar {
    public var backgroundView: UIView = UIView()
    public var navBack: ((_ sender: Any) -> Void)?

    public var backgroundImageView: UIImageView = UIImageView()

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = nil
        backgroundView.frame = CGRect(x: 0,
                                      y: -UIApplication.shared.statusBarFrame.height,
                                      width: self.frame.width,
                                      height: self.frame.height + UIApplication.shared.statusBarFrame.height)

        backgroundView.isUserInteractionEnabled = false
        backgroundView.backgroundColor = nil
        backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        backgroundImageView.backgroundColor = nil
        backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        backgroundImageView.frame = CGRect(origin: .zero, size: backgroundView.frame.size)
        backgroundView.addSubview(backgroundImageView)

        addSubview(backgroundView)
    }
    @objc func navBackEvent(_ sender: Any) {
        if let callback = navBack{
            callback(sender)
        }
    }

    // 设置样式
    public func configBlack() {
        let navigationBar: FileNavigationBar? = self
        navigationBar?.isTranslucent = true

        // 设置tintColor的值
        navigationBar?.tintColor = .black
        navigationBar?.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular), NSAttributedString.Key.foregroundColor: UIColor.black]

        // 清除bar原有view的样式，使其变的透明。这要是为了去除下面的线条
        navigationBar?.barTintColor = nil
        navigationBar?.backgroundColor = nil
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
        navigationBar?.shadowImage = UIImage.color(CGSize(width: UIScreen.main.bounds.width, height: 1), .clear)

        // 设置新的样式，主要通过设置子view的样式实现
        navigationBar?.backgroundView.alpha = 1.0
        navigationBar?.backgroundImageView.alpha = 1.0
        var barTintImage: UIImage?
        if #available(iOS 11.0, *) {
            let bgColor = UIColor(named: "f7f8fa") ?? .white
            barTintImage = UIImage.color(CGSize(width: UIScreen.main.bounds.width, height: 64), bgColor)
        } else {
            // Fallback on earlier versions
        }
        navigationBar?.backgroundImageView.image = barTintImage!

        // 设置返回view的image
        navigationBar?.backIndicatorImage = UIImage(named: "navigationBar_back")
        // 设置backButton的title
        navigationBar?.topItem?.title = ""
        if let _ = navBack {
            navigationBar?.topItem?.backBarButtonItem?.action = #selector(self.navBackEvent(_:))
            navigationBar?.topItem?.backBarButtonItem?.target = self
        }
        navigationBar?.backIndicatorTransitionMaskImage = UIImage(named: "navigationBar_back")
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)], for: .normal)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        sendSubviewToBack(backgroundView)
    }
}

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
        self.dismiss(animated: true, completion: nil)
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        (navigationBar as! FileNavigationBar).navBack = backButtonEvent
        (navigationBar as! FileNavigationBar).configBlack()
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
