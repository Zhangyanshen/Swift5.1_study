/*
 1.if-else
 */
let a = 10
if a > 10 {
    print("大于")
} else if a < 10 {
    print("小于")
} else {
    print("等于")
}

/*
 2.while
 */
var num = 5
while num > 0 {
    print("num is \(num)")
    num -= 1 // Swift3之后去掉了++、--，因为可读性太差
}

// repeat while相当于do while
num = -1
repeat {
    print("num is \(num)")
} while num > 0

/*
 3.for
 - 闭区间运算符:a...b，a <= 取值 <= b
 - 半开区间运算符:a..<b，a <= 取值 < b
 - 单侧区间:让区间朝一个方向尽可能的远
 */
let names = ["a", "b", "c", "d"]
for i in 0...3 {
    print(names[i])
}
for i in 0...names.count - 1 {
    print(names[i])
}
for _ in 0...3 {
    print("123")
}
for name in names[0...3] {
    print(name)
}
for name in names[2...] {
    print(name)
}
for name in names[...2] {
    print(name)
}
let range = ...10
range.contains(5)
range.contains(15)
range.contains(-19)

/*
 4.区间类型
 */
let range1: ClosedRange<Int> = 1...3 // 闭区间
let range2: Range<Int> = 1..<3 // 半闭区间
let range3: PartialRangeThrough<Int> = ...5

let strRange1 = "cc"..."ff"

/*
 5.switch
 - case、default之后至少有一条语句
 - 要处理所有情况
 - 支持字符、字符串
 */
var number = 1
switch number {
case 1:
    print("num is 1")
case 2:
    print("num is 2")
case 3:
    print("num is 3")
default:
    break
}

let str = "Jack"
switch str {
case "Jack":
    fallthrough
case "Rose":
    print("Right person")
default:
    break
}

switch str {
case "Jack", "Rose":
    print("Right person")
default:
    break
}

// 区间匹配
let score = 62
switch score {
case ..<60:
    print("不及格")
case 60..<80:
    print("及格")
case 80..<90:
    print("还行")
case 90...100:
    print("优秀")
default:
    break
}

// 元组匹配
let point = (1, 1)
switch point {
case (0, 0):
    print("the origin")
case (_, 0):
    print("on the x-axis")
case (0, _):
    print("on the y-axis")
case (-2...2, -2...2):
    print("inside the box")
default:
    print("outside the box")
}

// where
let point = (1, -1)
switch point {
case let (x, y) where x == y:
    print("on the line x == y")
case let (x, y) where x == -y:
    print("on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}

var nums = [10, 20, -10, -20, 30, -30]
var sum = 0
for num in nums where num > 0 {
    sum += num
}
print(sum)

// 标签语句
outer: for i in 1...4 {
    for k in 1...4 {
        if k == 3 {
            continue outer
        }
        if i == 3 {
            break outer
        }
        print("i == \(i), k == \(k)")
    }
}



