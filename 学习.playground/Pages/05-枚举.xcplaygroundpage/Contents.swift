/*
 1.基本用法
 */
enum Direction {
    case north
    case south
    case east
    case west
}

enum Direction1 {
    case north, south, east, west
}

var dir = Direction.west
dir = Direction.east
dir = .north

switch dir {
case .north:
    print("north")
case .south:
    print("south")
case .west:
    print("west")
case .east:
    print("east")
}

/*
 2.关联值(Associated Values)
 - 有时会将枚举的成员值跟其他类型的值关联存储在一起，会非常有用
 - 直接将关联值存储到枚举变量的内存中，所以分配内存时需要保证能放的下关联值
 - 关联值以后可以改变
 */
enum Score {
    case points(Int)
    case grade(Character)
}

var score = Score.points(96)
score = .grade("A")

switch score {
case let .points(i):
    print(i, "points")
case let .grade(i):
    print("grade", i)
}

enum Date {
    case digit(year: Int, month: Int, day: Int)
    case string(String)
}

var date = Date.digit(year: 2019, month: 11, day: 13)
date = .string("2019-11-13")
switch date {
case .digit(let year, let month, let day):
    print(year, month, day)
case let .string(str):
    print(str)
}

/*
 3.原始值（Raw Values）
 - 枚举成员可以使用相同类型的默认值预先对应，这个默认值叫原始值
 - 是固定的，后期不能改变
 */
enum PokerSuit: Character {
    case spade = "🖤"
    case heart = "❤️"
    case diamond = "🔸"
    case club = "◾️"
}

var suit = PokerSuit.spade
print(suit)
print(suit.rawValue)
print(PokerSuit.club.rawValue)

/*
 4.隐式原始值
 - 如果枚举的原始值类型是Int、String，Swift会自动分配原始值
 */
enum SeasonInt: Int {
    case spring, summer, autumn, winter
}
print(SeasonInt.spring.rawValue)
print(SeasonInt.spring)

enum SeasonString: String {
    case spring, summer, autumn, winter
}
print(SeasonString.summer.rawValue)
print(SeasonString.summer)

enum Season1 {
    case spring, summer, autumn, winter
}
print(Season1.winter)

/*
 5.递归枚举
 - 枚举成员包含自己
 - 加indirect关键字
 */
indirect enum ArithExpr {
    case number(Int)
    case sum(ArithExpr, ArithExpr)
    case difference(ArithExpr, ArithExpr)
}

/*
 6.MemoryLayout
 - 可以使用MemoryLayout获取数据类型占用的内存大小
 */
MemoryLayout<Int>.size // 实际用到的内存大小
MemoryLayout<Int>.stride // 分配的内存大小
MemoryLayout<Int>.alignment // 内存对齐大小

let a = 10
MemoryLayout.size(ofValue: a)
MemoryLayout.stride(ofValue: a)
MemoryLayout.alignment(ofValue: a)

enum Password {
    case number(Int, Int, Int)
    case other
}
MemoryLayout<Password>.size
MemoryLayout<Password>.stride
MemoryLayout<Password>.alignment

enum Season: String {
    case spring
    case summer
    case autumn
    case winter
}
MemoryLayout<Season>.size
MemoryLayout<Season>.stride
MemoryLayout<Season>.alignment

MemoryLayout<String>.size
MemoryLayout<String>.stride
MemoryLayout<String>.alignment

MemoryLayout.size(ofValue: Season.spring.rawValue)
MemoryLayout.size(ofValue: Season.spring)



