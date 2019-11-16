//
//  main.swift
//  TestSwift
//
//  Created by 张延深 on 2019/11/13.
//  Copyright © 2019 张延深. All rights reserved.
//

typealias Fn = (Int) -> (Int)

func getFn() -> Fn {
    var num = 0
    func plus(_ i: Int) -> Int {
        num += i
        return num
    }
    return plus
}

var fn = getFn()
print(fn(1))
print(fn(2))
print(fn(3))
print(fn(4))



