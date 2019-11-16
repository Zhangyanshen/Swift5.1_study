import Foundation
/*
 1.结构体
 - 在Swift标准库中，绝大多数的公开类型都是结构体，而枚举和类只占了很小一部分
 - 比如Bool、Int、Double、String、Array、Dictionary等常见类型都是结构体
 - 所有结构体都有一个编译器自动生成的初始化器（initializeer，初始化方法、构造器、构造方法）
 - 编译器会根据情况，可能会生成多个初始化器，宗旨是：保证所有成员都有初始值
 - 一旦自定义了初始化器，编译器就不会帮你自动生成其他初始化器了
 */
struct Date {
    var year: Int
    var month: Int
    var day: Int
}

var date = Date(year: 2019, month: 11, day: 15)

/*
 2.类
 - 类的定义和结构体类似，但编译器并没有为类自动生成可以传入成员值的初始化器
 */
class Point {
    var x: Int = 0
    var y: Int = 0
}
var point = Point()

/*
 3.结构体和类的本质区别
 - 结构体是值类型（枚举也是值类型），类是引用类型（指针类型）
 （1）值类型
    - 值类型赋值给var、let或者给函数传参，是直接将所有内容拷贝一份，属于深拷贝（deep copy）
    - 在Swift标准库中，为了提高性能，String、Array、Dictionary、Set采取了Copy On Write（写时拷贝）
    - 我们自己定义的结构体都是深拷贝
    - 建议：不需要修改的，尽量定义成let
 （2）引用类型
    - 值类型赋值给var、let或者给函数传参，是将内存地址拷贝一份，属于浅拷贝（shallow copy）
 */

var date1 = Date(year: 2019, month: 11, day: 15)
var date2 = date1
date2.year = 2020
print(date1.year, date1.month, date1.day)
print(date2.year, date2.month, date2.day)

var s1 = "Jack"
var s2 = s1
s2.append("_Rose")
print(s1)
print(s2)

var a1 = [1, 2, 3]
var a2 = a1
a2.append(4)
a1[0] = 2
print(a1)
print(a2)

var d1 = ["max": 10, "min": 2]
var d2 = d1
d1["other"] = 7
d2["max"] = 22
print(d1)
print(d2)

/*
 4.寄存器
 rip + 内存地址：全局变量
 rbp - 内存地址：局部变量
 rax + 内存地址：堆空间
 rax：函数返回值
 rdi、rsi、rdx、rcx、r8、r9存放函数参数
 rsp、rbp：栈操作
 */

// 在Mac、iOS中的malloc函数分配的内存大小总是16的倍数
var ptr = malloc(16)
print(malloc_size(ptr))

/*
 值类型、引用类型的let
 */
struct Point1 {
    var x: Int
    var y: Int
}

struct Size {
    var width: Int
    var height: Int
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
}

let p = Point1(x: 10, y: 20)
//p = Point1(x: 11, y: 22) // 报错
//p.x = 11 // 报错
//p.y = 22 // 报错

let s = Size(width: 10, height: 20)
//s = Size(width: 11, height: 22) // 报错
//s.width = 11 // playground报错，正常项目不报错
//s.height = 22 // playground报错，正常项目不报错

