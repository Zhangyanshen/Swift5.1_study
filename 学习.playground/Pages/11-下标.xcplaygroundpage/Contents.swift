/*
 1.下标（subscript）
 - 使用subscript可以给任意类型（枚举、结构体、类）增加下标功能，有些地方也翻译为：下标脚本
    - subscript的语法类似于实例方法、计算属性，本质就是方法（函数）
 - subscript中定义的返回值类型决定了：
    - get方法的返回值类型
    - set方法中newValue的类型
 - subscript可以接收多个参数，并且类型任意
 - subscript可以没有set方法，但必须有get方法
 - 如果只有get方法，可以省略get
 - 可以设置参数标签
 - 下标可以是类型方法
 */
func testSubscript() {
    class Point {
        var x = 0.0, y = 0.0
        subscript(i index: Int) -> Double {
            set {
                if index == 0 {
                    x = newValue
                } else if index == 1 {
                    y = newValue
                }
            }
            get {
                if index == 0 {
                    return x
                } else if index == 1 {
                    return y
                }
                return 0
            }
        }
    }
    let p = Point()
    p[i: 0] = 11.1
    p[i: 1] = 22.2
    print(p.x)
    print(p.y)
    print(p[i: 0])
    print(p[i: 1])
}
//testSubscript()

func testMultiParamsSubscript() {
    class Grid {
        var data = [
            [0, 1, 2],
            [3, 4, 5],
            [6, 7, 8]
        ]
        subscript(row: Int, column: Int) -> Int {
            set {
                guard row >= 0 && row < 3 && column >= 0 && column < 3 else {
                    return
                }
                data[row][column] = newValue
            }
            get {
                guard row >= 0 && row < 3 && column >= 0 && column < 3 else {
                    return 0
                }
                return data[row][column]
            }
        }
    }
    var grid = Grid()
    grid[0, 1] = 77
    grid[1, 2] = 88
    grid[2, 0] = 99
    print(grid.data)
}
//testMultiParamsSubscript()

func testClassSubscript() {
    class Point {
        static var x = 0, y = 0
        class subscript(index: Int) -> Int {
            set {
                if index == 0 {
                    x = newValue
                } else {
                    y = newValue
                }
            }
            get {
                if index == 0 {
                    return x
                } else {
                    return y
                }
            }
        }
    }
    print(Point.x, Point.y)
    print("-----------")
    Point[0] = 11
    Point[10] = 22
    print(Point.x, Point.y)
}
testClassSubscript()

