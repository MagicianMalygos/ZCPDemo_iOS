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
        
        self.variableTest();
    }
    
    func variableTest() {
        
        // 变量var 常量let
        var myVariable: Int;
        myVariable = 100;
        let myConstant = 100;
        print(myVariable, myConstant);
        
        // 对于变量常量的定义可以不需要声明类型。
        let numberInteger = 70;
        let numberDouble = 70.0;
        let numberDouble2: Double = 70;
        print(numberInteger, numberDouble, numberDouble2);
        
        // 变量之间进行运算、操作时，需要进行格式转换
        let tip = "The width is ";
        let width = 94;
        let widthtip = tip + String(width);
//        let widthtip2 = tip + width; // 报错
        let widthtip3 = "The width is \(width)"; // 简单的转换方法
        print(widthtip, widthtip3);
        
        // 字典和数组都使用[]
        var fishList = ["catfish", "pike", "eel", "salmon"];
        fishList[1] = "tunas";
        var fishPrice = [
            "catfish": 36,
            "pike": 68,
            "eel": 24,
            "salmon": 120,
        ];
        fishPrice["tunas"] = 88;
        
        // 创建空数组、空字典
        let emptyArray = String[]();
        let emptyDictionary = Dictionary<String, Float>();
    }
}
