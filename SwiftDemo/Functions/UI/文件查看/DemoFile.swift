//
//  DemoFile.swift
//  SwiftDemo
//
//  Created by qianzhao on 2020/3/12.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import Foundation

enum DemoFileType {
    case pdf, word, excel, image, video, audio, markdown
}

struct DemoFile {
    var fileType: DemoFileType
    var isLocal: Bool
    var filePath: String?
    var url: String?
}

class DemoFileTest {
    var fileType: DemoFileType
    var name: String?
//    var age: Int = 0 // 可以
//    var age: Int // 不行，因为不能为空，又没有初始化
//    var age: Int? // 可以， 因为可以为空
    var age: Int? = 0 // 可以
    init(name: String?) {
        self.name = name
        fileType = .pdf
    }
}
