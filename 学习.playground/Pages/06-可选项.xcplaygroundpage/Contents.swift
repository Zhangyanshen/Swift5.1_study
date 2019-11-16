/*
 1.可选项（optional）
 - 可选项，一般也叫可选类型，它允许将值设置为nil
 - 在类型后面加个问号 ? 来定义一个可选项
 */
var age: Int?
print(age)

var array = [1, 15, 40, 29]
func get(_ index: Int) -> Int? {
    if index < 0 || index >= array.count {
        return nil
    }
    return array[index]
}

if let value = get(1) {
    print(value)
}

print(get(1))
print(get(-1))
print(get(4))

/*
 2.强制解包（Forced Unwrapping）
 - 可选项是对其他类型的一层包装，可以理解为是一个盒子
 - 如果是nil，那么它是个空盒子
 - 如果不是nil，那么盒子里装的是：被包装类型的数据
 - 使用感叹号！强制解包
 - 如果对值为nil的可选项进行强制解包，将会产生运行时错误
 */
var age1: Int? = 10
var ageInt: Int = age1! + 20

/*
 3.可选项绑定（Optional Binding）
 - 用来判断可选项是否包含值
 - 可选项绑定作为if条件时不能用&&
 */
if let number = Int("123") {
    print("\(number)")
} else {
    print("字符串转换失败！")
}

enum Season: Int {
    case spring, summer, autumn, winter
}

var s = Season(rawValue: 4)
if let season = s {
    print(season)
} else {
    print("no such season")
}

var strs = ["10", "20", "abc", "-10", "30"]
var index = 0
var sum = 0
while let num = Int(strs[index]), num > 0 {
    sum += num
    index += 1
}
print("sum = \(sum)")

/*
 4.空合并运算符??(Nil-Coalescing Operator)
 - a ?? b
 - a 是可选项
 - b 是可选项或不是可选项
 - b 跟 a 的存储类型必须相同
 - 如果 a 不为nil，就返回a
 - 如果 a 为nil，就返回b
 - 如果b不是可选项，返回a时自动解包
 - 作用类似于 或 ||
 */
var a: Int? = 10
var b: Int? = 20
print(a ?? b)

var a1: Int? = nil
var b1: Int? = 20
print(a1 ?? b1)

var a2: Int? = nil
var b2: Int? = nil
print(a2 ?? b2)

var a3: Int? = 10
var b3: Int = 20
print(a3 ?? b3)

/*
 5.guard语句
 - 条件为false时，执行后面大括号里面的代码
 - 适合用来做“提前退出”
 - 当使用guard语句进行可选项绑定时，绑定的常量、变量也能在外层作用域中使用
 */

// 不使用guard
func login(_ info: [String: String]) {
    let username: String
    if let tmp = info["username"] {
        username = tmp
    } else {
        print("请输入用户名")
        return
    }
    let password: String
    if let tmp = info["password"] {
        password = tmp
    } else {
        print("请输入密码")
        return
    }
    print("用户名：\(username)", "密码：\(password)", "登录中...")
}
login(["password": "123456"])
login(["username": "jack"])
login(["username": "jack", "password": "123456"])

// 使用guard
func login1(_ info: [String: String]) {
    guard let username = info["username"] else {
        print("请输入用户名")
        return // 必须退出当前作用域
    }
    guard let password = info["password"] else {
        print("请输入密码")
        return
    }
    print("用户名：\(username)", "密码：\(password)", "登录中...")
}
login1(["password": "123456"])
login1(["username": "jack"])
login1(["username": "jack", "password": "123456"])

/*
 6.隐式解包可选项（Implicitly Unwrapped Optional）
 - 在某些情况下，可选项一旦被设定值之后，就会一直拥有值
 - 在这种情况下，可以去掉检查，也不必每次访问的时候都进行解包，因为它能确定每次访问的时候都有值
 - 可以在类型后面加个感叹号 ! 定义一个隐式解包可选项
 */
let num1: Int! = 10
let num2: Int = num1
if num1 != nil {
    print(num1 + 6)
}
if let num3 = num1 {
    print(num3)
}

/*
 7.字符串插值
 - 可选项在字符串插值或打印时，会发出警告
 */
var weight: Int? = 60
// 消除警告的3种方式
print("My weight is \(weight!)")
print("My weight is \(String(describing: weight))")
print("My weight is \(weight ?? 0)")

/*
 8.多重可选项
 - 包装了可选类型的可选项
 */
var num11: Int? = 10
var num22: Int?? = num11












