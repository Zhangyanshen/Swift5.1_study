/*
 ①.常量
 1.只能赋值一次
 2.它的值不要求在编译期确定，但使用之前必须赋值1次
 */
//var num = 10
//num += 20
//num += 30
//
//let age: Int
//age = num

func getAge() -> Int {
    return 10
}

let age = getAge()
print(age)

/*
 ②.标识符
 - 几乎可以使用任何字符
 - 不能以数字开头
 */
let 👽 = "ET"
func 🐂🍺() {
    print("牛皮")
}
🐂🍺()

/*
 ③.常见数据类型
 - 值类型(枚举、结构体)
 - 引用类型
 */
UInt8.max
Int16.min

/*
 字面量
 */
let bool = true // 布尔
let str = "还好" // 字符串
let character: Character = "🐶" // 字符
let intDecimal = 17 // 十进制
let intBinary = 0b10001 // 二进制
let intOctal = 0o21 // 八进制
let intHex = 0x11 // 十六进制
let doubleDecimal = 125.0 // 十进制
let doubleHex1 = 0xFp2 // 十六进制，相当于十进制15x2^2
let doubleHex2 = 0xFp-2 // 十六进制，相当于十进制15x2^-2
let int_ = 100_0000

/*
 数组
 */
let arr = [1, 3, 5, 7, 9]

/*
 字典
 */
let dic = ["key1": 2, "key2": "ffff"] as [String: Any]

/*
 类型转换
 */
let int1: UInt16 = 2_000
let int2: UInt8 = 1
let int3 = int1 + UInt16(int2)

/*
 元组（tuple）
 */
let http404Error = (404, "Not Found")
http404Error.0
http404Error.1

let (statusCode, msg) = http404Error
statusCode
msg

let (justStatusCode, _) = http404Error
justStatusCode

let http200Status = (statusCode: 200, des: "OK")
http200Status.statusCode
http200Status.des






