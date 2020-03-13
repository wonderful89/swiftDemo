//
//  FileNavigationControllerProtocol.swift
//  SwiftDemo
//
//  Created by qianzhao on 2020/3/13.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import Foundation

protocol FileNavigationControllerProtocol {
    func fileNavigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool
}
