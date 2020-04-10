//
//  AppDelegate.swift
//  SwiftDemo
//
//  Created by qianzhao on 2020/3/6.
//  Copyright © 2020 qianzhao. All rights reserved.
//
import UIKit
#if USE_SWIFT_MODULE
    import Flutter
    import FlutterPluginRegistrant
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    #if USE_SWIFT_MODULE
        var flutterEngine: FlutterEngine?
    #endif

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initLog()
        initFlutterEngine()
        log.info("didFinishLaunchingWithOptions")
        if #available(iOS 13, *) {
        } else {
            AppDelegate.configWindow(window: window)
        }
        return true
    }

    fileprivate func initFlutterEngine() {
        #if USE_SWIFT_MODULE
            flutterEngine = FlutterEngine(name: "")
            flutterEngine?.run()
            GeneratedPluginRegistrant.register(with: flutterEngine!)
        #endif
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

private typealias AppDelegateConfig = AppDelegate
extension AppDelegateConfig {
    static func configWindow(window: UIWindow?) {
        log.info("configWindow")
        let nav = UINavigationController()
        nav.viewControllers = [MainViewController()]
        window?.rootViewController = nav
    }
}
