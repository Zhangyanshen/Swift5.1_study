/*
 初始化器：
 - 类、结构体、枚举都可以定义初始化器
 - 类有2种初始化器：指定初始化器（designated initializer）、便捷初始化器（convenience initializer）
 - 每个类至少有一个指定初始化器，指定初始化器是类的主要初始化器
 - 便捷初始化器必须要调用指定初始化器
 
 - 初始化器的相互调用规则：
    - 便捷初始化器必须从相同的类里调用另一个初始化器（指定或便捷）
    - 便捷初始化器最终必须调用一个指定初始化器
    - 指定初始化器必须从它的直系父类调用指定初始化器
 
 - 安全检查：
    - 指定初始化器必须保证在调用父类初始化器之前，其所在类定义的所有存储属性都要初始化完成
    - 指定初始化器必须先调用父类初始化器，然后才能为继承的属性设置新值
    - 便捷初始化器必须先调用同类中的其他初始化器，然后再为任意属性设置新值
 
 - 重写：
    - 当重写父类的指定初始化器时，必须加上override（即使子类的实现是便捷初始化器）
    - 子类无法重写父类的便捷初始化器
 
 - 自动继承：
    - 如果子类没有 自定义 任何指定初始化器，将继承父类 所有的 指定初始化器
    - 如果子类提供了父类所有指定初始化器的实现（要么通过继承，要么重写）
        - 子类自动继承所有的父类便捷初始化器
    - 就算子类添加了更多的便捷初始化器，这些规则仍然适用
 
 - required：
    - 用required修饰指定初始化器，表明其所有子类必须实现该初始化器（通过继承或者重写实现）
    - 如果子类重写了required初始化器，也必须加上required，不用加override
 
 - 属性观察器
    - 父类的属性在它自己的初始化器中赋值不会触发属性观察器，但在子类的初始化器中赋值会触发属性观察器
 
 - 可失败初始化器
    - 类、结构体、枚举都可以使用 init? 定义可失败初始化器
    - 返回一个 可选项
    - 不能同时定义参数标签、参数类型、参数个数相同的可失败初始化器和非可失败初始化器
    - 可以用 init! 定义隐式解包的可失败初始化器
    - 可失败初始化器可以调用非可失败初始化器，非可失败初始化器调用可失败初始化器需要进行解包
    - 如果初始化器调用一个可失败初始化器导致初始化失败，那么整个初始化过程都失败，并且之后的代码都停止执行
 
 - 反初始化器（deinit）
    - 类似于C++的析构函数、OC中的dealloc方法
    - 当 类 的实例对象被释放内存时，就会调用实例对象的deinit方法
    - 不接受任何参数，不能写小括号，不能自行调用
    - 父类的deinit能被子类继承
    - 先调用子类的deinit，再调用父类的deinit
 */
func testClassInit() {
    class Size {
        var width: Int
        var height: Int
        init(width: Int, height: Int) {
            self.width = width
            self.height = height
        }
        
        convenience init(width: Int) {
            self.init(width: width, height: 0)
        }
        
        convenience init(height: Int) {
            self.init(width: 0, height: height)
        }
        
        convenience init() {
            self.init(width: 0, height: 0)
        }
    }
    var _ = Size()
    var _ = Size(height: 10)
    var _ = Size(width: 20)
    var _ = Size(width: 30, height: 10)
}
//testClassInit()

func testRequiredInit() {
    class Person {
        required init() {  }
        init(age: Int) {  }
    }
    class Student: Person {
        
    }
}
//testRequiredInit()

func testPropertyObserver() {
    class Person {
        var age: Int {
            willSet {
                print("willSet", newValue)
            }
            didSet {
                print("didSet", oldValue, age)
            }
        }
        init() {
            self.age = 0
        }
    }
    
    class Student: Person {
        override init() {
            super.init()
            self.age = 1
        }
    }
    
    var _ = Person()
    print("----------")
    var _ = Student()
}
//testPropertyObserver()

func testCanFailInit() {
    class Person {
        var name: String
        init?(name: String) {
            if name.isEmpty {
                return nil
            }
            self.name = name
        }
    }
    var p1 = Person(name: "")
    print(p1)
    var p2 = Person(name: "Jack")
    print(p2)
}
//testCanFailInit()

func testCanFailInit1() {
    class Person {
        var name: String
        convenience init?(name: String) {
            self.init()
            if name.isEmpty {
                return nil
            }
        }
        init() {
            self.name = ""
        }
    }
    var _ = Person()
    var _ = Person(name: "Jack")
}
//testCanFailInit1()

func testDeinit() {
    class Person {
        deinit {
            print("Person对象销毁了")
        }
    }
    
    class Student: Person {
        deinit {
            print("Student对象销毁了")
        }
    }
    func test() {
        var _ = Student()
    }
    
    print("1")
    test()
    print("2")
}
testDeinit()

