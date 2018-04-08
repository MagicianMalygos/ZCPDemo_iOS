//
//  ViewController.swift
//  SwiftDemo
//
//  Created by 朱超鹏 on 17/3/9.
//  Copyright © 2017年 zcp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // first
        print("= = = = = first = = = = =")
        self.first()
        
        // 基本语法
        print("= = = = = 基本语法 = = = = =")
        self.basicGrammar()
        
        // 数据类型
        print("= = = = = 数据类型 = = = = =")
        self.dataType()
        
        // 变量
        print("= = = = = 变量 = = = = =")
        self.variable()
        
        // 可选类型
        print("= = = = = 可选类型 = = = = =")
        self.optionalType()
        
        // 字面量
        print("= = = = = 字面量 = = = = =")
        self.literal()
        
        // 运算符
        print("= = = = = 运算符 = = = = =")
        self.operators()
        
        // 条件和循环
        print("= = = = = 条件和循环 = = = = =")
        self.conditionsAndCycles()
        
        // 字符串
        print("= = = = = 字符串 = = = = =")
        self.characterString()
        
        // 数组
        print("= = = = = 数组 = = = = =")
        self.array()
        
        // 字典
        print("= = = = = 字典 = = = = =")
        self.dictionary()
        
        // 函数
        print("= = = = = 函数 = = = = =")
        self.function()
        
        // 闭包
        print("= = = = = 闭包 = = = = =")
        self.closure()
        
        // 枚举
        print("= = = = = 枚举 = = = = =")
        self.enumeration()
        
        // 结构体
        print("= = = = = 结构体 = = = = =")
        self.structure()
        
        // 类
        print("= = = = = 类 = = = = =")
        self.classes()
        
        // 属性
        print("= = = = = 属性 = = = = =")
        self.property()
        
        // 方法
        print("= = = = = 方法 = = = = =")
        self.method()
        
        // 继承
        print("= = = = = 继承 = = = = =")
        self.inherit()
        
        // 构造过程
        print("= = = = = 构造过程 = = = = =")
        self.structuralProcess()
        
        // 可选链
        print("= = = = = 可选链 = = = = =")
        self.optionalChaining()
        
        // 自动引用计数
        print("= = = = = 自动引用计数 = = = = =")
        self.autoReferenceCount()
        
        // 类型转换
        print("= = = = = 类型转换 = = = = =")
        self.typeConversion()
        
        // 扩展
        print("= = = = = 扩展 = = = = =")
        self.extend()
        
        // 协议
        print("= = = = = 协议 = = = = =")
        self.protocols()
        
        // 泛型
        print("= = = = = 泛型 = = = = =")
        self.genericity()
        
        // 访问控制
        print("= = = = = 访问控制 = = = = =")
        self.accessControl()
    }
    
    // first
    func first() {
        let word = "hello world!"
        print(word)
    }
    
    // 基本语法
    func basicGrammar() {
        print("hello world")
        print(
            "hello world"
        )
        
        // 一行注释
        /* 多行
         注释 */
        /* 注释一嵌套/*注释二*/
         */
        
        let a = "swift语句结尾不要求‘;’，但一行写了多条语句需要‘;’分割"
        let b = a; print(b)
        
        let `class` = "abc"// 关键字做标识符
        print(`class`)
        
        /*
         与声明有关的关键字：
         class deinit enum extension func import init internal let
         operator private protocol public static struct subscript typealias var
         与语句有关的关键字在：
         break case continue default do else fallthrough
         for if in return switch where while
         表达式和类型关键字
         as dynamicType true false is nil self Self super _COLUMN_ _FILE_ _FUNCTION_ _LINE_
         特定上下文中使用的关键字
         associativity convenience dynamic didSet final get infix
         inout lazy left mutating none monmutating optional override postfix
         precedence prefix Protocol required right set Type unowned weak willSet
         */
        
//        let c= 1 + 2 // 运算符不能仅左右一边挨着变量或常量
        print("abc", terminator: "") // 打印时不换行
    }
    
    // 数据类型
    func dataType() {
        // Int 32/64位整数（根据所在平台）
        // UInt 32/64位无符号整数（根据所在平台）
        // Float 32位浮点数
        // Double 64位浮点数
        // true false Boolean类型
        // "hello world" 字符串
        // 'C' 字符
        /*
         Int8/UInt8 1字节
         Int16/UInt16 2字节
         Int32/UInt32 4字节
         Int64/UInt64 8字节
         Float 4字节
         Double 8字节
         */
        
        // 类型别名 typealias
        typealias MoneyValue = Int
        let myMoney: MoneyValue = 100
        print(myMoney)
        
        // 类型安全
//        var aVar = 42; aVar = "abc"
        // 类型推断
//        var aVar = 42 // aVar为Int类型
//        var aVar = 3.14; var aVar = 1 + 3.14;  // aVar为Double类型
    }
    
    // 变量
    func variable() {
        // 变量声明
        var a = Int(42)
        var b: Float
        a = 1
        b = 3.14
        
        // 输出
        print("我有\(a)块钱")
        print("PI等于\(b)")
        
        // 常量
        let c = 1
        
        // 类型标注':'（说明常量/变量中要存储的值的类型）
        let d:Float = 10
        var e:Int = 10
        print(d); print(e)
    }
    
    // 可选类型
    func optionalType() {
        // 可选类型如果未设值，则为nil，用于处理值缺失的情况
        var a: Int?
        var b: Optional<Int>
        var c: ([Int])?
        print(a)
        print(b)
        print(c)
        a = 100
        b = 200
        c = [100, 200]
        print(a)
        print(b)
        print(c)
//        var d: Int; print(d) // 会报错
        
        // 强制解析
        print(a!)
        print(b!)
        print(c!)
        
        // 自动解析（在声明时就使用!）
        var d: Int!
        d = 42
        print(d)
        
        // 可选绑定（判断可选类型是否包含值）
        var e: Int?
        e = 10
        if let tempE = e {
            print("OK 值为\(tempE)")
        }
//        if e {print("OK")} // 编译不通过
    }
    
    // 字面量
    func literal() {
        // 整型字面量
        let binaryInteger = 0b10001     // 二进制表示
        let octalInteger = 0o21         // 八进制表示
        let decimalInteger = 17         // 十进制表示
        let hexadecimalInteger = 0x11   // 十六进制表示
        
        // 浮点型字面量
        let decimalDouble = 12.1875     // 十进制表示
        let exponentDouble = 0.121875e2 // 十进制指数型表示
        let hexadecimalDouble = 0xC.3p0 // 十六进制表示，p0表示2^0，C.3 x 2^0
        
        // 字符串转义字符
        print("空字符：\0、反斜线：\\、换行符：\n、回车符：\r、水平制表符：\t、单引号：\'、双引号：\"、1到3位八进制数所代表的任意字符：\000")
        
        // 布尔型字面量
        let b1:Bool = true
        let b2:Bool = false
    }
    
    // 运算符
    func operators() {
        // + - * / %
        // == != > < >= <=
        // && || !
        // &按位与 |按位或 ~取反 ^异或 <<按位左移 >>按位右移
        // = += -= *= /= %= <<= >>= &= |= ^=
        // ?:三元运算符
        
        /// 特性
        // swift3 取消了++ 和 --
        // 闭区间运算符：a...b 半开区间运算符：a..
        for index in 1...5 {
            print("\(index) * 5 = \(index * 5)")
        }
        for index in 1..<5 {
            print("\(index) * 5 = \(index * 5)")
        }
    }
    
    // 条件循环
    func conditionsAndCycles() {
        // 类似于 do...while...语句
        repeat {
        } while (false);
    }
    
    // 字符串
    func characterString() {
        var a = "hello"
        var b = String("world")!
        
        var c = ""
        if c.isEmpty {print("c is empty")} else {print("c is`t empty")}
        
        var d = String()
        if d.isEmpty {print("d is empty")} else {print("d is`t empty")}
        
        // 修改
        var e = "hello"
        e += " world"   // 定义为let时不能修改
        print(e)
        
        // 插入
        var f = "\(a) \(b)"; print(f);
        // 长度
        f = a + b + e
        print("\(f)，长度为\(f.count)")
        // 比较
        if e == f {print("\(e) == \(f)")} else {print("\(e) != \(f)")}
        
        // unicode
        var g = "你好世界"
        print("UTF-8 编码：")
        for code in g.utf8 {
            print("\(code)", terminator:" ")
        }
        print("\n")
        print("UTF-16 编码：")
        for code in g.utf16 {
            print("\(code)", terminator:" ")
        }
        
        // 相关方法和运算
        print("\n")
        g.isEmpty;
        g.hasPrefix("http")
        g.hasSuffix(".com")
        Int(g)
        g.count
        for code in g.unicodeScalars {
            print("\(code)", terminator:" ")
        }
        a+b; a+=b ;a==b; a<b; a != b
        
        
        let aa:Character = "a"
        for ch in g {
            print(ch)
        }
        // 字符串连接字符
        a.append(aa)
    }
    
    // 数组
    func array () {
        
        var array1:[Int] = [10, 20, 30]
        var array2:[Int] = [40, 50, 60]
        var someArray:[Int]
        let letArray:[Int] = [1, 2, 3] // 不可修改
        someArray = [Int](repeating: 0, count: 3)
        someArray = array1 + array2
        someArray.append(70)
        someArray += [80]
        someArray[0] = 0
        
        if !someArray.isEmpty {
            print("someArray isn`t empty")
        }
        
        for index in 0..<someArray.count {
            print(someArray[index], terminator:" ")
        }
        print("\n");
        for item in someArray {
            print(item, terminator:" ")
        }
        print("\n");
        for (index, item) in someArray.enumerated() {
            print("\(index):\(item)", terminator:" ")
        }
        print("\n");
    }
    
    // 字典
    func dictionary() {
        var someDict:[Int: String] = [Int: String]()
        someDict = [1: "One", 2: "Two", 3: "Three", 4: "Four"]
        var someValue = someDict[1]
        someDict.updateValue("new One", forKey: 1)
        someDict[2] = "new Two"
        someDict.removeValue(forKey: 4)
        
        print("someDict有\(someDict.count)个键值对")
        
        if !someDict.isEmpty {
            print("someDict isn`t empty")
        }
        
        for (key, value) in someDict {
            print("\(key): \(value)")
        }
        print("\n")
        for (key, keyValue) in someDict.enumerated() {
            print("\(key): \(keyValue)")
        }
        
        let dictKeys = [Int](someDict.keys)
        let dictValues = [String](someDict.values)
        for key in dictKeys {
            print("\(key)", terminator: " ")
        }
        print("\n")
        for value in dictValues {
            print("\(value)", terminator: " ")
        }
    }
    
    // 函数
    func function() {
        // 函数定义中参数前加"_ "使用时可以直接传参，不用写形参名
        
        // 元组作为函数返回值
        let array:[Int] = [8, 2, 4, 7, 12, 21, 5, 10]
        let bounds1 = self.minMax(array: array)
        print("最小值：\(bounds1!.min) 最大值：\(bounds1!.max)")
        if let bounds2 = self.minMax(array: array) { // 可选类型
            print("最小值：\(bounds2.min) 最大值：\(bounds2.max)")
        }
        
        // 指定外部参数名
        print(self.pow(base: 2, index: 3))
        
        // 可变参数
        self.vari(i: 1, 2, 3, f: 11.0, s: "iOS")
        self.vari(i: "1", "2", "3", f:6.0, s: "Android")
        
        // 变量参数
        var error:String = ""
        var count:Int = 5
        self.getError(&error, &count)
        print("\(error) \(count)")
        
        // 函数类型，可以将函数赋值给一个变量，这个变量是函数类型的变量
        let func1: ([Int]) -> (Int, Int)? = self.minMax
        print("\(func1([0, 1]))")
        
        let func2: ((Double, Double) -> Double) = self.pow
        let func3: ((Double, Double) -> Double, Double, Double) -> Double = self.getResult
        print("\(func3(func2, 2, 3))")
        
        // 函数嵌套
        print("\(self.getUserInfo())")
    }
    func minMax(array: [Int]) -> (min: Int, max: Int)? { // 如果不确定返回的元组一定不为nil，使用可选类型
        return (0, 99)
    }
    func pow(base b: Double, index i: Double) -> (Double) {
        return Foundation.pow(b, i);
    }
    func vari<N>(i: N..., f: Float!, s: String!) { // 可以传类型相同的一组参数
        for value in i {
            print(value, terminator:" ")
        }
        print("\(s!) \(f!)")
        print("\n")
    }
    func getError(_ error: inout String, _ count: inout Int) {
        error += "错误"
        count += 1
    }
    func getResult(pow:(Double, Double) -> (Double), base: Double, index: Double) -> (Double) {
        return pow(base, index)
    }
    func getUserInfo() -> String {
        func getUser() -> [String: String]! {
            return ["id": "1001", "name": "朱超鹏"]
        }
        let userInfo:String! = String(describing: getUser()["id"]!) + String(describing: getUser()["name"]!)
        return userInfo
    }
    
    // 闭包
    func closure() {
        // 无参，无返回值
        let a = {print("闭包a")}
        a()
        // 带参，返回值
        let b = {(base: Double, index: Double) -> Double in
            return Foundation.pow(base, index)
        }
        print("\(b(2, 3))")
        
        // 闭包作为参数
        let numbers = [3, 1, 7, 21, 19, 5, 0, 24]
        print("1. \(numbers.sorted())")
        let n = numbers.sorted { (a: Int, b: Int) -> Bool in
            return a<b ? true : false
        }
        print("2. \(n)")
        let sortedClo = {(a: Int, b: Int) -> Bool in
            return a<b ? true : false
        }
        print("3. \(numbers.sorted(by: sortedClo))")
        // 参数省略，返回类型会进行推断
        var n2 = numbers.sorted(by: {$0 < $1})
        print("4. \(n2)")
        n2 = numbers.sorted(by: <)
        print("5. \(n2)")
        
        // 尾随闭包，闭包为最后一个参数时使用
        func handleWithCompletion(mission: String, completion:(String) -> Void) {
            completion(mission + " Completion!")
        }
        // 使用尾随闭包
        handleWithCompletion(mission: "Mission 1") {
            print("\($0) 尾随闭包")
        }
        // 不使用尾随闭包
        handleWithCompletion(mission: "Mission 2", completion: {
            print("\($0) 未使用尾随闭包")
        })
        print("6. \(numbers.sorted {$0 < $1})") // 如果只有一个参数，可以省略()
        
        // runningTotal为什么没有被释放？
        func makeIncrementor(forIncrement amount: Int) -> (() -> Int) {
            var runningTotal = 0
            func incrementor() -> Int {
                runningTotal += amount
                return runningTotal
            }
            return incrementor
        }
        let incrementByTen = makeIncrementor(forIncrement: 10)
        print(incrementByTen())
        print(incrementByTen())
        let incrementByTen2 = incrementByTen
        print(incrementByTen2())
        let incrementByTen3 = makeIncrementor(forIncrement: 10)
        print(incrementByTen3())
    }
    
    // 枚举
    func enumeration() {
        
        // 枚举类型没有默认的初始整型值
        enum DayType {
            case Monday
            case Tuesday
            case Wednesday
            case Thursday
            case Friday
            case Saturday
            case Sunday
        }
        var weekDay = DayType.Tuesday
        weekDay = .Sunday // 当被赋值后，可以使用推断语法
        
        enum StudentType {
            case GoodStudent(Int, Int, Int)
            case BadStudent(String)
        }
        
        var stuType1 = StudentType.GoodStudent(98, 95, 94)
        var stuType2 = StudentType.BadStudent("15年逃课被学院通报批评")
        switch stuType2 {
        case .GoodStudent(let chinese, let math, let english):
            print("好学生 成绩：语\(chinese)数\(math)外\(english)")
        case .BadStudent(let info):
            print("坏学生 处分：\(info)")
        }
        
        enum Month: Int {
            case January = 1, February, March, April, May, June, July, August, September, October,November, December
        }
        let yearMonth = Month.May.rawValue
        print("数字月份为：\(yearMonth)")
        
        enum CellType: String {
            case TitleCellType  = "title"
            case DescCellType   = "desc"
            case ButtonCellType = "button"
        }
        let cellType = CellType.TitleCellType.rawValue
        print("cell type: \(cellType)")
    }
    
    // 结构体
    func structure() {
        struct MarkStruct {
            var mark1: Int
            var mark2: Int
            var mark3: Int
            
            // 值传递
            init(mark1: Int, mark2: Int, mark3: Int) {
                self.mark1 = mark1
                self.mark2 = mark2
                self.mark3 = mark3
            }
        }
        var marks1 = MarkStruct(mark1: 1, mark2: 2, mark3: 3)
        let marks2 = marks1 // 值拷贝而不是引用，1和2是两个不同的结构体，对1操作不会影响2
        marks1.mark1 = 99
        print("\(marks1.mark1) \(marks1.mark2) \(marks1.mark3)")
        print("\(marks2.mark1) \(marks2.mark2) \(marks2.mark3)")
    }
    
    // 类
    func classes() {
        class Student {
            var id: Int
            var name: String
            
            init(id: Int, name: String) {
                self.id = id
                self.name = name
            }
            public func description() -> String {
                return "\(self.id) \(self.name)"
            }
        }
        
        var stu1 = Student(id: 1001, name: "王小虎")
        var stu11 = stu1
        print(stu1.description())
        stu1.name = "zcp"
        print(stu11.description())
        
        // 判断两个常量或变量是否引用同一个类实例 使用 === !==
        print(stu1 === stu11, stu1 !== stu11)
    }
    
    // 属性
    func property() {
        class Number {
            // 存储属性
            var radius: Double = 0
            let pi = 3.1415
            // 修改常量属性
            let pi2: Double
            // 延迟存储属性
            lazy var complex = Complex()
            // 计算属性
            var _area: Double = 0
            var area: (Double) {
                get {
                    _area = radius * pi * 2
                    return _area
                }
                set {
                    _area = newValue // 没有定义形参的话，可以使用默认参数newValue
                    radius = _area / 2 / pi
                    volume = radius * radius * pi
                }
            }
            var volume: (Double) = 0 {
                // 属性观察器
                willSet {
                    print("volume(\(volume)) will be set, new value is \(newValue)")
                }
                didSet {
                    print("volume(\(volume)) did set")
                }
            }
            // 只读计算属性
            var description: String {
                return "area:\(self.area) volume:\(volume)"
            }
            // 类型属性
            static var PRO: Double = 2000
            class var PRO2: Double {
                return 3000
            }
            
            init() {
                self.pi2 = 3.14
            }
        }
        
        class Complex {
            var real: Double = 0
            var imaginary: Double = 0
        }
        
        var num1 = Number()
        num1.radius = 1
        num1.complex.real = 4.2
        num1.complex.imaginary = 5
        print(num1.area)
        num1.area = 10
        print(num1.area, num1.radius)
        print(num1.description)
        print(Number.PRO, Number.PRO2)
    }
    
    // 方法
    func method() {
        class Multiplication {
            var count: Int = 0
            func incrementBy1(num1: Int, num2: Int) {
                count = num1 * num2
                print(count)
            }
            func incrementBy2(firstNum num1: Int, num2: Int) {
                count = num1 * num2
                print(count)
            }
            func incrementBy3(_ num1: Int, _ num2: Int) {
                count = num1 * num2
                print(count)
            }
            // 类方法
            class func abs(number: Int) -> Int {
                if number < 0 {
                    return -number
                } else {
                    return number
                }
            }
            // 下标脚本，设置后可以使用[]来访问
            var numbers = [456, 215, 252, 111]
            subscript() -> String {
                return "下标脚本"
            }
            subscript(index: Int) -> Int {
                get {
                    return numbers[index]
                }
                set {
                    self.numbers[index] = newValue
                }
            }
            subscript(index: Int, desc: String) -> String {
                return "\(self.numbers[index]) \(desc)"
            }
        }
        
        let counter = Multiplication()
        counter.incrementBy1(num1: 20, num2: 3)
        counter.incrementBy2(firstNum: 20, num2: 3)
        counter.incrementBy3(20, 3)
        print("类方法：", Multiplication.abs(number: -999))
        print(counter[])
        print("下标脚本：", counter[2])
        counter[2] = 999
        print("下标脚本：", counter[2])
        print("下标脚本：", counter[2, "我是附加信息"])
        
        struct Area {
            var length = 1
            var breadth = 1
            
            // 在不加mutating时，方法内部是无法修改self的
            mutating func scaleBy(res: Int) {
                self.length *= res
                self.breadth *= res
                
                print(length, breadth)
            }
            static func abs(number: Int) -> Int {
                if number < 0 {
                    return -number
                } else {
                    return number
                }
            }
        }
        
        var val = Area(length: 3, breadth: 5)
        val.scaleBy(res: 3)
        val.scaleBy(res: 30)
        val.scaleBy(res: 300)
        print("结构体方法：", Area.abs(number: -999))
    }
    
    // 继承
    func inherit() {
        class Person {
            var _name: String? = ""
            var name: String {
                get {
                    if _name == nil {
                        _name = "unknown(person name)"
                    }
                    return _name!
                }
                set {
                    _name = newValue
                }
            }
            // 防止重写
            final var id: Int = 0
            
            func show() {
                print("Person name is \(name)")
            }
        }
        class Student : Person {
            // 重写方法
            override func show() {
                print("Student name is \(self.name)")
            }
            // 重写属性
            override var name: String {
                willSet {
                }
                didSet {
                }
            }
        }
        
        var stu = Student()
        stu.name = "zcp"
        stu.show()
        
        // 子类默认不会继承父类的构造器，
    }
    
    // 构造过程
    func structuralProcess() {
        class Number {
            var count: Int
            let pi: Double
            // 便利构造器，如果要在构造方法中调用另一个构造方法，需要加convenience
            convenience init() {
                self.init(count: 0)
            }
            init(count: Int) {
                self.count = count
                self.pi = 3.14
            }
            // 可失败构造器
            init?(count: Int, tag: Int) {
                self.pi = 3.14
                if tag > 999 {
                    return nil
                }
                self.count = count
            }
            
            // 析构函数
            deinit {
                print("Number(\(self.count))被释放掉了")
            }
        }
        
        if let num = Number(count: 11, tag: 1) {
            print("count 为 \(num.count) pi 为 \(num.pi)")
        } else {
            print("Number实例化失败")
        }
        if let num = Number(count: 11, tag: 1000) {
            print("count 为 \(num.count) pi 为 \(num.pi)")
        } else {
            print("Number实例化失败")
        }
        
        // 枚举类型可失败构造器
        enum TemperatureUnit {
            case Kelvin, Celsius, Fahrenheit
            init?(symbol: Character) {
                switch symbol {
                case "K":
                    self = .Kelvin
                case "C":
                    self = .Celsius
                case "F":
                    self = .Fahrenheit
                default:
                    return nil
                }
            }
        }
        
        let temUnit = TemperatureUnit(symbol: "C")
        if temUnit != nil {
            print("这是一个已定义的温度单位，所以初始化成功")
        }
        let temUnit2 = TemperatureUnit(symbol: "M")
        if temUnit2 == nil {
            print("这不是一个已定义的温度单位，所以初始化成功")
        }
    }
    
    // 可选链
    func optionalChaining() {
        class Person {
            var residence: Residence?
        }
        
        class Residence {
            var numberOfRooms: Int = 1
            var rooms:[Room] = []
            func printNumber() {
                print("房屋数量：\(numberOfRooms)")
            }
            subscript(i: Int) -> Room {
                return rooms[i]
            }
        }
        class Room {
            var name:String = ""
        }
        
        let p = Person()
        
        // 使用?友好展开，当可选值为nil时可选链返回nil
        if let roomCount = p.residence?.numberOfRooms {
            print("房屋数量：\(roomCount)")
        } else {
            print("未获取到房屋数量") // roomCount为nil
        }
        // 使用!强制展开，当可选值为nil时会引起运行时错误
//        print(p.residence!.numberOfRooms)
        
        // 调用方法的可选链，如果有错误也返回nil
        if p.residence?.printNumber() == nil {
            print("未通过方法获取到房屋数量")
        }
        // 使用下标脚本的可选链
        if let roomName = p.residence?[0].name {
            print("房间名：\(roomName)")
        } else {
            print("无法获取房间名")
        }
    }
    
    // 自动引用计数
    func autoReferenceCount() {
        // 实例赋值给属性、常量、变量时会创建此实例的强引用
        // 解决循环引用：使用弱引用和无主引用。
        // 生命周期中会变为nil的实例使用弱引用。对于初始化赋值后再也不会被赋值为nil的实例，使用无主引用
        class Student {
            var name: String
            // 弱引用
            weak var myTeacher:Teacher?
            // 无主引用
            unowned var myTeacher2:Teacher
            init(_ name: String, _ tea2: Teacher) {
                self.name = name
                self.myTeacher2 = tea2
            }
            deinit {
                print("\(name)被开除")
            }
        }
        class Teacher {
            var name: String
            var myStudent:Student?
            var myStudent2:Student?
            init(_ name: String) {
                self.name = name
            }
            deinit {
                print("\(name)被开除")
            }
        }
        
        var stu: Student
        var tea: Teacher
        var tea2: Teacher
        
        tea = Teacher("李老师")
        tea2 = Teacher("马老师")
        stu = Student("王小虎", tea2)
        
        stu.myTeacher = tea
        tea.myStudent = stu
        stu.myTeacher2 = tea2
        tea2.myStudent2 = stu
        
        class HTMLElement {
            let name: String
            let text: String?
            
            lazy var asHTML: () -> String = {
                [unowned self] in
//                [weak self] in // self为可选类型
                if let text = self.text {
                    return "<\(self.name)>\(text)<\(self.name)>"
                } else {
                    return "<\(self.name) />"
                }
            }
            init(name: String, text: String? = nil) {
                self.name = name
                self.text = text
            }
            deinit {
                print("\(name)被析构")
            }
        }
        let paragraph: HTMLElement = HTMLElement(name: "p", text: "hello world")
        print(paragraph.asHTML())
    }
    
    // 类型转换
    func typeConversion() {
        // is判断实例属于某个类 as?/as! 向下转型
        
        let arr:[Any] = [1, "1", 2, "2", 3, "3"]
        
        for item in arr {
            if item is Int {
                print("\(item) is Int")
            } else if item is String {
                print("\"\(item)\" is Int")
            }
        }
        
        let num: Int = 100
        let str = num as? String
        print(str) // str为nil
        
        let f:Float = 1.0
        let d = f as? Double
        print(d, Double(f))
        
        // 不确定类型：AnyObject可以表示任何class类型的实例 Any可以表示任何类型
        var anyArray = [Any]()
        anyArray.append(2)
        anyArray.append(3.1415)
        anyArray.append("abc")
        anyArray.append(UIView())
        
        for item in anyArray {
            // 在switch中使用as而不是as?，转换到一个明确的值
            switch item {
            case let aInt as Int:
                print("Int: \(aInt)")
            case let aDouble as Double:
                print("Double: \(aDouble)")
            case let aString as String:
                print("String: \(aString)")
            case let aView as UIView:
                print("UIView: \(aView)")
            default:
                print("None!")
            }
        }
        
        var anyObjArray: [AnyObject] = []
        anyObjArray.append(UILabel())
        anyObjArray.append(UIImageView())
        anyObjArray.append(UIButton())
        
        for item in anyObjArray {
            if let i = item as? UILabel {
                print("UILabel: \(item)")
            } else if let i = item as? UIImageView {
                print("UIImageView: \(item)")
            } else if let i = item as? UIButton {
                print("UIButton: \(item)")
            }
        }
    }
    
    // 扩展
    func extend() {
        // 添加计算型属性和计算型静态属性
        // 定义实例方法和类型方法
        // 提供新的构造器
        // 定义下标
        // 定义和使用新的嵌套类型
        // 使一个已有类型符合某个协议
        
        var a: Int = 948
        a.add_1(); print("a的值:\(a)")
        a.sub_1(); print("a的值:\(a)")
        10.add_1Value
        print(a[2])
    }
    
    // 协议
    func protocols() {
        class MyObject : ObjectProtocol {
            required init(tag: Int) {
                self.tag = tag
            }
            
            var tag: Int = 0
            var enable: Bool = true
            func dictionaryValue() -> [String : String] {
                return [:]
            }
        }
        class MyPerson : MyObject {
            required override convenience init(tag: Int) {
                self.init(tag: tag)
            }
        }
    }
    
    // 泛型
    func genericity() {
        func swapTwoObj<T>(a: inout T, b: inout T) {
            let temp = a
            a = b
            b = temp
        }
        var a = 10
        var b = 20
        var c = "10"
        var d = "20"
        swapTwoObj(a: &a, b: &b)
        swapTwoObj(a: &c, b: &d)
        print("\(a) \(b)")
        print("\(c) \(d)")
        
        // 泛型约束
        func someFunction<T: UIView, U: NSObjectProtocol>(someT: T, someU: U) {
        }
        
        // 关联类型
        class AClass<Element>: TProtocol {
            var items = [Element]()
            
            func append(_ T: Element) {
                items.append(T)
            }
            subscript(i: Int) -> Element {
                return items[i]
            }
        }
        let aObj = AClass<String>()
        aObj.append("aaa")
        print(aObj[0])
        let bObj = AClass<Int>()
        bObj.append(123)
        print(bObj[0])
    }
    
    // 访问控制
    func accessControl() {
        // 类，变量，方法，结构体，枚举等都可以加访问控制
        // public 可被自己模块访问，其他模块引入访问
        // internal 仅可被自己模块访问
        // fileprivate 文件内私有，当前源文件访问
        // private 只能在类中访问
        // 默认访问级别为internal
        
    }
}

// 扩展
extension Int {
    var add_1Value: Int {
        return self + 1
    }
    mutating func add_1() {
        self += 1
    }
    mutating func sub_1() {
        self -= 1
    }
    subscript(multtable: Int) -> Int {
        var no1 = 1
        var m = multtable
        while m > 0 {
            no1 *= 10
            m -= 1
        }
        return (self / no1) % 10
    }
    
    enum Words {
        case A
        case B
        case C
        case D
    }
}

// 协议
protocol ObjectProtocol {
    var tag: Int { get set}
    var enable: Bool { get }
    func dictionaryValue() -> [String: String]
    init(tag: Int)
}

// 关联类型
protocol TProtocol {
    associatedtype TType
    mutating func append(_ T: TType)
    subscript(i: Int) -> TType {get}
}
