//
//  Cache.swift
//  TestiOS
//
//  Created by 张延深 on 2020/1/3.
//  Copyright © 2020 张延深. All rights reserved.
//

import Foundation

struct Cache {
    static var data = [String: Any]()
    // 1.信号量
//    static var lock = DispatchSemaphore(value: 1)
    // 2.NSLock
//    static var lock = NSLock()
    // 3.NSRecursiveLock
    static var lock = NSRecursiveLock()
    static func set(_ key: String, _ value: Any) {
//        lock.wait()
//        defer {
//            lock.signal()
//        }
        
        lock.lock()
        defer {
            lock.unlock()
        }
        data[key] = value
    }
    
    static func get(_ key: String) -> Any? {
        data[key]
    }
}
