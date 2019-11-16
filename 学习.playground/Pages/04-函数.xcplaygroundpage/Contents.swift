/*
 1.函数定义
 - 形参默认是let，也只能是let
 */
// 有返回值
func pi() -> Double {
    return 3.14
}
pi()
func sum(v1: Int, v2: Int) -> Int {
    return v1 + v2
}
sum(v1: 3, v2: 2)

// 无返回值
func noReturnFn() -> Void {
    
}

func noReturnFn1() -> () {
    
}

func noReturnFn2() {
    
}

// 隐式返回(只有一条语句时)
func sum1(v1: Int, v2: Int) -> Int {
    v1 + v2
}
sum1(v1: 10, v2: 20)

/*
 2.返回多个值（元组）
 */
func returnMultiValue() -> (Int, String) {
    return (404, "Not Found")
}
returnMultiValue()

/*
 3.函数的文档注释
 */
/// 概述
///
/// 具体描述
///
/// - Parameters:
///   - v1: 第一个参数
///   - v2: 第二个参数
///
/// - Returns: 返回值
///
func fnc(v1: Int, v2: String) -> String {
    return "\(v2) - \(v1)"
}

fnc(v1: 10, v2: "Hello World")

/*
 4.参数标签
 - 可以修改标签
 - 可以使用下划线_省略参数标签
 */
func goToWork(at time: String) {
    print("this time is \(time)")
}
goToWork(at: "08:00")

func sum2(_ v1: Int, _ v2: Int) -> Int {
    v1 + v2
}
sum2(20, 30)

/*
 5.默认参数值
 */
func check(name: String = "nobody", age: Int, job: String = "none") {
    print("name = \(name), age = \(age), job = \(job)")
}
check(name: "Rose", age: 20, job: "CEO")
check(name: "Jack", age: 30)
check(age: 40, job: "CTO")
check(age: 50)

/*
 6.可变参数
 - 一个函数最多只能有1个可变参数
 - 紧跟在可变参数后面的参数不能省略参数标签
 */
func sum3(_ numbers: Int...) -> Int {
    var total = 0
    for num in numbers {
        total += num
    }
    return total
}
sum3(10, 20, 30,40)

/*
 7.swift自带的print
 */
print(1, 2, 3)
print(1, 2, 3, separator: "")
print(1, 2, 3, separator: "", terminator: "")
print(20)

/*
 8.输入输出参数
 - 在函数内部修改外部实参的值
 - 可变参数不能标记为inout
 - inout参数不能有默认值
 - inout的本质是地址传递
 - inout参数只能传入可以被多次赋值的
 */
var number = 10
func add(_ num: inout Int) {
    num += 1
}
add(&number)

/*
 9.函数重载
 - 函数名相同
 - 参数个数不同 || 参数类型不同 || 参数标签不同
 - 返回值类型与函数重载无关
 - 默认参数值和函数重载一起使用产生二义性，编译器不会报错(在C++中会报错)
 */
func test(v1: Int, v2: Int) -> Int {
    v1 + v2
}
//func test(v1: Int, v2: Int, v3: Int) -> Int {
//    v1 + v2 + v3
//}
func test(v1: Double, v2: Double) -> Double {
    v1 + v2
}
func test(a: Int, v2: Int) -> Int {
    a + v2
}

func test(v1: Int, v2: Int, v3: Int = 10) -> Int {
    v1 + v2 + v3
}
test(v1: 10, v2: 20)

/*
 10.内联函数（inline function）
 - 如果开启了编译器优化，Swift编译器会将部分函数进行内联
 - 函数体太大时，不进行内联
 - 包含递归调用，不进行内联
 - 包含动态派发，不进行内联
 */

// 永远不被内联(即使开启了编译器优化)
@inline(never) func inlineNeverFunc() {
    
}

// 开启编译器优化后，即使代码很长，也会被内联（递归调用、动态派发函数除外）
@inline(__always) func inlineAlwaysFunc() {
    
}

/*
 11.函数类型
 - 函数类型由 形参类型、返回值类型 组成
 - 定义变量
 - 作为函数参数
 - 作为返回值类型
 */
var fn: (Int, Int) -> Int = sum
fn(1, 3) // 调用时不需要标签

func diffence(v1: Int, v2: Int) -> Int {
    v1 - v2
}

func printResult(mathFn: (Int, Int) -> Int, a: Int, b: Int) {
    print("result is \(mathFn(a, b))")
}

printResult(mathFn: diffence, a: 5, b: 4)
printResult(mathFn: sum, a: 5, b: 4)

func next(_ input: Int) -> Int {
    input + 1
}
func previous(_ input: Int) -> Int {
    input - 1
}
func forward(_ forward: Bool) -> (Int) -> Int {
    forward ? next : previous
}

forward(true)(3)
forward(false)(3)

/*
 12.typealias
 - 给类型起别名
 */
typealias Byte = Int8
typealias Date = (year: Int, month: Int, day: Int)
func myDate(_ date: Date) {
    print(date.year)
}
myDate((2019, 11, 13))

/*
 13.嵌套函数
 - 将函数定义在函数内部
 */
func forward1(_ forward: Bool) -> (Int) -> Int {
    func next(_ input: Int) -> Int {
        input + 1
    }
    func previous(_ input: Int) -> Int {
        input - 1
    }
    return forward ? next : previous
}

forward1(true)(3)
forward1(false)(3)



