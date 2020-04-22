//
//  CommonFlutterPlugin.swift
//  SwiftDemo
//
//  Created by qianzhao on 2020/4/22.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import Foundation
#if USE_SWIFT_MODULE
import Flutter
import UIKit

private let instance: SwiftCommonAppPlugin = SwiftCommonAppPlugin()

public class SwiftCommonAppPlugin: NSObject, FlutterPlugin {
    var sinkOnChanged: FlutterEventSink?
    var listeningOnChanged = false

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "myplugin/method", binaryMessenger: registrar.messenger())
        let eventChannel = FlutterEventChannel(name: "myplugin/event", binaryMessenger: registrar.messenger())

//    let instance = SwiftCommonAppPlugin()
        eventChannel.setStreamHandler(instance)
        registrar.addMethodCallDelegate(instance, channel: channel)    }

    public static func shared() -> SwiftCommonAppPlugin {
        return instance
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "commonCallToNative" {
            let params: Dictionary<String, NSObject> = call.arguments as! Dictionary<String, NSObject>
            let realFun: String = params["fun"] as! String
            print("realFun = \(realFun)")
            if realFun == "backToNativeView" {
                print("backtoNativeView in native")
                let window = (UIApplication.shared.delegate as! AppDelegate).window
                let navController = window?.rootViewController as? UINavigationController
                let curController = navController?.viewControllers.last
                curController?.dismiss(animated: true, completion: nil)
            }
            result(true)
        }
        result("iOS " + UIDevice.current.systemVersion)
    }
}

extension SwiftCommonAppPlugin: FlutterStreamHandler {
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        sinkOnChanged = nil
        return nil
    }

    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        print("onListen")
        sinkOnChanged = events
        let delay = DispatchTime.now() + 3.0
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.sendMessage(params: ["key1": 1111])
        }
        return nil
    }

    func sendMessage(params: Dictionary<String, Any>) {
        sinkOnChanged?(params)
    }
}

#endif
