/*
 字面量
 */
var a = 10
var b = true
var c = "str"

/*
 字面量协议
 - Swift自带类型之所以能够通过字面量来初始化，是因为他们遵守了对应的协议
    - Int: ExpressibleByIntegerLiteral
    - Float、Double: ExpressibleByFloatLiteral
    - ...
 */

/*
 字面量协议应用
 */
// ①.Int遵守Bool协议
extension Int: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Bool) {
        self = value ? 1 : 0
    }
}
var num: Int = true
print(num)
num = false
print(num)

// ②.类遵守相应协议
class Student: ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral, ExpressibleByStringLiteral, CustomStringConvertible {
    var name = ""
    var score = 0.0
    required init(integerLiteral value: Int) {
        self.score = Double(value)
    }
    required init(floatLiteral value: Double) {
        self.score = value
    }
    required init(stringLiteral value: String) {
        self.name = value
    }
    var description: String {
        "name=\(name), score=\(score)"
    }
}
var stu: Student = 98
print(stu)
stu = 88.6
print(stu)
stu = "Jack"
print(stu)
stu = "🐂"
print(stu)

// ③
struct Point {
    var x = 0.0, y = 0.0
}

extension Point: ExpressibleByArrayLiteral, ExpressibleByDictionaryLiteral {
    init(arrayLiteral elements: Double...) {
        guard elements.count > 0 else { return }
        x = elements[0]
        guard elements.count > 1 else { return }
        y = elements[1]
    }
    init(dictionaryLiteral elements: (String, Double)...) {
        for (k, v) in elements {
            if k == "x" { x = v }
            else if k == "y" { y = v }
        }
    }
}

var p: Point = [10.5, 12.4]
print(p)
p = ["x": 12.11, "y": 1.23]
print(p)

