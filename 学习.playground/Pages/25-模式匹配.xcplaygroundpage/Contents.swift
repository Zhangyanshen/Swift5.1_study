/*
 模式（Pattern）
 - 模式是用于匹配的规则，比如switch的case、捕捉错误的catch、if\guard\while\for语句的条件等
 */

/*
 1.通配符模式（Wildcard Pattern）
 - _：匹配任何值
 - _?：匹配非nil值
 */
enum Life {
    case human(name: String, age: Int?)
    case animal(name: String, age: Int?)
}

func check(_ life: Life) {
    switch life {
    case .human(let name, _):
        print("human", name)
    case .animal(let name, _?):
        print("animal", name)
    default:
        print("other")
    }
}

check(.human(name: "Jack", age: 10))
check(.human(name: "Jack", age: nil))
check(.animal(name: "Kobe", age: 22))
check(.animal(name: "Kobe", age: nil))

/*
 2.标识符模式（Identifier Pattern）
 - 给对应的变量、常量名赋值
 */
var a = 10
let str = "asdd"

/*
 3.值绑定模式（Value-Binding Pattern）
 */
let point = (3, 2)
switch point {
case let (x, y):
    print("The point is at (\(x), \(y))")
}

/*
 4.元组模式（Tuple Pattern）
 */
// ①
let points = [(1, 6), (2, 1), (10, 3)]
for (x, _) in points {
    print(x)
}

// ②
let name: String? = "Jack"
let age = 10
let info: Any = [1, 2]
switch (name, age, info) {
case (_?, _, _ as String):
    print("case")
default:
    print("other")
}

/*
 5.枚举Case模式（Enumeration Case Pattern）
 - if case语句等价于只有一个case的switch语句
 */
// ①
func test() {
    let age = 2
    if age >= 0 && age <= 9 {
        print("[0, 9]")
    }
    
    if case 0...9 = age {
        print("[0, 9]")
    }
    
    guard case 0...9 = age else { return }
    print("[0, 9]")
}

test()

// ②
let ages: [Int?] = [2, 3, nil, 6]
for case nil in ages {
    print("有nil")
    break
}

// ③
let points = [(1, 0), (2, 3), (10, 0)]
for case let (x, 0) in points {
    print(x)
}

/*
 6.可选模式（Optional Pattern）
 - x?表示不能为nil，等价于.some
 */
// ①
let age: Int? = 42
if case let x? = age { print(x) }
if case let .some(x) = age { print(x) }

// ②
let ages = [10, 22, nil, 34, nil]
for case let age? in ages {
    print(age)
}

/*
 7.类型转换模式（Type-Casting Pattern）
 */
// ①
let num: Any = 6
switch num {
//case is Int: // 只判断是否是Int
//    print("is Int", num)
case let n as Int: // 强转成Int
    print("as Int", n)
default:
    print("other")
}

/*
 8.表达式模式（Expression Pattern）
 - 表达式模式用在case中
 - 可以通过重载运算符 ~= 自定义匹配规则
 */
// ①
struct Student {
    var name = "", score = 0
    // pattern是case后面的内容
    // value是switch后面的内容
    static func ~= (pattern: Int, value: Student) -> Bool { value.score >= pattern }
    static func ~= (pattern: Range<Int>, value: Student) -> Bool { pattern.contains(value.score) }
    static func ~= (pattern: ClosedRange<Int>, value: Student) -> Bool { pattern.contains(value.score) }
}

var stu = Student(name: "Jack", score: 75)
switch stu {
case 100: print(">= 100")
case 90: print(">= 90")
case 80..<90: print("[80, 90)")
case 60...79: print("[60, 79]")
case 0: print(">= 0")
default: break
}

if case 60 = stu {
    print(">= 60")
}

var info = (Student(name: "Jack", score: 70), "及格")
switch info {
case let (60, text):
    print(text)
default:
    break
}

// ②
extension String {
    static func ~=(pattern: (String) -> Bool, value: String) -> Bool {
        pattern(value)
    }
}

func hasPrefix(_ prefix: String) -> ((String) -> Bool) { { $0.hasPrefix(prefix) } }
func hasSuffix(_ suffix: String) -> ((String) -> Bool) { { $0.hasSuffix(suffix) } }

var str = "jack"
switch str {
case hasPrefix("j"), hasSuffix("k"):
    print("以j开头 或者 以k结尾")
default:
    break
}

// ③
prefix operator ~>
prefix operator ~>=
prefix operator ~<
prefix operator ~<=
prefix func ~>(value: Int) -> ((Int) -> Bool) { { $0 > value } }
prefix func ~>=(value: Int) -> ((Int) -> Bool) { { $0 >= value } }
prefix func ~<(value: Int) -> ((Int) -> Bool) { { $0 < value } }
prefix func ~<=(value: Int) -> ((Int) -> Bool) { { $0 <= value } }

extension Int {
    static func ~=(pattern: (Int) -> Bool, value: Int) -> Bool {
        pattern(value)
    }
}

var age = 9
switch age {
case ~>=0:
    print("1")
case ~>10:
    print("2")
default: break
}

/*
 可以使用where为模式匹配增加匹配条件
 */
// ①.case
var data = (10, "Jack")
switch data {
case let (age, _) where age > 10:
    print(data.1, "age > 10")
case let (age, _) where age > 0:
    print(data.1, "age > 0")
default: break
}

// ②.for in
var ages = [10, 20, 44, 23, 55]
for age in ages where age > 30 {
    print(age)
}

// ③.protocol
protocol Stackable {
    associatedtype Element
}

protocol Container {
    associatedtype Stack: Stackable where Stack.Element: Equatable
}

func equal<S1: Stackable, S2: Stackable>(_ s1: S1, _ s2: S2) -> Bool where S1.Element == S2.Element, S1.Element: Hashable {
    return false
}

extension Container where Self.Stack.Element: Hashable {  }


