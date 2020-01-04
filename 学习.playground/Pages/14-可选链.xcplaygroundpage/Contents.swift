/*
 可选链（Optional Chaining）
 - 多个 ? 连接在一起
 - 如果链中任何一个节点是nil，那么整个链就会调用失败
 - 如果可选项是nil，调用方法、下标、属性失败，结果为nil
 - 如果可选项不为nil，调用方法、下标、属性成功，结果会被包装成可选项
 - 如果结果本来就是可选项，不会进行再次包装
 */
func testOptionalChaining() {
    class Car { var price = 0 }
    class Dog { var weight = 0 }
    class Person {
        var name: String = ""
        var dog: Dog = Dog()
        var car: Car? = Car()
        
        func age() -> Int { 18 }
        func eat() { print("Person eat") }
        subscript(index: Int) -> Int { index }
    }
    
    let person: Person? = Person()
    var _ = person?.age()
    var _ = person!.age()
    var _ = person?.name
    var _ = person?[6]
    
    var _ = person?.dog
    var _ = person?.dog.weight
    var _ = person?.car?.price
    
    if let _  = person?.eat() {
        print("eat调用成功")
    } else {
        print("eat调用失败")
    }
}
testOptionalChaining()

func testOptionalChaining1() {
    var scores = [
        "Jack": [86, 82, 84],
        "Rose": [79, 94, 81]
    ]
    scores["Jack"]?[0] = 100
    scores["Rose"]?[2] += 10
    scores["Kate"]?[0] = 88
    print(scores)
    
    var num1: Int? = 5
    num1? = 20
    print(num1 ?? 0)
    
    var num2: Int? = nil
    num2? = 20
    print(num2 ?? 0)
    
    let dic: [String: (Int, Int) -> Int] = [
        "sum": (+),
        "difference": (-)
    ]
    let result = dic["sum"]?(10, 20)
    print(result ?? 0)
}
testOptionalChaining1()
