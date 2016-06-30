//
//  ClassB.h
//  AccessOCPrivateMethod
//
//  Created by apple on 15/12/1.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassB : NSObject

@end

/*
 static总结：
 static变量属于本类，不同的类对应的是不同的对象
 static变量同一个类所有对象中共享，只初始化一次
 */
static const int var_global = 'B';  // 静态常量
static int var_static = 'B';        // 静态变量
static ClassB *singleB = nil/**/;