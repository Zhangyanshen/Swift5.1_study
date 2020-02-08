/*
 1.Array常见操作
 */
// ①.map、filter
var arr = [1, 2, 3, 4]

var arr2 = arr.map { $0 * 2 }
print(arr2, arr)

var arr3 = arr.filter { $0 % 2 == 0 }
print(arr3)

var arr4 = arr.reduce(0) { $0 + $1 }
print(arr4)

var arr5 = arr.reduce(1, +)
print(arr5)

func double(_ i: Int) -> Int { i * 2 }
var arr = [1, 2, 3, 4]
var arr2 = arr.map(double)
print(arr2)

// ②.flatMap
var arr = [1, 2, 3]
// [[1], [2, 2], [3, 3, 3]]
var arr2 = arr.map { Array.init(repeating: $0, count: $0) }
print(arr2)
// [1, 2, 2, 3, 3, 3]
var arr3 = arr.flatMap { Array.init(repeating: $0, count: $0) }
print(arr3)

// ③.compactMap
var arr = ["123", "test", "jack", "-30"]
// [Optional(123), nil, nil, Optional(-30)]
var arr2 = arr.map { Int($0) }
print(arr2)
// [123, -30]
var arr3 = arr.compactMap { Int($0) }
print(arr3)

// ④.使用reduce实现map、filter的功能
var arr = [1, 2, 3, 4]
// [2, 4, 6, 8]
print(arr.map { $0 * 2 })
print(arr.reduce([]) { $0 + [$1 * 2] })
// [2, 4]
print(arr.filter { $0 % 2 == 0 })
print(arr.reduce([]) { $1 % 2 == 0 ? $0 + [$1] : $0 })

/*
 2.lazy的优化
 - 用到的时候再去映射，使用lazy
 */
let arr = [1, 2, 3]
let result = arr.lazy.map {
    (i : Int) -> Int in
    print("mapping \(i)")
    return i * 2
}

print("begin------")
for i in result {
    print("mapped", i)
}
print("end------")

/*
 3.Optional的map和flatMap
 */
// ①
var num1: Int? = 10
// Optional(20)
var num2 = num1.map { $0 * 2 }
print(num2)

var num3: Int? = nil
// nil
var num4 = num3.map { $0 * 2 }
print(num4)

// ②
var num1: Int? = 10
// Optional(Optional(20))
var num2 = num1.map { Optional.some($0 * 2) }
print(num2)
// Optional(20)
var num3 = num1.flatMap { Optional.some($0 * 2) }
print(num3)

// ③
var num1: Int? = 10
// Optional(20)
var num2 = (num1 != nil) ? (num1! + 10) : nil
print(num2)
// Optional(20)
var num3 = num1.map { $0 + 10 }
print(num3)

// ④
var fmt = DateFormatter()
fmt.dateFormat = "yyyy-MM-dd"
var str: String? = "2019-12-12"
var date1 = str != nil ? fmt.date(from: str!) : nil
print(date1)
var date2 = str.flatMap { fmt.date(from: $0) }
print(date2)
var date3 = str.flatMap(fmt.date)
print(date3)

// ⑤
var score: Int? = nil
var str1 = score != nil ? "Score is \(score!)" : "No score"
print(str1)
var str2 = score.map { "score is \($0)" } ?? "No score"
print(str2)

// ⑥
struct Person {
    var name: String
    var age: Int
    init?(_ json: [String: Any]) {
        guard let name = json["name"] as? String,
              let age = json["age"] as? Int
        else { return nil }
        self.name = name
        self.age = age
    }
}

var json: Dictionary? = ["name": "Jack", "age": 10]
var p1 = json != nil ? Person(json!) : nil
var p2 = json.flatMap(Person.init)

