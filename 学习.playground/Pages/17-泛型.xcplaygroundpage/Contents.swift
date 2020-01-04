/*
 泛型（Generics）
 - 泛型可以将类型参数化，提高代码复用率，减少代码量
 */
func swapValues<T>(_ a: inout T, _ b: inout T) {
    (a, b) = (b, a)
}

var i1 = 10
var i2 = 20
swapValues(&i1, &i2)
print(i1)
print(i2)

var d1 = 10.0
var d2 = 20.0
swapValues(&d1, &d2)
print(d1)
print(d2)

struct Date {
    var year = 0, month = 0, day = 0
}
var dd1 = Date(year: 2011, month: 9, day: 10)
var dd2 = Date(year: 2012, month: 10, day: 11)
swapValues(&dd1, &dd2)
print(dd1)
print(dd2)

class Stack<E> {
    var elements = [E]()
    func push(_ element: E) {
        elements.append(element)
    }
    
    func pop() -> E {
        elements.removeLast()
    }
    
    func top() -> E {
        elements.last!
    }
    
    func size() -> Int {
        elements.count
    }
}

var intStack = Stack<Int>()
intStack.push(10)
var doubleStack = Stack<Double>()
doubleStack.push(20.0)
var stringStack = Stack<String>()
stringStack.push("Hello World")


/*
 关联类型（Associated Type）
 - 给协议中用到的类型定义一个占位名称
    - 协议中可以有多个关联类型
 */
protocol Stackable {
    associatedtype Element
    mutating func push(_ element: Element)
    mutating func pop() -> Element
    func top() -> Element
    func size() -> Int
}

class StringStack: Stackable {
    var elements = [String]()
    func push(_ element: String) {
        elements.append(element)
    }
    func pop() -> String {
        elements.removeLast()
    }
    func top() -> String {
        elements.last!
    }
    func size() -> Int {
        elements.count
    }
}

var ss = StringStack()
ss.push("Jack")
ss.push("Rose")

/*
 不透明类型（Opaque Type）
 - 使用some来声明一个不透明类型
    - 只能返回一种类型
 */

/*
 可选项的本质
 - 可选项本质是enum
 */

var age: Int? = 10
var age0: Optional<Int> = Optional<Int>.some(10)
var age1: Optional = .some(10)
var age2 = Optional.some(10)
var age3 = Optional(10)
age = nil
age3 = .none

