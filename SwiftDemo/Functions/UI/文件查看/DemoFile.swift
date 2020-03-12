//
//  DemoFile.swift
//  SwiftDemo
//
//  Created by qianzhao on 2020/3/12.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import Foundation

// https://s1.q4cdn.com/806093406/files/doc_downloads/test.pdf

enum DemoFileType{
    case pdf, word, excel, image, video, audio, markdown
}

struct DemoFile{
    var fileType: DemoFileType
}
