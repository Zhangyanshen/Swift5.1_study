/*
 1.MARK、TODO、FIXME
 - // MARK: 类似于OC中的 #pragma mark
 - // MARK: - 类似于OC中的 #pragma mark -
 - // TODO: 用于标识未完成的任务
 - // FIXME: 用于标记待修复的问题
 - #warning("TODO")
 */
func test() {
    // TODO: 未完成
}

func test1() {
    var age = 10
    // FIXME: 有待修复
    age += 10
}

/*
 2.条件编译
 */
// ①
// 操作系统：macOS\iOS\tvOS\watchOS\Linux\Android\Windows\FreeBSD
#if os(macOS) || os(iOS)

// CPU架构：i386\x86_64\arm\arm64
#elseif arch(x86_64) || arch(arm64)

// swift版本
#elseif swift(<5) && swift(>=3)

// 模拟器
#elseif targetEnvironment(simulator)

// 可以导入某个模块
#elseif canImport(Foundation)

#else

#endif

// ②.默认有个DEBUG
#if DEBUG
print("Debug")
#else
print("Release")
#endif

// ③.自定义标识：Building Settings -> Swift Compiler - Custom Flags
#if TEST
print("TEST")
#endif

#if OTHER
print("OTHER")
#endif

/*
 3.打印
 */
func log<T>(_ msg: T,
            file: NSString = #file, // 文件
            line: Int = #line, // 行号
            fn: String = #function) // 调用的函数
{
    #if DEBUG
    let prefix = "\(file.lastPathComponent) \(line) \(fn):"
    print(prefix, msg)
    #endif
}

/*
 4.系统版本检测
 */
if #available(iOS 10, macOS 10.12, *) {
    // 对于iOS平台，只在iOS 10及以上版本执行
    // 对于macOS平台，只在macOS 10.12及以上版本执行
    // 最后的*表示在其他所有平台可执行
}

/*
 5.API可用性说明
 */
@available(iOS 10, macOS 10.15, *)
class Person {}

struct Student {
    
    @available(*, unavailable, renamed: "study")
    func study_() {}
    func study() {}
    
    @available(iOS, deprecated: 11)
    @available(macOS, deprecated: 10.12)
    func run() {}
}

var stu = Student()
stu.run()
stu.study()

/*
 6.iOS程序的入口
 - 在AppDelegate上面默认有个@UIApplicationMain标记，这表示
    - 编译器自动生成入口代码（main函数代码），自动设置AppDelegate为App的代理
 - 也可以删掉 @UIApplicationMain ，自定义入口文件：新建一个main.swift文件，代码如下
 */
import UIKit

// 自定义Application
class YSApplication: UIApplication {}

UIApplicationMain(CommandLine.argc,
                  CommandLine.unsafeArgv,
                  NSStringFromClass(YSApplication.self),
                  NSStringFromClass(AppDelegate.self))

/*
 7.Swift调用OC
 - 新建1个桥接头文件，文件名格式默认为：{targetName}-Bridging-Header.h
    - Building Settings -> Objective-C Bridging Header 设置文件路径
 - 在 {targetName}-Bridging-Header.h 文件中 #import OC需要暴露给Swift的内容
 - 如果C语言暴露给Swift的函数名跟Swift中的其他函数名冲突了
    - 可以在Swift中使用 @_silgen_name 修改C函数名
 */
// 把C语言中的sum函数重名成swift_sum
@_silgen_name("sum")
func swift_sum(_ a: Int, _ b: Int) -> Int

/*
 8.OC调用Swift
 - Xcode默认生成一个用于OC调用Swift的头文件，文件名格式是：{targetName}-Swift.h
    - Building Settings -> Objective-C Generated Interface Header Name
 - Swift暴露给OC的类最终继承自NSObject
 - 使用 @objc 修饰需要暴露给OC的成员
    - 可以通过 @objc 重命名Swift暴露给OC的符号名（类名、属性名、函数名等）
 - 使用 @objcMembers 修饰类
    - 代表默认所有成员都会暴露给OC（包括扩展中定义的成员）
    - 最终是否成功暴露，还需要考虑成员自身的访问级别
 - Xcode会根据Swift代码自动生成对应的OC声明，写入 {targetName}-Swift.h 文件
 */
@objc(YSCar)
@objcMembers class Car: NSObject {
    var price: Double
    @objc(name)
    var band: String
    init(price: Double, band: String) {
        self.price = price
        self.band = band
    }
    @objc(drive)
    func run() { print(price, band, "run") }
    static func run() { print("Car run") }
}

extension Car {
    func test() { print(price, band, "test") }
    override var description: String {
        get {
            "\(band), \(price)"
        }
    }
}

/*
 9.选择器（Selector）
 - Swift中依然可以使用选择器，使用 #selector(name) 定义一个选择器
    - 必须是被 @objcMembers 或 @objc 修饰的方法才可以定义选择器
 */
@objcMembers class Person: NSObject {
    func test1(v1: Int) { print("test1") }
    func test2(v1: Int, v2: Int) { print("test2(v1:v2:)") }
    func test2(_ v1: Double, _ v2: Double) { print("test2(_:_:)") }
    func run() {
        perform(#selector(test1))
        perform(#selector(test2(_:_:)))
        perform(#selector(test2(v1:v2:)))
        perform(#selector(test2 as (Double, Double) -> Void))
    }
}

/*
 10.String
 */
// ①.空字符串
var emptyStr1 = ""
var emptyStr2 = String()

// ②.字符串拼接
var str: String = "1"
// 拼接
str.append("_2")
// 重载运算符 +
str = str + "_3"
// 重载运算符 +=
str += "_4"
// 插值 \()
str = "\(str)_5"
// 长度
print(str.count)

// ③.前缀、后缀
var str = "123456"
print(str.hasPrefix("123"))
print(str.hasSuffix("456"))

// ④.String的插入和删除
var str = "1_2"
str.insert("_", at: str.endIndex)
print(str)
str.insert(contentsOf: "3_4", at: str.endIndex)
print(str)
str.insert(contentsOf: "666", at: str.index(after: str.startIndex))
print(str)
str.insert(contentsOf: "888", at: str.index(before: str.endIndex))
print(str)
str.insert(contentsOf: "hello", at: str.index(str.startIndex, offsetBy: 4))
print(str)

str.remove(at: str.firstIndex(of: "1")!)
print(str)
str.removeAll {
    (ch) -> Bool in
    return ch == "6"
}
print(str)
var range = str.index(str.endIndex, offsetBy: -4) ..< str.index(before: str.endIndex)
str.removeSubrange(range)
print(str)

/*
 ⑤.Substring
 - String可以通过下标、prefix、suffix等截取子串，子串类型不是String，而是Substring
 - Substring和它的base，共享字符串数据
 - Substring发生修改或者转为String时，会分配新的内存存储字符串数据
 */
var str = "1_2_3_4_5"
var substr1 = str.prefix(3)
print(substr1)
var substr2 = str.suffix(3)
print(substr2)
var range = str.startIndex ..< str.index(str.startIndex, offsetBy: 3)
var substr3 = str[range]
print(substr3)

// 最初的String
print(substr3.base)

var str2 = String(substr3)

/*
 ⑥.String与Character
 */
for c in "jack" {
    // c是Character类型
    print(c)
}

var str = "jack"
// c是Character类型
var c = str[str.startIndex]

/*
 ⑦.String相关的协议
 - BidirectionalCollection 协议包含的部分内容
    - startIndex、endIndex属性、index方法
    - String、Array都遵守了这个协议
 - RangeReplaceableCollection 协议包含的部分内容
    - append、insert、remove方法
    - String、Array都遵守了这个协议
 - Dictionary、Set也有实现上述协议中声明的一些方法，只是并没有遵守上述协议
 */

/*
 ⑧.多行String
 - 如果要显示3个引号，至少转义1个引号
 - 缩进以结尾的3个引号为对齐线
 */
let str = """
1
        "2"
3
        '4'
"""
print(str)

/*
 ⑨.String与NSString
 - String 与 NSString 之间可以随时随地桥接转换
    - 如果你觉得String的API过于复杂难用，可以考虑将String转为NSString
 - 比较字符串内容是否等价
    - String使用 == 运算符
    - NSString使用 isEqual 方法，也可以使用 == 运算符（本质还是调用了 isEqual 方法）
 - 使用 as 强转的规则表如下：
 |—————————————————————————————————————|
 | String  <=>  NSString               |
 | String  <=  NSMutableString         |
 | Array <=> NSArray                   |
 | Array <= NSMutableArray             |
 | Dictionary  <=>  NSDictionary       |
 | Dictionary  <=  NSMutableDictionary |
 | Set  <=>  NSSet                     |
 | Set  <=  NSMutableSet               |
 |—————————————————————————————————————|
 */
var str1: String = "jack"
var str2: String = "rose"

var str3 = str1 as NSString
var str4 = str2 as NSString

var str5 = str3.substring(with: NSRange(location: 0, length: 2))
print(str5)

/*
 11. 只能被class继承的协议
 - 继承自 AnyObject 或 class
 - 用 @objc 修饰协议
    - 被 @objc 修饰的协议，还可以暴露给OC去遵守实现
 */
protocol Runnable1: AnyObject {}
protocol Runnable2: class {}
@objc protocol Runnable3 {}

/*
 12.可选协议
 - 通过extension给协议定义的方法一个默认实现
 - 通过 @objc 定义可选协议，这种协议只能被 class 遵守
 */

// ①
protocol Runnable {
    func run1()
    func run2()
    func run3()
}

extension Runnable {
    func run2() {
        
    }
}

class Dog: Runnable {
    func run3() {
        print("Dog run3")
    }
    
    func run1() {
        print("Dog run1")
    }
}

var d = Dog()
d.run1()
d.run3()

// ②
@objc protocol Runnable {
    func run1()
    @objc optional func run2()
    func run3()
}

class Dog: Runnable {
    func run3() {
        print("Dog run3")
    }
    
    func run1() {
        print("Dog run1")
    }
}

var d = Dog()
d.run1()
d.run3()

/*
 13.dynamic
 - 被 @objc dynamic 修饰的内容会具有动态性，比如调用方法会走runtime那一套流程
 */
class Dog: NSObject {
    @objc dynamic func test1() {}
    func test2() {}
}

var d = Dog()
d.test1() // objc_msgSend()
d.test2() // 虚表

/*
 14.KVC、KVO
 - Swift支持KVC、KVO
    - 属性所在的类、监听器最终继承自 NSObject
    - 用 @objc dynamic 修饰对应的属性
 */
// ①
class Observer: NSObject {
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?)
    {
        print("observeValue", change?[.newKey] as Any)
    }
}

class Person: NSObject {
    @objc dynamic var age: Int = 0
    var name: String = "jack"
    var observer = Observer()
    override init() {
        super.init()
        self.addObserver(observer, forKeyPath: "age", options: .new, context: nil)
    }
    deinit {
        self.removeObserver(observer, forKeyPath: "age")
    }
}

var p = Person()
p.age = 20 // observeValue Optional(20)
p.setValue(25, forKey: "age") // observeValue Optional(25)
p.name = "rose" // 无打印
p.setValue("jordan", forKey: "name") // 崩溃

// ②.block方式的KVO
class Person: NSObject {
    @objc dynamic var age = 0
    var observation: NSKeyValueObservation?
    override init() {
        super.init()
        observation = observe(\Person.age, options: .new, changeHandler: { (person, change) in
            print(change.newValue as Any)
        })
    }
}

var p = Person()
p.age = 20
p.setValue(25, forKey: "age")

/*
 15.关联对象（Associated Object）
 - 在Swift中，class依然可以使用关联对象
 - 默认情况下，extension不可以增加存储属性
    - 借助关联对象，可以实现类似extension为class增加存储属性的效果
 */
class Person {}
extension Person {
    // private 保证只能在这个扩展中使用
    private static var AGE_KEY: Void?
    var age: Int {
        get {
            (objc_getAssociatedObject(self, &Self.AGE_KEY) as? Int) ?? 0
        }
        set {
            objc_setAssociatedObject(self, &Self.AGE_KEY, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}

var p = Person()
print(p.age)
p.age = 10
print(p.age)

/*
 16.资源名管理
 */
enum R {
    enum image {
        static var logo = UIImage(named: "logo")
    }
    enum font {
        static func arial(_ size: CGFloat) -> UIFont? {
            UIFont(name: "Arial", size: size)
        }
    }
}

let img = R.image.logo
let font = R.font.arial(14)

/*
 17.多线程开发
 - 异步
 - 延迟
 - once
    - dispatch_once在swift中被废弃了
        - 可以用 类型属性 或者 全局变量\常量
        - 默认自带 lazy + dispatch_once 效果
 - 加锁
 */


