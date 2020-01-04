/*
 内存访问冲突（Conflicting Access to Memory）
 - 满足以下条件时发生内存访问冲突
    - 至少一个是写操作
    - 访问同一块内存
    - 访问时间重叠（比如在同一个函数内）
 
 指针
 - Swift中也有专门的指针类型，这些被定性为“Unsafe”（不安全的），常见的有以下4种类型：
    - UnsafePointer<Pointee> 类似于 const Pointee *
    - UnsafeMutablePointer<Pointee> 类似于 Pointee *
    - UnsafeRawPointer 类似于 const void *
    - UnsafeMutableRawPointer 类似于 void *
 */
var age = 10

func test1(_ ptr: UnsafeMutablePointer<Int>) {
    ptr.pointee = 20
    print("test1", ptr.pointee)
}

func test2(_ ptr: UnsafePointer<Int>) {
    print("test2", ptr.pointee)
}

func test3(_ ptr: UnsafeRawPointer) {
    print("test3", ptr.load(as: Int.self))
}

func test4(_ ptr: UnsafeMutableRawPointer) {
    ptr.storeBytes(of: 30, as: Int.self)
}

/*
 获得指向某个变量的指针
 */
var age = 10
var ptr = withUnsafePointer(to: &age) { $0 }
var ptr2 = withUnsafeMutablePointer(to: &age) { $0 }

print(ptr.pointee)

ptr2.pointee = 30

print(age)

var ptr3 = withUnsafeMutablePointer(to: &age) { UnsafeMutableRawPointer($0) }
var ptr4 = withUnsafePointer(to: &age) { UnsafeRawPointer($0) }
ptr3.storeBytes(of: 33, as: Int.self)
print(ptr4.load(as: Int.self))
print(age)

/*
 获得指向堆空间实例的指针
 */
class Person {
    var age: Int
    init(age: Int) {
        self.age = age
    }
}

var person = Person(age: 20)
var ptr = withUnsafePointer(to: &person) { UnsafeRawPointer($0) }
var personObjAddress = ptr.load(as: UInt.self)
var ptr2 = UnsafeRawPointer(bitPattern: personObjAddress)
print(ptr)
print(ptr2 ?? "")

/*
 创建指针
 */
// ①
// 创建指针
var ptr = malloc(16)
// 存
ptr?.storeBytes(of: 10, as: Int.self)
ptr?.storeBytes(of: 20, toByteOffset: 8, as: Int.self)
// 取
print(ptr?.load(as: Int.self) ?? "")
print(ptr?.load(fromByteOffset: 8, as: Int.self) ?? "")
// 销毁指针
free(ptr)

// ②
// 创建指针
var ptr = UnsafeMutableRawPointer.allocate(byteCount: 16, alignment: 1)
// 存
ptr.storeBytes(of: 11, as: Int.self)
ptr.advanced(by: 8).storeBytes(of: 22, as: Int.self)
// 取
print(ptr.load(as: Int.self))
print(ptr.advanced(by: 8).load(as: Int.self))
// 销毁指针
ptr.deallocate()

// ③
var ptr = UnsafeMutablePointer<Int>.allocate(capacity: 3)
ptr.initialize(to: 10)
ptr.successor().initialize(to: 20)
ptr.successor().successor().initialize(to: 30)

print(ptr.pointee)
print((ptr + 1).pointee)
print((ptr + 2).pointee)

print(ptr[0])
print(ptr[1])
print(ptr[2])

print(ptr.pointee)
print(ptr.successor().pointee)
print(ptr.successor().successor().pointee)

ptr.deinitialize(count: 3) // initialize初始化的必须调用这个方法，否则内存泄漏
ptr.deallocate()

/*
 指针之间的转换
 */
// ①
var ptr = UnsafeMutableRawPointer.allocate(byteCount: 16, alignment: 1)
ptr.assumingMemoryBound(to: Int.self).pointee = 11
(ptr + 8).assumingMemoryBound(to: Int.self).pointee = 22
ptr.deallocate()

// ② unsafeBitCast是忽略数据类型的强制转换，不会因为数据类型的变化而改变原来的内存数据
// 类似于C++中的 reinterpret_cast
var ptr = UnsafeMutableRawPointer.allocate(byteCount: 16, alignment: 1)
unsafeBitCast(ptr, to: UnsafeMutablePointer<Int>.self).pointee = 11
print(ptr.load(as: Int.self))
ptr.deallocate()
