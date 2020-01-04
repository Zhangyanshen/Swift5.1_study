//
//  main.swift
//  TestiOS
//
//  Created by 张延深 on 2020/1/2.
//  Copyright © 2020 张延深. All rights reserved.
//

import UIKit

class YSApplication: UIApplication {}

UIApplicationMain(CommandLine.argc,
                  CommandLine.unsafeArgv,
                  NSStringFromClass(YSApplication.self),
                  NSStringFromClass(AppDelegate.self))

enum R {
    enum image {
        static var logo = UIImage(named: "logo")
    }
    enum font {
        static func arial(_ size: CGFloat) -> UIFont? {
            UIFont(name: "Arial", size: size)
        }
    }
}

let img = R.image.logo
let font = R.font.arial(14)
