/*
 String
 */

// 字符串长度 <= 0xF时，字符串内容直接存放在str1变量的内存中
var str1 = "0123456789"

// 字符串长度 > 0xF时，字符串内容存放在 __TEXT.cstring 中（常量区）
// 字符串的地址值信息存放在str2变量的后8个字节中
// 0x7fffffffffffffe0
var str2 = "0123456789ABCDEFGHIJ"

/*
 Array
 - 定义为struct，说明它的很多特性跟值类型很像
 - Array变量存放地址值
 - 真正存放数据的是堆空间
 */

var arr: [Any] = [1, 2, 3, 4, "str"]
MemoryLayout.stride(ofValue: arr)

