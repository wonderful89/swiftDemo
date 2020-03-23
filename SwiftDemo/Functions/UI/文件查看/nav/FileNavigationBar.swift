//
//  FileNavigationBar.swift
//  SwiftDemo
//
//  Created by qianzhao on 2020/3/13.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import Foundation

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
        if let callback = navBack {
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
        // navigationBar?.topItem?.title = ""
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
