/*
 1.Swift中跟实例相关的属性可以分为2大类
 - 存储属性（Stored Property）
    - 类似于成员变量
    - 存储在实例的内存中
    - 结构体、类可以定义存储属性
    - 枚举不可以定义存储属性
    - 可以使用let定义
 - 计算属性（Computed Property）
    - 本质是方法（函数）
    - 不占用实例的内存
    - 枚举、结构体、类都可以定义计算属性
    - 不能使用let定义
 */

func testStoredProperty() {
    struct Circle {
        var radius: Double
        var diameter: Double {
            set {
                radius = newValue / 2
            }
            get {
                radius * 2
            }
        }
    }
    var c = Circle(radius: 10)
    print(c.radius)
    print(c.diameter)
    
    c.diameter = 12
    print(c.radius)
    print(c.diameter)
}

/*
 2.只读计算属性
    - 只有get，没有set
 */

func testReadOnlyComputedProperty() {
    enum Season {
        var num: Int {
            get {
                20
            }
        }
        case spring, summer, autumn, winter
    }
    
    var season = Season.spring
    season.num
    //season.num = 10 // 不能赋值
}

/*
 3.延迟存储属性: 使用 lazy 可以定义一个延迟存储属性，在第一次用到属性的时候才会进行初始化
    - 不能使用 let 定义
    - 非线程安全
    - 当结构体包含一个延迟存储属性时，只有 var 才能访问
 */

func testLazyStoredProperty() {
    class Car {
        init() {
            print("Car init!")
        }
        func run() {
            print("Car is running!")
        }
    }
    
    class Person {
        lazy var car = Car()
        init() {
            print("Person init!")
        }
        func goOut() {
            car.run()
        }
    }
    
    var p = Person()
    print("--------")
    p.goOut()
}

/*
 4.属性观察器（Property Observer）:可以为非 lazy 的 var 存储属性 设置属性观察器
    - willSet会传递新值，默认叫newValue
    - didSet会传递旧值，默认叫oldValue
    - 在初始化器中设置属性值不会触发 willSet 和 didSet
 */

func testPropertyObserver() {
    struct Circle {
        var radius: Double = 10 {
            willSet {
                print("willSet", newValue)
            }
            didSet {
                print("didSet", oldValue)
            }
        }
        init() {
//            self.radius = 10
            print("Circle init!")
        }
    }
    
    var circle = Circle()
    circle.radius = 10.5
    print(circle.radius)
}

testPropertyObserver()

/*
 5.属性观察器、计算属性的功能，同样可以应用在全局变量、局部变量身上
 */
func testLocalVar() {
    var num: Int {
        get {
            return 10
        }
        set {
            print("setNum", newValue)
        }
    }
    num = 11
    print(num)
}
testLocalVar()

/*
 6.inout的本质总结
 - 如果实参有物理内存地址，切没有属性观察器
    - 直接将实参的内存地址传入函数（实参进行引用传递）
 - 如果实参是计算属性 或者 设置了属性观察器
    - 采用了Copy in Copy out的做法
        - 调用该函数时，先复制实参的值，产生副本【get】
        - 将副本的内存地址传入函数（副本进行引用传递），在函数内部可以修改副本的值
        - 函数返回后，再将副本的值覆盖实参的值【set】
 */

/*
 7.属性分为：实例属性和类型属性
 - 实例属性：只能通过实例去访问
 - 类型属性：只能通过类型去访问
    - 使用static定义类型属性，如果是类，也可以用class关键字
    - 线程安全(gcd once)
    - 默认是lazy的，第一次使用之前进行初始化
    - 可以是let的
 */
class FileManager {
    public static let shared = FileManager()
    private init() {  }
}

var fm1 = FileManager.shared
var fm2 = FileManager.shared

