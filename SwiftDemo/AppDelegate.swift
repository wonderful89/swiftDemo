//
//  AppDelegate.swift
//  SwiftDemo
//
//  Created by qianzhao on 2020/3/6.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initLog()
        log.info("didFinishLaunchingWithOptions")
        let nav = UINavigationController()
        nav.viewControllers = [MainViewController()]
        window?.rootViewController = nav
        return true
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        log.info("connectingSceneSession")
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        log.info("didDiscardSceneSessions")
    }

}
