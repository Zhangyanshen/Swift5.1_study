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

