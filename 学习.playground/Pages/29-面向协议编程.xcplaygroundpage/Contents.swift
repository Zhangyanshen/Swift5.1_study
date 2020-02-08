/*
 1.面向协议编程（POP）
 */

/// 前缀类型
struct YS<Base> {
    var base: Base
    init(_ base: Base) {
        self.base = base
    }
}

/// 利用协议扩展前缀属性
protocol YSProtocol {}
extension YSProtocol {
    var ys: YS<Self> {
        set {}
        get { YS(self) }
    }
    static var ys: YS<Self>.Type {
        set {}
        get { YS.self }
    }
}

/// 给字符串扩展功能
// 让String拥有ys前缀
extension String: YSProtocol {}
// 扩展string ys的功能
extension YS where Base == String {
    var numberCount: Int {
        var count = 0
        for c in base where ("0"..."9").contains(c) {
            count += 1
        }
        return count
    }
    
    mutating func ttt() {
        
    }
    
    static func test() {
        print("test---")
    }
}

print("123wer12ed".ys.numberCount)
String.ys.test()
var str = "1111222eee"
str.ys.ttt()

class Person {
    var name = "Jack"
    var age = 20
}
extension Person: YSProtocol {}
extension YS where Base: Person {
    func test() {
        print("name:\(base.name), age:\(base.age)")
    }
}

var p = Person()
p.ys.test()

/*
 2.利用协议实现类型判断
 */
protocol ArrayType {}
extension Array: ArrayType {}
extension NSArray: ArrayType {}

func isArrayType(_ type: Any.Type) -> Bool {
    type is ArrayType.Type
}

print(isArrayType([Int].self))
print(isArrayType([Double].self))
print(isArrayType([Any].self))
print(isArrayType(NSArray.self))
print(isArrayType(NSMutableArray.self))
print(isArrayType(String.self))
