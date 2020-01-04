/*
 1.方法
 - 枚举、结构体、类都可以定义方法
    - 实例方法：通过实例对象调用
    - 类型方法：通过类型调用，用static或class关键字定义
 - self
    - 在实例方法中代表实例对象
    - 在类型方法中代表类型
 */
func testFunc() {
    class Car {
        static var count = 0
        init() {
            Car.count += 1
        }
        static func getCount() -> Int { count }
    }
    let c0 = Car()
    let c1 = Car()
    let c2 = Car()
    print(Car.getCount())
}
testFunc()

/*
 2.mutating
 - 结构体和枚举是值类型，默认情况下，值类型的属性不能被自身的实例方法修改
 - 在func关键字前加上mutating可以允许这种修改行为
 */
func testMutating() {
    struct Point {
        var x = 0.0, y = 0.0
        mutating func moveBy(deltaX: Double, deltaY: Double) {
            x += deltaX
            y += deltaY
        }
    }
}

/*
 3.@discardableResult消除返回值没有使用的⚠️
 */
func testDiacardableReqult() {
    @discardableResult func test() -> Int {
        return 20
    }
    test()
}
testDiacardableReqult()
