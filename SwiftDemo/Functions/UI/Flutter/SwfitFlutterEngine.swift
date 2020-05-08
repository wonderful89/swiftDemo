//
//  SwfitFlutterEngine.swift
//  SwiftDemo
//
//  Created by 赵千千 on 2020/5/8.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import Foundation
#if USE_SWIFT_MODULE
    import Flutter
    import FlutterPluginRegistrant

    class SwiftFlutterEngine: FlutterEngine {
        static let shared: SwiftFlutterEngine = {
            let instance = SwiftFlutterEngine(name: "my_engine", project: nil, allowHeadlessExecution: false)
            return instance
        }()

        override init(name labelPrefix: String, project: FlutterDartProject?, allowHeadlessExecution: Bool) {
            super.init(name: labelPrefix, project: project, allowHeadlessExecution: allowHeadlessExecution)
        }

        public func setup() {
            run()
            GeneratedPluginRegistrant.register(with: self)
            SwiftCommonAppPlugin.register(with: registrar(forPlugin: "SwiftCommonAppPluginKey"))
        }
    }

    // page route
    extension SwiftFlutterEngine {
        static let pushMethodName = "pushRoute"
        enum PushMode : String{
            case push,pushReplacement,pushAndRemoveAll,popAndPush
        }
        
        public func pushRoute(_ name: String, args: Dictionary<String, Any>) {
            var newArgs = args
            newArgs["pushMode"] = PushMode.push.rawValue
            newArgs["pageName"] = name
            navigationChannel.invokeMethod(SwiftFlutterEngine.pushMethodName, arguments: newArgs.jsonStr2)
        }

        public func pushReplacement(_ name: String, args: Dictionary<String, Any>) {
            var newArgs = args
            newArgs["pushMode"] = PushMode.pushReplacement.rawValue
            newArgs["pageName"] = name
            navigationChannel.invokeMethod(SwiftFlutterEngine.pushMethodName, arguments: newArgs.jsonStr2)
        }

        public func pushAndRemoveAll(_ name: String, args: Dictionary<String, Any>) {
            var newArgs = args
            newArgs["pushMode"] = PushMode.pushAndRemoveAll.rawValue
            newArgs["pageName"] = name
            navigationChannel.invokeMethod(SwiftFlutterEngine.pushMethodName, arguments: newArgs.jsonStr2)
        }

        public func popAndPush(_ name: String, args: Dictionary<String, Any>) {
            var newArgs = args
            newArgs["pushMode"] = PushMode.popAndPush.rawValue
            newArgs["pageName"] = name
            navigationChannel.invokeMethod(SwiftFlutterEngine.pushMethodName, arguments: newArgs.jsonStr2)
        }
    }

#endif
