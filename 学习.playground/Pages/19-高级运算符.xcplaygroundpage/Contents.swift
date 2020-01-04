/*
 溢出运算符（Overflow Operator）
 - Swift的算数运算符出现溢出时会抛出运行时错误
 - Swift有溢出运算符（&+、&-、&*），用来支持溢出运算
 */

var v1 = UInt8.max
var v2 = v1 &+ 1

/*
 运算符重载（Operator Overload）
 - 类、结构体、枚举都可以对现有运算符提供自定义实现
 */

struct Point {
    var x = 0, y = 0
    static func +(p1: Point, p2: Point) -> Point {
        Point(x: p1.x + p2.x, y: p1.y + p2.y)
    }
    static func -(p1: Point, p2: Point) -> Point {
        Point(x: p1.x - p2.x, y: p1.y - p2.y)
    }
    static prefix func -(p: Point) -> Point {
        Point(x: -p.x, y: -p.y)
    }
    static func +=(p1: inout Point, p2: Point) {
        p1 = p1 + p2
    }
    static prefix func ++(p: inout Point) -> Point {
        p += Point(x: 1, y: 1)
        return p
    }
    static postfix func ++(p: inout Point) -> Point {
        let tmp = p
        p += Point(x: 1, y: 1)
        return tmp
    }
}

var p1 = Point(x: 10, y: 20)
var p2 = Point(x: 20, y: 30)
print(p1 + p2)
print(p1 - p2)
print(-p1)
p1 += p2
print(p1)
var p3 = p1++
print(p1, p3)
p3 = ++p1
print(p1, p3)

/*
 Equatable
 - 要想得知2个实例是否等价，一般做法是遵守Equatable协议，重载 == 运算符
    - 与此同时，等价于重载了 != 运算符
 - Swift为以下类型提供默认的Equatable实现
    - 没有关联类型的枚举
    - 只拥有遵守Equatable协议关联类型的枚举
    - 只拥有遵守Equatable协议存储属性的结构体
 - 引用类型比较存储的地址值是否相等（是否引用同一个对象），使用恒等运算符 ===、!==
 */

class Person: Equatable {
    var age: Int
    init(age: Int) {
        self.age = age
    }
    static func == (lhs: Person, rhs: Person) -> Bool {
        lhs.age == rhs.age
    }
}

var p11 = Person(age: 10)
var p22 = Person(age: 10)
p11 == p22

p11 === p22

enum Answer {
    case right, wrong
}
var s1 = Answer.wrong
var s2 = Answer.right
s1 == s2

/*
 Comparable
 - 要想比较2个实例的大小，一般做法是遵守Comparable协议，并重载相应的运算符
 - Comparable协议继承Equatable协议
 */

struct Student: Comparable {
    var age: Int
    var score: Int
    init(age: Int, score: Int) {
        self.age = age
        self.score = score
    }
    static func < (lhs: Self, rhs: Self) -> Bool {
        (lhs.score < rhs.score) || (lhs.score == rhs.score && lhs.age > rhs.age)
    }
    static func > (lhs: Self, rhs: Self) -> Bool {
        (lhs.score > rhs.score) || (lhs.score == rhs.score && lhs.age < rhs.age)
    }
    static func <= (lhs: Self, rhs: Self) -> Bool {
        !(lhs > rhs)
    }
    static func >= (lhs: Self, rhs: Self) -> Bool {
        !(lhs < rhs)
    }
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.score == rhs.score && lhs.age == rhs.age
    }
}

var stu1 = Student(age: 100, score: 20)
var stu2 = Student(age: 98, score: 18)
var stu3 = Student(age: 100, score: 20)
print(stu1 > stu2)
print(stu1 >= stu2)
print(stu1 >= stu3)
print(stu1 <= stu3)
print(stu2 < stu1)
print(stu2 <= stu1)
print(stu1 == stu3)

/*
 自定义运算符（Custom Operator）
 - 可以自定义新的运算符：在 全局作用域 使用 operator 进行声明
    - prefix operator 前缀运算符
    - postfix operator 后缀运算符
    - infix operator 中缀运算符 : 优先级组
 - 优先级组
    precedencegroup 优先级组名称 {
        associativity: 结合性(right\right\none)
        higherThan: 比谁的优先级高(如：AdditionPrecedence)
        lowerThan: 比谁的优先级低(如：MultiplicationPrecedence)
        assignment: true代表在可选链操作中拥有跟赋值运算符一样的优先级
    }
 */

prefix operator +++

prefix func +++ (_ i: inout Int) {
    i += 2
}

var age = 10
+++age
print(age)

precedencegroup PlusMinusPrecedence {
    associativity: right
    higherThan: AdditionPrecedence
    lowerThan: MultiplicationPrecedence
    assignment: true
}

infix operator +- : PlusMinusPrecedence

struct Point {
    var x = 0
    var y = 0
    static func +- (left: Self, right: Self) -> Self {
        self.init(x: left.x + right.x, y: left.y - right.y)
    }
    static func +- (left: Self?, right: Self) -> Self {
        print("+-")
        return Point(x: left?.x ?? 0 + right.x, y: left?.y ?? 0 - right.y)
    }
}

var p1 = Point(x: 10, y: 20)
var p2 = Point(x: 5, y: 15)
print(p1 +- p2 +- p2)

struct Person {
    var point: Point = Point(x: 10, y: 10)
}

var person: Person? = nil
person?.point +- Point(x: 10, y: 20)

person = Person()
person?.point +- Point(x: 10, y: 20)





