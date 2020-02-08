//
//  main.swift
//  TestSwift
//
//  Created by 张延深 on 2019/11/13.
//  Copyright © 2019 张延深. All rights reserved.
//

//import Dispatch
//import Foundation

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

//func isArray(_ value: Any) -> Bool {
//    value is [Any]
//}
//
//print(isArray([1, 2]))
//print(isArray(["1", 2]))
//print(isArray(NSArray()))
//print(isArray(NSMutableArray()))
//print(isArray("123edr"))

//struct YS<Base> {
//    var base: Base
//    init(_ base: Base) {
//        self.base = base
//    }
//}
//
//protocol YSProtocol {}
//extension YSProtocol {
//    var ys: YS<Self> {
//        set {}
//        get {
//            YS(self)
//        }
//    }
//    static var ys: YS<Self>.Type {
//        set {}
//        get {
//            YS.self
//        }
//    }
//}
//
//extension String: YSProtocol {}
//extension NSString: YSProtocol {}
//extension YS where Base: ExpressibleByStringLiteral {
//    var numberCount: Int {
//        var count = 0
//        for c in (base as! String) where ("0"..."9").contains(c) {
//            count += 1
//        }
//        return count
//    }
//}
//
//var str1 = "123wer12ed"
//var str2: NSString = "123wer12ed"
//var str3: NSMutableString = "123wer12ed"
//print(str1.ys.numberCount)
//print(str2.ys.numberCount)
//print(str3.ys.numberCount)

//func add(_ v1: Int, _ v2: Int) -> Int { v1 + v2 }
//func sub(_ v1: Int, _ v2: Int) -> Int { v1 - v2 }
//func multiple(_ v1: Int, _ v2: Int) -> Int { v1 * v2 }
//func divide(_ v1: Int, _ v2: Int) -> Int { v1 / v2 }
//func mod(_ v1: Int, _ v2: Int) -> Int { v1 % v2 }
//prefix operator ~
//prefix func ~<A, B, C>(_ fn: @escaping (A, B) -> C) -> (B) -> (A) -> C {
//    {b in { a in fn(a, b) }}
//}
//print((~add)(10)(20))
//print((~sub)(10)(20))
//print((~multiple)(10)(20))
//print((~divide)(10)(20))
//print((~mod)(10)(20))

//func add(_ v1: Int, _ v2: Int, _ v3: Int) -> Int { v1 + v2 + v3 }
//func add(_ v3: Int) -> (Int) -> (Int) -> Int {
//    return {
//        v2 in
//        return {
//            v1 in
//            return v1 + v2 + v3
//        }
//    }
//}
//
//print(add(10, 20, 30))
//print(add(30)(20)(10))

//func add(_ v: Int) -> (Int) -> Int { { $0 + v } }
//func sub(_ v: Int) -> (Int) -> Int { { $0 - v } }
//func multiple(_ v: Int) -> (Int) -> Int { { $0 * v } }
//func divide(_ v: Int) -> (Int) -> Int { { $0 / v } }
//func mod(_ v: Int) -> (Int) -> Int { { $0 % v } }
//
//infix operator >>>: AdditionPrecedence
//func >>><A, B, C>(_ f1: @escaping (A) -> B,
//         _ f2: @escaping (B) -> C) -> (A) -> C
//{
//    { f2(f1($0)) }
//}
//
//var fn = add(3) >>> multiple(5) >>> sub(1) >>> mod(10) >>> divide(2)
//var num = 1
//print(fn(num))

//struct Person {
//    var name: String
//    var age: Int
//    init?(_ json: [String: Any]) {
//        guard let name = json["name"] as? String,
//              let age = json["age"] as? Int
//        else { return nil }
//        self.name = name
//        self.age = age
//    }
//}
//
//var json: Dictionary? = ["name": "Jack", "age": 10]
//var p1 = json != nil ? Person(json!) : nil
//var p2 = json.flatMap(Person.init)

//var score: Int? = nil
//var str1 = score != nil ? "Score is \(score!)" : "No score"
//print(str1)
//var str2 = score.map { "score is \($0)" } ?? "No score"
//print(str2)

//var fmt = DateFormatter()
//fmt.dateFormat = "yyyy-MM-dd"
//var str: String? = "2019-12-12"
//var date1 = str != nil ? fmt.date(from: str!) : nil
//print(date1)
//var date2 = str.flatMap { fmt.date(from: $0) }
//print(date2)
//var date3 = str.flatMap(fmt.date)
//print(date3)

//var num1: Int? = 10
//// Optional(20)
//var num2 = (num1 != nil) ? (num1! + 10) : nil
//print(num2)
//// Optional(20)
//var num3 = num1.map { $0 + 10 }
//print(num3)

//var num1: Int? = 10
//// Optional(Optional(20))
//var num2 = num1.map { Optional.some($0 * 2) }
//print(num2)
//// Optional(20)
//var num3 = num1.flatMap { Optional.some($0 * 2) }
//print(num3)

//var num1: Int? = 10
//// Optional(20)
//var num2 = num1.map { $0 * 2 }
//print(num2)
//
//var num3: Int? = nil
//// nil
//var num4 = num3.map { $0 * 2 }
//print(num4)

//let arr = [1, 2, 3]
//let result = arr.lazy.map {
//    (i : Int) -> Int in
//    print("mapping \(i)")
//    return i * 2
//}
//
//print("begin------")
//for i in result {
//    print("mapped", i)
//}
//print("end------")

//var arr = [1, 2, 3, 4]
//// [2, 4, 6, 8]
//print(arr.map { $0 * 2 })
//print(arr.reduce([]) { $0 + [$1 * 2] })
//// [2, 4]
//print(arr.filter { $0 % 2 == 0 })
//print(arr.reduce([]) { $1 % 2 == 0 ? $0 + [$1] : $0 })

//var arr = ["123", "test", "jack", "-30"]
//// [Optional(123), nil, nil, Optional(-30)]
//var arr2 = arr.map { Int($0) }
//print(arr2)
//// [123, -30]
//var arr3 = arr.compactMap { Int($0) }
//print(arr3)

//var arr = [1, 2, 3]
//// [[1], [2, 2], [3, 3, 3]]
//var arr2 = arr.map { Array.init(repeating: $0, count: $0) }
//print(arr2)
//// [1, 2, 2, 3, 3, 3]
//var arr3 = arr.flatMap { Array.init(repeating: $0, count: $0) }
//print(arr3)

//func double(_ i: Int) -> Int { i * 2 }
//var arr = [1, 2, 3, 4]
//var arr2 = arr.map(double)
//print(arr2)

//var arr = [1, 2, 3, 4]
//
//var arr2 = arr.map { $0 * 2 }
//print(arr2, arr)
//
//var arr3 = arr.filter { $0 % 2 == 0 }
//print(arr3)
//
//var arr4 = arr.reduce(0) { $0 + $1 }
//print(arr4)
//
//var arr5 = arr.reduce(1, +)
//print(arr5)


//class Person {}
//extension Person {
//    private static var AGE_KEY: Void?
//    var age: Int {
//        get {
//            (objc_getAssociatedObject(self, &Self.AGE_KEY) as? Int) ?? 0
//        }
//        set {
//            objc_setAssociatedObject(self, &Self.AGE_KEY, newValue, .OBJC_ASSOCIATION_ASSIGN)
//        }
//    }
//}
//
//var p = Person()
//print(p.age)
//p.age = 10
//print(p.age)

//class Person: NSObject {
//    @objc dynamic var age = 0
//    var observation: NSKeyValueObservation?
//    override init() {
//        super.init()
//        observation = observe(\Person.age, options: .new, changeHandler: { (person, change) in
//            print(change.newValue as Any)
//        })
//    }
//}
//
//var p = Person()
//p.age = 20
//p.setValue(25, forKey: "age")

//class Observer: NSObject {
//    override func observeValue(forKeyPath keyPath: String?,
//                               of object: Any?,
//                               change: [NSKeyValueChangeKey : Any]?,
//                               context: UnsafeMutableRawPointer?)
//    {
//        print("observeValue", change?[.newKey] as Any)
//    }
//}
//
//class Person: NSObject {
//    @objc dynamic var age: Int = 0
//    var name: String = "jack"
//    var observer = Observer()
//    override init() {
//        super.init()
//        self.addObserver(observer, forKeyPath: "age", options: .new, context: nil)
//    }
//    deinit {
//        self.removeObserver(observer, forKeyPath: "age")
//    }
//}
//
//var p = Person()
//p.age = 20 // observeValue Optional(20)
//p.setValue(25, forKey: "age") // observeValue Optional(25)
//p.name = "rose" // 无打印
//p.setValue("jordan", forKey: "name") // 崩溃

//class Dog: NSObject {
//    @objc dynamic func test1() {}
//    func test2() {}
//}
//
//var d = Dog()
//d.test1() // objc_msgSend()
//d.test2() // 虚表

//protocol Runnable {
//    func run1()
//    func run2()
//    func run3()
//}
//
//extension Runnable {
//    func run2() {
//
//    }
//}
//
//class Dog: Runnable {
//    func run3() {
//        print("Dog run3")
//    }
//
//    func run1() {
//        print("Dog run1")
//    }
//}
//
//var d = Dog()
//d.run1()
//d.run3()

//protocol Runnable1: AnyObject {}
//protocol Runnable2: class {}
//@objc protocol Runnable3 {}
//
//struct Person: Runnable1 {}
//class Student: Runnable1 {}

//var str1: String = "jack"
//var str2: String = "rose"
//
//var str3 = str1 as NSString
//var str4 = str2 as NSString
//
//var str5 = str3.substring(with: NSRange(location: 0, length: 2))
//print(str5)

//let str = """
//1
//        "2"
//3
//        '4'
//"""
//print(str)

//for c in "jack" {
//    // c是Character类型
//    print(c)
//}
//
//var str = "jack"
//// c是Character类型
//var c = str[str.startIndex]

//var str = "1_2_3_4_5"
//var substr1 = str.prefix(3)
//print(substr1)
//var substr2 = str.suffix(3)
//print(substr2)
//var range = str.startIndex ..< str.index(str.startIndex, offsetBy: 3)
//var substr3 = str[range]
//print(substr3)
//
//// 最初的String
//print(substr3.base)
//
//var str2 = String(substr3)

//var str = "1_2"
//str.insert("_", at: str.endIndex)
//print(str)
//str.insert(contentsOf: "3_4", at: str.endIndex)
//print(str)
//str.insert(contentsOf: "666", at: str.index(after: str.startIndex))
//print(str)
//str.insert(contentsOf: "888", at: str.index(before: str.endIndex))
//print(str)
//str.insert(contentsOf: "hello", at: str.index(str.startIndex, offsetBy: 4))
//print(str)
//
//str.remove(at: str.firstIndex(of: "1")!)
//print(str)
//str.removeAll {
//    (ch) -> Bool in
//    return ch == "6"
//}
//print(str)
//var range = str.index(str.endIndex, offsetBy: -4) ..< str.index(before: str.endIndex)
//str.removeSubrange(range)
//print(str)

//var emptyStr1 = ""
//var emptyStr2 = String()
//
//var str: String = "1"
//// 拼接
//str.append("_2")
//// 重载运算符 +
//str = str + "_3"
//// 重载运算符 +=
//str += "_4"
//// 插值 \()
//str = "\(str)_5"
//// 长度
//print(str.count)

//var str = "123456"
//print(str.hasPrefix("123"))
//print(str.hasSuffix("456"))

//@objcMembers class Person: NSObject {
//    func test1(v1: Int) { print("test1") }
//    func test2(v1: Int, v2: Int) { print("test2(v1:v2:)") }
//    func test2(_ v1: Double, _ v2: Double) { print("test2(_:_:)") }
//    func run() {
//        perform(#selector(test1))
//        perform(#selector(test2(_:_:)))
//        perform(#selector(test2(v1:v2:)))
//        perform(#selector(test2 as (Double, Double) -> Void))
//    }
//}
//
//var person = Person()
//person.run()
//
//@objc(YSCar)
//@objcMembers class Car: NSObject {
//    var price: Double
//    @objc(name)
//    var band: String
//    init(price: Double, band: String) {
//        self.price = price
//        self.band = band
//    }
//    @objc(drive)
//    func run() { print(price, band, "run") }
//    static func run() { print("Car run") }
//}
//
//extension Car {
//    func test() { print(price, band, "test") }
//    override var description: String {
//        get {
//            "\(band), \(price)"
//        }
//    }
//}
//
////testSwift()
//
//func sum(_ a: Int, _ b: Int) -> Int { a - b }
//
//var p = YSPerson(age: 10, name: "Jack")
//p.age = 18
//p.name = "Rose"
//p.run()
//p.eat("Apple", other: "Water")
//
//YSPerson.run()
//YSPerson.eat("Pizza", other: "Banana")
//
//@_silgen_name("sum")
//func swift_sum(_ a: Int, _ b: Int) -> Int
//
//print(swift_sum(10, 20))
//print(sum(10, 20))

//@available(iOS 10, macOS 10.15, *)
//class Person {}
//
//struct Student {
//
//    #warning("TODO")
//    @available(*, unavailable, renamed: "study")
//    func study_() {}
//    func study() {}
//
//    @available(iOS, deprecated: 11)
//    @available(macOS, deprecated: 10.12)
//    func run() {}
//}
//
//var stu = Student()
//stu.run()
//stu.study()

//log(20)
//
//if #available(iOS 10, macOS 10.12, *) {
//    // 对于iOS平台，只在iOS 10及以上版本执行
//    // 对于macOS平台，只在macOS 10.12及以上版本执行
//    // 最后的*表示在其他所有平台可执行
//}

//#if TEST
//print("TEST")
//#endif
//
//#if OTHER
//print("OTHER")
//#endif

//#if DEBUG
//print("Debug")
//#else
//print("Release")
//#endif

//// 操作系统：macOS\iOS\tvOS\watchOS\Linux\Android\Windows\FreeBSD
//#if os(macOS) || os(iOS)
//print("macOS || iOS")
//#endif
//// CPU架构：i386\x86_64\arm\arm64
//#if arch(x86_64) || arch(arm64)
//print("x86_64 || arm64")
//#endif
//// swift版本
//#if swift(<5) && swift(>=3)
//print("swift >= 3")
//#endif
//// 模拟器
//#if targetEnvironment(simulator)
//print("simulator")
//#endif
//// 可以导入某个模块
//#if canImport(Foundation)
//print("canImport(Foundation)")
//#endif

//func test() {
//    // TODO: 未完成
//}
//
//func test1() {
//    var age = 10
//    // FIXME: 有待修复
//    age += 10
//}

//protocol Stackable {
//    associatedtype Element
//}
//
//protocol Container {
//    associatedtype Stack: Stackable where Stack.Element: Equatable
//}
//
//func equal<S1: Stackable, S2: Stackable>(_ s1: S1, _ s2: S2) -> Bool where S1.Element == S2.Element, S1.Element: Hashable {
//    return false
//}
//
//extension Container where Self.Stack.Element: Hashable {  }

//var ages = [10, 20, 44, 23, 55]
//for age in ages where age > 30 {
//    print(age)
//}

//var data = (10, "Jack")
//switch data {
//case let (age, _) where age > 10:
//    print(data.1, "age > 10")
//case let (age, _) where age > 0:
//    print(data.1, "age > 0")
//default: break
//}

//prefix operator ~>
//prefix operator ~>=
//prefix operator ~<
//prefix operator ~<=
//prefix func ~>(value: Int) -> ((Int) -> Bool) { { $0 > value } }
//prefix func ~>=(value: Int) -> ((Int) -> Bool) { { $0 >= value } }
//prefix func ~<(value: Int) -> ((Int) -> Bool) { { $0 < value } }
//prefix func ~<=(value: Int) -> ((Int) -> Bool) { { $0 <= value } }
//
//extension Int {
//    static func ~=(pattern: (Int) -> Bool, value: Int) -> Bool {
//        pattern(value)
//    }
//}
//
//var age = 90
//switch age {
//case ~>=0:
//    print("1")
//case ~>10:
//    print("2")
//default: break
//}

//extension String {
//    static func ~=(pattern: (String) -> Bool, value: String) -> Bool {
//        pattern(value)
//    }
//}
//
//func hasPrefix(_ prefix: String) -> ((String) -> Bool) { { $0.hasPrefix(prefix) } }
//func hasSuffix(_ suffix: String) -> ((String) -> Bool) { { $0.hasSuffix(suffix) } }
//
//var str = "jack"
//switch str {
//case hasPrefix("j"), hasSuffix("k"):
//    print("以j开头 或者 以k结尾")
//default:
//    break
//}

//var ptr = UnsafeMutableRawPointer.allocate(byteCount: 16, alignment: 1)
//unsafeBitCast(ptr, to: UnsafeMutablePointer<Int>.self).pointee = 11
//print(ptr.load(as: Int.self))
//ptr.deallocate()

//var ptr = UnsafeMutableRawPointer.allocate(byteCount: 16, alignment: 1)
//ptr.assumingMemoryBound(to: Int.self).pointee = 11
//(ptr + 8).assumingMemoryBound(to: Int.self).pointee = 22
//ptr.deallocate()

//var ptr = UnsafeMutablePointer<Int>.allocate(capacity: 3)
//ptr.initialize(to: 10)
//ptr.successor().initialize(to: 20)
//ptr.successor().successor().initialize(to: 30)
//
//print(ptr.pointee)
//print((ptr + 1).pointee)
//print((ptr + 2).pointee)
//
//print(ptr[0])
//print(ptr[1])
//print(ptr[2])
//
//print(ptr.pointee)
//print(ptr.successor().pointee)
//print(ptr.successor().successor().pointee)
//
//ptr.deinitialize(count: 3)
//ptr.deallocate()

//// 创建指针
//var ptr = UnsafeMutableRawPointer.allocate(byteCount: 16, alignment: 1)
//// 存
//ptr.storeBytes(of: 11, as: Int.self)
//ptr.advanced(by: 8).storeBytes(of: 22, as: Int.self)
//// 取
//print(ptr.load(as: Int.self))
//print(ptr.advanced(by: 8).load(as: Int.self))
//// 销毁指针
//ptr.deallocate()

//// 创建指针
//var ptr = malloc(16)
//// 存
//ptr?.storeBytes(of: 10, as: Int.self)
//ptr?.storeBytes(of: 20, toByteOffset: 8, as: Int.self)
//// 取
//print(ptr?.load(as: Int.self) ?? "")
//print(ptr?.load(fromByteOffset: 8, as: Int.self) ?? "")
//// 销毁指针
//free(ptr)

//class Person {
//    var age: Int
//    init(age: Int) {
//        self.age = age
//    }
//}
//
//var person = Person(age: 20)
//var ptr = withUnsafePointer(to: &person) { UnsafeRawPointer($0) }
//var personObjAddress = ptr.load(as: UInt.self)
//var ptr2 = UnsafeRawPointer(bitPattern: personObjAddress)
//print(ptr)
//print(ptr2 ?? "")

//var age = 10
//var ptr = withUnsafePointer(to: &age) { $0 }
//var ptr2 = withUnsafeMutablePointer(to: &age) { $0 }
//
//print(ptr.pointee)
//
//ptr2.pointee = 30
//
//print(age)
//
//var ptr3 = withUnsafeMutablePointer(to: &age) { UnsafeMutableRawPointer($0) }
//var ptr4 = withUnsafePointer(to: &age) { UnsafeRawPointer($0) }
//ptr3.storeBytes(of: 33, as: Int.self)
//print(ptr4.load(as: Int.self))
//print(age)

//var arr = NSArray(objects: 11, 22, 33, 44)
//
//for (idx, element) in arr.enumerated() {
//    if idx == 2 {
//        break
//    }
//    print(idx, element)
//}

//arr.enumerateObjects { (element, idx, stop) in
//    print(idx, element)
//    if idx == 2 {
//        stop.pointee = true
//    }
//}

//var age = 10

//func test1(_ ptr: UnsafeMutablePointer<Int>) {
//    ptr.pointee = 20
//    print("test1", ptr.pointee)
//}
//
//func test2(_ ptr: UnsafePointer<Int>) {
//    print("test2", ptr.pointee)
//}

//func test3(_ ptr: UnsafeRawPointer) {
//    print("test3", ptr.load(as: Int.self))
//}
//
//func test4(_ ptr: UnsafeMutableRawPointer) {
//    ptr.storeBytes(of: 30, as: Int.self)
//}
//
//test3(&age)
//test4(&age)
//print(age)

//func plus(_ num: inout Int) -> Int { num + 1 }
//var num = 1
//num = plus(&num)

//var step = 1
//func increment(_ num: inout Int) { num += step }
//var copyOfStep = step
//increment(&copyOfStep)

//class Dog {
//    var age = 10
//    func run() {}
//}
//
//do {
//    let dog1 = Dog()
//    dog1.age = 20
//    dog1.run()
//}
//
//do {
//    let dog1 = Dog()
//    dog1.age = 20
//    dog1.run()
//}

//
//typealias Fn = () -> ()
//
//func test1(_ fn: Fn) { fn() }
//
//var gFn: Fn?
//func test2(_ fn: @escaping Fn) { gFn = fn }
//
//func test3(_ fn: @escaping Fn) {
//    DispatchQueue.global().async {
//        fn()
//    }
//}

//class Person {
//    lazy var fn: (() -> ()) = {
//        [unowned us = self] in
//        us.run()
//    }
//    func run() { print("run") }
//    deinit {
//        print("deinit")
//    }
//}
//
//func test() {
//    let p = Person()
//    p.fn()
//}
//test()

//class Dog {
//
//}
//
//class Person {
//    weak var dog: Dog?
//    deinit {
//        print("Person.deinit")
//    }
//}
//
//print(1)
//var p: Person? = Person()
//
//print(2)

//struct Person {
//    var age: Int
//    func run(_ v: Int) { print("func run", age, v) }
//    static func run(_ v: Int) { print("static func run", v) }
//}
//
//var fn1: (Person) -> (Int) -> () = Person.run
////var fn2 = fn1(Person(age: 10))
//fn1(Person(age: 10))(20)

//private class Person {
//    internal var x = 10
//}

//class Person {
//    private(set) var age = 10
//
//}
//
//let p = Person()
//print(p.age)

//class Person {
//    required init() {
//
//    }
//}
//
//class Student: Person {
//    required init() {
//        fatalError("don't call Student.init")
//    }
//    init(score: Int) {
//
//    }
//}
//
//var stu1 = Student(score: 98)
//var stu2 = Student()

//func test(_ num: Int) -> Int {
//    if num >= 0 {
//        return 1
//    }
//    fatalError("num不能小于0")
//}
//print(test(-1))

//func divide(_ v1: Int, _ v2: Int) -> Int {
//    assert(v2 != 0, "除数不能为0")
//    return v1 / v2
//}
//print(divide(20, 0))

//var str1 = "0123456789"
//print(MemoryLayout.stride(ofValue: str1))

//var str2 = "0123456789ABCDEF"
//print(MemoryLayout.stride(ofValue: str2))

//enum Answer: Equatable {
//    case wrong(Int)
//    case right
//}
//
//var s1 = Answer.wrong(10)
//var s2 = Answer.right
//print(s1 == s2)

//class Person {
//
//}
//
//var p1 = Person()
//var p2 = p1
//print(p1 === p2)
//
//struct Student: Comparable {
//    var age: Int
//    var score: Int
//    init(age: Int, score: Int) {
//        self.age = age
//        self.score = score
//    }
//    static func < (lhs: Self, rhs: Self) -> Bool {
//        (lhs.score < rhs.score) || (lhs.score == rhs.score && lhs.age > rhs.age)
//    }
//    static func > (lhs: Self, rhs: Self) -> Bool {
//        (lhs.score > rhs.score) || (lhs.score == rhs.score && lhs.age < rhs.age)
//    }
//    static func <= (lhs: Self, rhs: Self) -> Bool {
//        !(lhs > rhs)
//    }
//    static func >= (lhs: Self, rhs: Self) -> Bool {
//        !(lhs < rhs)
//    }
//    static func == (lhs: Self, rhs: Self) -> Bool {
//        lhs.score == rhs.score && lhs.age == rhs.age
//    }
//}
//
//var stu1 = Student(age: 100, score: 20)
//var stu2 = Student(age: 98, score: 18)
//var stu3 = Student(age: 100, score: 20)
//print(stu1 > stu2)
//print(stu1 >= stu2)
//print(stu1 >= stu3)
//print(stu1 <= stu3)
//print(stu2 < stu1)
//print(stu2 <= stu1)
//print(stu1 == stu3)

//prefix operator +++
//
//prefix func +++ (_ i: inout Int) {
//    i += 2
//}
//
//var age = 10
//+++age
//print(age)

//precedencegroup PlusMinusPrecedence {
//    associativity: right
//    higherThan: AdditionPrecedence
//    lowerThan: MultiplicationPrecedence
//    assignment: true
//}
//
//infix operator +- : PlusMinusPrecedence
//
//struct Point {
//    var x = 0
//    var y = 0
//    static func +- (left: Self, right: Self) -> Self {
//        self.init(x: left.x + right.x, y: left.y - right.y)
//    }
//    static func +- (left: Self?, right: Self) -> Self {
//        print("+-")
//        return Point(x: left?.x ?? 0 + right.x, y: left?.y ?? 0 - right.y)
//    }
//}
//
//var p1 = Point(x: 10, y: 20)
//var p2 = Point(x: 5, y: 15)
//print(p1 +- p2 +- p2)
//
//struct Person {
//    var point: Point = Point(x: 10, y: 10)
//}
//
//var person: Person? = nil
//person?.point +- Point(x: 10, y: 20)
//
//person = Person()
//person?.point +- Point(x: 10, y: 20)



