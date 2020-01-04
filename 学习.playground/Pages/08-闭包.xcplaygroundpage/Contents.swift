/*
 1.闭包表达式(Closure Expression)
 - 在Swift中，可以通过 func 定义一个函数，也可以通过闭包表达式定义一个函数
    {
        (参数列表) -> 返回值类型 in
        函数体代码
    }
 - in 用来区分参数列表返回值类型和函数体代码
 */
var fn = {
    (v1: Int, v2: Int) -> Int in
    return v1 + v2
}
fn(10, 20)

/*
 2.闭包表达式的简写
 */
func exec(v1: Int, v2: Int, fn: (Int, Int) -> Int) {
    print(fn(v1, v2))
}

exec(v1: 10, v2: 20, fn: {
    (v1: Int, v2: Int) -> Int in
    return v1 + v2
})

exec(v1: 10, v2: 20, fn: {
    v1, v2 in return v1 + v2
})

exec(v1: 10, v2: 20, fn: {
    v1, v2 in v1 + v2
})

exec(v1: 10, v2: 20, fn: { $0 + $1 })

exec(v1: 10, v2: 20, fn: +)

/*
 3.尾随闭包
 - 如果将一个很长的闭包表达式作为函数的最后一个实参，使用尾随闭包可以增强函数的可读性
    - 尾随闭包是一个被书写在函数调用括号外面（后面）的闭包表达式
 - 如果闭包表达式是函数的唯一实参，而且使用了尾随闭包的语法，那就不需要在函数名后边写圆括号
 */

exec(v1: 10, v2: 20) { (v1, v2) -> Int in
    return v1 + v2
}

exec(v1: 10, v2: 20) { $0 + $1 }

func exec1(v1: Int, fn: (Int, Int) -> Int, v2: Int) {
    print(fn(v1, v2))
}

// 如果闭包不是最后一个参数，则不能使用尾随闭包
exec1(v1: 10, fn: { $0 + $1 }, v2: 20)

func exec2(fn: (Int, Int) -> Int) {
    print(fn(10, 20))
}

exec2 { $0 + $1 }

var arr = [1, 10, 11, 77]
arr.sort { $0 > $1 }
print(arr)

/*
 4.闭包(Closure)
 - 一个函数和它所捕获的变量\常量环境组合起来，成为闭包
    - 一般指定义在函数内部的函数
    - 一般它捕获的是外层函数的局部变量\常量
 - 可以把闭包想象成类的实例变量
    - 内存在堆空间
    - 捕获的局部变量\常量就是对象的成员(存储属性)
    - 组成闭包的函数就是类内部定义的方法
 */

/*
 5.自动闭包
 - @autoclosure
 - 编译器帮你封装成闭包表达式
 - 只支持 () -> T 格式的参数
 - 不是只支持最后一个参数
 - 空合并运算符 ?? 使用了自动闭包
 - 有@autoclosure和无@autoclosure构成函数重载
 */


