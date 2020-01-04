/*
 错误处理
 
 - 错误类型
    - 语法错误（编译报错）
    - 逻辑错误
    - 运行时错误（可能会导致闪退，一般也叫异常）
    - ......
 
 - 自定义错误
    - Swift可以通过Error协议自定义运行时的错误信息
    - 函数内部通过throw抛出自定义Error，可能会抛出Error的函数必须加上throws声明
    - 需要使用try调用可能会抛出Error的函数
 
 - 处理Error
    - 通过do-catch捕捉Error
        - 抛出Error后，try下一句直到作用域结束的代码都将停止运行
    - 不捕捉Error，在当前函数增加throws声明，Error将自动抛给上层函数
        - 如果最顶层函数（main函数）依然没有捕捉Error，那么程序将终止
 
 - try?、try!
    - 可以使用try?、try!调用可能会抛出Error的函数，这样就不用去处理Error
 
 - rethrows
    - 函数本身不会抛出异常，但调用闭包参数抛出异常，那么它会将错误向上抛
 
 - defer
    - 用来定义以任何方式（抛错误、return等）离开代码块前必须要执行的代码
    - defer语句将延迟至当前作用域结束之前执行
    - defer语句的执行顺序与定义顺序相反
 */

enum SomeError: Error {
    case illegalArg(String)
    case outOfBounds(Int, Int)
    case outOfMemory
}

func divide(_ num1: Int, _ num2: Int) throws -> Int {
    if num2 == 0 {
        throw SomeError.illegalArg("0不能作为除数")
    }
    return num1 / num2
}

do {
    try divide(20, 0)
} catch let SomeError.illegalArg(msg) {
    print("参数异常：", msg)
} catch let SomeError.outOfBounds(size, index) {
    print("下标越界：", size, index)
} catch SomeError.outOfMemory {
    print("内存溢出")
} catch {
    print("其他异常")
}

func test() {
    print("1")
    print(try? divide(20, 10))
    print(try? divide(20, 0))
    print(try! divide(20, 10))
    print("2")
}
test()

var a = try? divide(20, 0)
var b: Int?
do {
    b = try divide(20, 0)
} catch {
    b = nil
}

func exec(_ fn: (Int, Int) throws -> Int, _ num1: Int, _ num2: Int) rethrows {
    print(try fn(num1, num2))
}

do {
    try exec(divide, 20, 0)
} catch {
    print("出错了")
}

func open(_ fileName: String) -> Int {
    print("open")
    return 0
}

func close(_ file: Int) {
    print("close")
}

func test1() throws {
    let file = open("gg")
    do {
        print(try divide(20, 0))
    } catch {
        print("hfhfhhfhhfh")
    }
    defer {
        close(file)
    }
}
try test1()

func fn1() { print("fn1") }
func fn2() { print("fn2") }
func test2() {
    defer {
        fn1()
    }
    defer {
        fn2()
    }
}
test2()

/*
 assert（断言）
 - 默认情况下，Swift断言只会在Debug模式下生效，Release模式下会忽略
    - 无法通过do-catch捕获
 - 增加Swift Flags可以修改断言的默认行为
    - -assert-config Release：强制关闭断言
    - -assert-config Debug：强制开启断言
 */

/*
 fatalError
 - 如果遇到严重问题，希望结束程序运行时，可以直接使用fatalError函数抛出错误
    - 无法通过do-catch捕获
    - 不需要再写return
 - 在某些不得不实现、但不希望别人调用的方法，可以考虑内部使用fatalError函数
 */

