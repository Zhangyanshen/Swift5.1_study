//
//  test.swift
//  TestiOS
//
//  Created by 张延深 on 2020/1/3.
//  Copyright © 2020 张延深. All rights reserved.
//

import Foundation

typealias Task = () -> Void

struct Asyncs {
    
    // MARK: - public methods
    static func async(_ task: @escaping Task) {
        _async(task)
    }
    
    static func async(_ task: @escaping Task,
                      _ mainTask: @escaping Task)
    {
        _async(task, mainTask)
    }
    
    @discardableResult
    static func delay(_ seconds: Double,
                      _ block: @escaping Task) -> DispatchWorkItem
    {
        let item = DispatchWorkItem(block: block)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds, execute: item)
        return item
    }
    
    @discardableResult
    static func asyncDelay(_ seconds: Double,
                           _ task: @escaping Task) -> DispatchWorkItem
    {
        return _asyncDelay(seconds, task)
    }
    
    @discardableResult
    static func asyncDelay(_ seconds: Double,
                           _ task: @escaping Task,
                           _ mainTask: @escaping Task) -> DispatchWorkItem
    {
        return _asyncDelay(seconds, task, mainTask)
    }
    
    // MARK: - private methods
    private static func _async(_ task: @escaping Task,
                               _ mainTask: Task? = nil)
    {
        let item = DispatchWorkItem(block: task)
        DispatchQueue.global().async(execute: item)
        if let main = mainTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
    }
    
    private static func _asyncDelay(_ seconds: Double,
                                    _ task: @escaping Task,
                                    _ mainTask: Task? = nil) -> DispatchWorkItem
    {
        let item = DispatchWorkItem(block: task)
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + seconds, execute: item)
        if let main = mainTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
        return item
    }
}
