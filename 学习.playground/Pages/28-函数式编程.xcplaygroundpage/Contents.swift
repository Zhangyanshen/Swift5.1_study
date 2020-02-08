/*
 1.函数式编程（Functional Programming）
 - 是一种编程范式，也就是如何编写程序的方法论
    - 主要思想：把计算过程尽量分解成一系列可复用函数的调用
    - 主要特征：函数是“第一等公民”
        - 函数与其他数据类型一样的地位，可以赋值给其他变量，也可以作为函数参数、函数返回值
 - 函数式编程最早出现在LISP语言，绝大部分的现代编程语言对函数式编程做了不同程度的支持，比如
    - Haskell、JavaScript、Python、Swift、Kotlin、Scala等
 - 函数式编程中几个常用的概念：
    - Higher-Order Function、Function Currying
    - Functor、Applicative Functor、Monad
 */

func add(_ v: Int) -> (Int) -> Int { { $0 + v } }
func sub(_ v: Int) -> (Int) -> Int { { $0 - v } }
func multiple(_ v: Int) -> (Int) -> Int { { $0 * v } }
func divide(_ v: Int) -> (Int) -> Int { { $0 / v } }
func mod(_ v: Int) -> (Int) -> Int { { $0 % v } }

infix operator >>>: AdditionPrecedence
func >>><A, B, C>(_ f1: @escaping (A) -> B,
         _ f2: @escaping (B) -> C) -> (A) -> C
{
    { f2(f1($0)) }
}

var fn = add(3) >>> multiple(5) >>> sub(1) >>> mod(10) >>> divide(2)
var num = 1
print(fn(num))

/*
 2.高阶函数(High-Order Function)
 - 高阶函数是至少满足下列一个条件的函数：
    - 接收一个或多个函数作为输入（map、filter、reduce等）
    - 返回一个函数
 - FP中到处都是高阶函数
 */

func add(_ v: Int) -> (Int) -> Int { { $0 + v } }

/*
 3.科里化（Currying）
 - 将一个接收多参数的函数变换为一系列只接收单个参数的函数
 - Array、Optional的map方法接收的参数就是一个柯里化函数
 */

// 传统写法
func add(_ v1: Int, _ v2: Int) -> Int { v1 + v2 }
add(10, 20)

// 柯里化
func add(_ v: Int) -> (Int) -> Int {{ $0 + v }}
add(10)(20)
