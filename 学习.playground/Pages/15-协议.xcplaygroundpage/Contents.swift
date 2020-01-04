/*
 协议（Protocol）
 - 协议可以用来定义 方法、属性、下标 的声明，协议可以被 枚举、结构体、类 遵守（多个协议之间用逗号隔开）
 - 协议中定义方法时不能有默认参数值
 - 默认情况下，协议中定义的内容必须全部都实现
    - 也有方法只实现部分内容
 - 协议中定义属性必须用var关键字
 - 实现协议时的属性权限要不小于协议中定义的属性权限
    - 协议定义get、set，用 var存储属性 或 get、set计算属性 去实现
    - 协议定义get，用任何属性都可以实现
 - 为了保证通用，协议中必须用static定义类型方法、类型属性、类型下标
 
 mutating
 - 只有将协议中的实例方法标记为mutating
    - 才允许结构体、枚举的具体实现修改自身内存
    - 类在实现方法时不用加mutating，枚举、结构体才需要加mutating
 
 init
 - 协议中还可以定义初始化器init
    - 非final类实现时必须加上required
 - 如果从协议实现的初始化器，刚好是重写了父类的指定初始化器
    - 那么这个初始化器必须同时加required、override
 
 init?、init!
 - 协议中定义的init?、init!，可以用init、init?、init!去实现
 - 协议中定义的init，可以用init、init!去实现
 
 协议的继承
 - 一个协议可以继承其他协议
 
 协议组合
 - 协议组合，可以包含1个类类型（最多1个）
 
 CaseIterable
 - 让枚举遵守CaseIterable协议，可以实现遍历枚举值
 
 CustomStringConvertible
 - 遵守CustomStringConvertible, CustomDebugStringConvertible协议，可以自定义实例的打印字符串
 - print调用的是CustomStringConvertible协议的description
 - debugPrint调用的是CustomDebugStringConvertible协议的debugDescription
 
 Any、AnyObject
 - Swift提供了2种特殊的类型：Any、AnyObject
 - Any：可以代表任意类型（枚举、结构体、类，也包括函数类型）
 - AnyObject：可以代表任意类类型（在协议后面写上 : AnyObject 代表只有类能遵守这个协议）
    - 在协议后面写上 : class 也代表只有类能遵守这个协议
 
 is、as?、as!、as
 - is 用来判断是否为某种类型，as 用来做强制类型转换
 
 X.self、X.Type、AnyClass
 - X.self是一个元类型（metadata）的指针，metadata存放着类型相关信息
 - X.self属于X.Type类型
 
 Self
 - Self代表当前类型
 - Self一般用作返回值类型，限定返回值跟方法调用者必须是同一类型（也可以作为参数类型）
 */

protocol Drawable {
    func draw()
    var x: Int { get set }
    var y: Int { get }
    subscript(index: Int) -> Int { get set }
}

class Person: Drawable {
    func draw() {
        print("Person draw")
    }
    
    subscript(index: Int) -> Int {
        get { index }
        set {  }
    }
    
    var x: Int = 0
    var y: Int = 0
}

/*
 static
 */
protocol Drawable {
    static func draw()
}

class Person1: Drawable {
    class func draw() {
        print("Person1 draw")
    }
}

class Person2: Drawable {
    static func draw() {
        print("Person2 draw")
    }
}

struct Person3: Drawable {
    static func draw() {
        print("Person3 draw")
    }
}

/*
 mutating
 */
protocol Drawable {
    mutating func draw()
}

class Size: Drawable {
    var width: Int = 0
    func draw() {
        width = 10
    }
}

struct Point: Drawable {
    var x: Int = 0
    mutating func draw() {
        x = 10
    }
}

/*
 required
 */
protocol Drawable {
    init(x: Int, y: Int)
}

class Point: Drawable {
    required init(x: Int, y: Int) {

    }
}

final class Size: Drawable {
    init(x: Int, y: Int) {

    }
}

/*
 init
 */
protocol Livable {
    init(age: Int)
}

class Person {
    init(age: Int) {

    }
}

class Student: Person, Livable {
    required override init(age: Int) {
        super.init(age: age)
    }
}

/*
 init?、init!
 */
protocol Livable {
    init()
    init?(age: Int)
    init!(no: Int)
}

class Person: Livable {
//    required init?(age: Int) { }
//    required init(age: Int) { }
    required init!(age: Int) { }

//    required init!(no: Int) { }
//    required init(no: Int) { }
    required init?(no: Int) { }

//    required init() {}
    required init!() { }

}

/*
 协议继承
 */
protocol Runnable {
    func run()
}

protocol Livable: Runnable {
    func breath()
}

class Person: Livable {
    func breath() { }
    func run() { }
}

/*
 协议组合
 */
protocol Livable { }
protocol Runnable { }
class Person {}

func fn0(obj: Person) { }
func fn1(obj: Livable) { }
func fn2(obj: Livable & Runnable) { }
func fn3(obj: Person & Livable & Runnable) { }

typealias RealPerson = Person & Livable & Runnable
func fn4(obj: RealPerson) { }
/*
 CaseIterable
 */
enum Season: CaseIterable {
    case spring, summer, autumn, winter
}
let seasons = Season.allCases
print(seasons.count)
for season in seasons {
    print(season)
}

/*
 CustomStringConvertible
 */
class Person: CustomStringConvertible, CustomDebugStringConvertible {
    var age = 0
    var description: String { "person_\(age)" }
    var debugDescription: String { "debug_person_\(age)" }
}
var person = Person()
print(person)
debugPrint(person)

/*
 Any、AnyObject
 */
class Student {
    
}

var stu: Any = 10
stu = "Jack"
stu = Student()

var data = [Any]()
data.append(1)
data.append(3.14)
data.append("Jack")
data.append({10})
data.append(Student())
print(data)

/*
 is、as
 */
protocol Runnable {
    func run()
}
class Person {}
class Student: Person, Runnable {
    func run() {
        print("Student run")
    }
    func study() {
        print("Student study")
    }
}

var stu: Any = 10
print(stu is Int)
stu = "Jack"
print(stu is String)
stu = Student()
print(stu is Person)
print(stu is Student)
print(stu is Runnable)

print("=============")

stu = 10
(stu as? Student)?.study()
stu = Student()
(stu as? Student)?.study()
(stu as! Student).study()
(stu as? Runnable)?.run()

print("=============")

var data = [Any]()
data.append(Int("123") as Any)
print(data)

print("=============")

var d = 10 as Double
print(d)

/*
 X.self、X.Type、AnyClass
 */
class Person {}
class Student: Person {}
var perType: Person.Type = Person.self
var stuType = Student.self
print(perType)
print(stuType)
print("===========")
perType = Student.self
print(perType)

print("===========")

var anyType: AnyObject.Type = Person.self
anyType = Student.self

var anyType2: AnyClass = Person.self
anyType2 = Student.self

var per = Person()
var perT = type(of: per)
print(Person.self == perT)

/*
 Self
 */
protocol Runnable {
    func test() -> Self
}

class Person: Runnable {
    required init() { }
    func test() -> Self {
        type(of: self).init()
    }
}
class Student: Person {}
var p = Person()
print(p.test())

var stu = Student()
print(stu.test())

