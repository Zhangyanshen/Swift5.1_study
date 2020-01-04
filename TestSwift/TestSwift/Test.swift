//
//  Test.swift
//  TestSwift
//
//  Created by 张延深 on 2019/12/17.
//  Copyright © 2019 张延深. All rights reserved.
//

import Cocoa

func log<T>(_ msg: T, file: NSString = #file, line: Int = #line, fn: String = #function) {
    #if DEBUG
    let prefix = "\(file.lastPathComponent) \(line) \(fn):"
    print(prefix, msg)
    #endif
}
