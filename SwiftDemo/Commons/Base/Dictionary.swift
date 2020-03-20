//
//  Dictionary.swift
//  SwiftDemo
//
//  Created by 赵千千 on 2020/3/20.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import Foundation

extension Dictionary {
    var jsonString: String? {
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: self,
                                                            options: [.prettyPrinted]) else {
            return nil
        }
        return String(data: theJSONData, encoding: .ascii)
    }
    
    func printJson() {
        print(self.jsonString!)
    }
    
//    var jsonStr2: String?{
//        let encoder = JSONEncoder()
//        if let jsonData = try? encoder.encode(self) {
//            if let jsonString = String(data: jsonData, encoding: .utf8) {
//                return jsonString
//            }
//        }
//        return nil
//    }
}

extension Foo {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}

struct Foo: Encodable{
    var a: Int
    var b: String
}

func test(){
    let foo = Foo(a: 1, b: "key1")
    let b2 = foo.dictionary
    print("b2 = \(b2!.jsonString!)")
}

