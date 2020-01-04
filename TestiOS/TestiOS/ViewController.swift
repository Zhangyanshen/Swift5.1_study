//
//  ViewController.swift
//  TestiOS
//
//  Created by 张延深 on 2020/1/2.
//  Copyright © 2020 张延深. All rights reserved.
//

import UIKit

fileprivate let initTask2: Void = {
    print("initTask2---------")
}()

class ViewController: UIViewController {

    static let initTask1: Void = {
        print("initTask1----------")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Self.initTask1
        Self.initTask1
        Self.initTask1
        Self.initTask1
        
        initTask2
        initTask2
        initTask2
        
//        print(Thread.current)
//
//        DispatchQueue.global().async {
//            print(Thread.current)
//            DispatchQueue.main.async {
//
//            }
//        }
        
//        Asyncs.async {
//            print(1)
//        }
//
//        Asyncs.async({
//            print(1, Thread.current)
//        }) {
//            print(2, Thread.current)
//        }
//
//        Asyncs.delay(5) {
//            print("5s", Thread.current)
//        }
        
//        Asyncs.asyncDelay(5) {
//            print("5s", Thread.current)
//        }
//
//        Asyncs.asyncDelay(6, {
//            print("6s", Thread.current)
//        }) {
//            print("6s", Thread.current)
//        }
        
    }

}



