//
//  TestConfig.swift
//  SwiftDemo
//
//  Created by qianzhao on 2020/3/6.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import Foundation

enum TestConfig: String, CaseIterable {

    case UIGroup = "UI分组"
    case logicGroup = "逻辑分组"
    case animationGroup = "动画分组"

    static func getGroupLength(test: TestConfig) -> Int {
        var length: Int
        switch test {
        case .UIGroup:
            length = UI.allCases.count
        case .logicGroup:
            length = Logic.allCases.count
        case .animationGroup:
            length = Animation.allCases.count
        }
        return length
    }

    static func getGroupItem(test: TestConfig, index: Int) -> String {
        var retStr: String
        switch test {
        case .UIGroup:
            retStr = UI.allCases[index].rawValue
        case .logicGroup:
            retStr = Logic.allCases[index].rawValue
        case .animationGroup:
            retStr = Animation.allCases[index].rawValue
        }
        return retStr
    }

    enum UI: String, CaseIterable {
        case autoLayout, dnzEmpty, ccc
    }

    enum Logic: String, CaseIterable {
        case openFile, parseJson
    }

    enum Animation: String, CaseIterable {
        case aaa444, bbb, ccc
    }
}
