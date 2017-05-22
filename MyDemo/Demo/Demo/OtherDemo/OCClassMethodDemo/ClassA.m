//
//  ClassA.m
//  AccessOCPrivateMethod
//
//  Created by apple on 15/12/1.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ClassA.h"

/* 
 类的扩展使用总结：
        1>单独创建一个文件，在本类的.m文件中#import ""此文件。
          如：创建ClassA_Extension.h文件，在ClassA.m文件中#import "ClassA_Extension.h"
        2>在本类的.m文件中直接定义扩展
          如：在ClassA.m文件中定义
            @interface ClassA ()
            @end
    所以类的扩展方法均为私有方法。
 */
#import "ClassA_Extension.h"

@implementation ClassA

#pragma mark - synthesize
@synthesize varPublicProperty = custom_VarPublicProperty;

#pragma mark - method
+ (void)classMethodA {
    NSLog(@"classMethodA!");
}
- (void)methodA {
    int varTemp;
    /*
        类的实例变量总结：
            使用@property，等效于在头文件中声明getter/setter方法
            使用@sythesize，等效于在实现文件中实现getter/setter方法
            使用@property默认的变量名为下划线加上使用@property声明时的名字，使用@sythesize可改变变量名
     */
//    varTemp = _varPublicProperty;      // 出错，应使用新变量名
    varTemp = custom_VarPublicProperty;  // 使用新变量名
//    varTemp = varName;                 // 出错，默认为_加上@property声明时的名字
    varTemp = _varName;                  // 使用默认变量名
    
    NSLog(@"methodA!");
}


+ (void)privateClassMethodA {
    NSLog(@"privateClassMethodA!");
}
- (void)privateMethodA {
    NSLog(@"privateMethodA!");
}

#pragma mark - 实现扩展方法
- (void) extensionMethod {
    NSLog(@"extensionMethod!");
}

@end
