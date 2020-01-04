/*
 1.继承（Inheritance）
 - 值类型（枚举、结构体）不支持继承，只有类支持继承
 - 没有父类的类，称为：基类
    - Swift并没有像OC、Java那样的规定：任何类最终都要继承自某个基类
 - 子类可以重写父类的 下标、方法、属性 ，重写必须加上 override 关键字
 */

/*
 重写实例方法、下标
 */
func testOverrideInstance() {
    class Animal {
        func speak() {
            print("Animal speak")
        }
        subscript(index: Int) -> Int {
            return index
        }
    }
    class Cat: Animal {
        override func speak() {
            super.speak()
            print("Cat speak")
        }
        override subscript(index: Int) -> Int {
            return super[index] + 1
        }
    }
    var animal = Animal()
    animal.speak()
    print(animal[6])
    print("-------------")
    
    animal = Cat()
    animal.speak()
    print(animal[6])
}
//testOverrideInstance()

/*
 重写类型方法、下标
 - 被class修饰的类型方法、下标，允许被子类重写
 - 被static修饰的类型方法、下标，不允许被子类重写
 */
func testOverrideType() {
    class Animal {
        class func speak() {
            print("Animal speak")
        }
        class subscript(index: Int) -> Int {
            return index
        }
    }
    class Cat: Animal {
        override class func speak() {
            super.speak()
            print("Cat speak")
        }
        override class subscript(index: Int) -> Int {
            return super[index] + 1
        }
    }
    Animal.speak()
    print(Animal[6])
    print("-------------")
    Cat.speak()
    print(Cat[6])
}
//testOverrideType()

/*
 重写属性
 - 子类可以将父类的属性（存储、计算）重写为 计算属性
 - 子类不可以将父类属性重写成 存储属性
 - 只能重写 var 属性，不能重写 let 属性
 - 重写时，属性名、类型要一致
 - 子类重写后的属性权限 不能小于 父类的权限
    - 如果父类属性是只读的，那么子类重写后的属性可以是只读的、也可以是可读写的
    - 如果父类属性是可读写的，那么子类重写后的属性也必须是可读写的
 */

/*
 重写实例属性
 */
func testOverrideInstanceProperty() {
    class Circle {
        var radius: Int = 0
        var diameter: Int {
            set {
                print("Circle setDiameter")
                radius = newValue / 2
            }
            get {
                print("Circle getDiameter")
                return radius * 2
            }
        }
    }
    class SubCircle: Circle {
        override var radius: Int {
            set {
                print("SubCircle setRadius")
                super.radius = newValue > 0 ? newValue : 0
            }
            get {
                print("SubCircle getRadius")
                return super.radius
            }
        }
        override var diameter: Int {
            set {
                print("SubCircle setDiameter")
                super.diameter = newValue > 0 ? newValue : 0
            }
            get {
                print("SubCircle getDiameter")
                return super.diameter
            }
        }
    }
    var circle: Circle
    circle = Circle()
    circle.radius = 6
    print(circle.diameter)
    circle.diameter = 20
    print(circle.radius)
    print("-----------")
    
    circle = SubCircle()
    circle.radius = 6
    print(circle.diameter)
    circle.diameter = 20
    print(circle.radius)
}
//testOverrideInstanceProperty()

/*
 重写类型属性
 - 只有计算属性可以被重写
 */
func testOverrideTypeProperty() {
    class Circle {
        static var radius: Int = 0
        class var diameter: Int {
            set {
                print("Circle setDiameter")
                radius = newValue / 2
            }
            get {
                print("Circle getDiameter")
                return radius * 2
            }
        }
    }
    class SubCircle: Circle {
        override class var diameter: Int {
            set {
                print("SubCircle setDiameter")
                super.diameter = newValue > 0 ? newValue : 0
            }
            get {
                print("SubCircle getDiameter")
                return super.diameter
            }
        }
    }
    Circle.radius = 6
    print(Circle.diameter)
    Circle.diameter = 20
    print(Circle.radius)
    print("----------")
    
    SubCircle.radius = 6
    print(SubCircle.diameter)
    SubCircle.diameter = 20
    print(SubCircle.radius)
}
//testOverrideTypeProperty()

/*
 属性观察器
 - 可以在子类中为父类属性添加属性观察器
 - 只读计算属性、let属性不能添加属性观察器
 */
func testPropertyObserver() {
    class Circle {
        var radius: Int = 1
    }
    class SubCircle: Circle {
        override var radius: Int {
            willSet {
                print("SubCircle willSet radius", newValue)
            }
            didSet {
                print("SubCircle didSet radius", oldValue, radius)
            }
        }
    }
    var circle = SubCircle()
    circle.radius = 10
}
//testPropertyObserver()

/*
 final
 - 被final修饰的方法、下标、属性，禁止被重写
 - 被final修饰的类，禁止被继承
 */

/*
 多态的实现原理：
 1.OC：Runtime
 2.C++：虚表（虚函数表）
 
 Swift中多态的实现原理
 */


