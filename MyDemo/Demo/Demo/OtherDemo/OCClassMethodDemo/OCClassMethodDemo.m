//
//  OCClassMethodDemo.m
//  Demo
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "OCClassMethodDemo.h"
#import "ClassA.h"
#import "ClassASub.h"
#import "ClassA+Category.h"
#import "ClassB.h"

@implementation OCClassMethodDemo

/*
 类的共有私有方法和变量总结：
 1> 私有方法
 概念：就是没有在.h文件中声明，只在.m文件实现的方法。
 使用：私有方法只能在本类中使用，不能在子类和分类中使用。
 
 2>私有变量
 概念1：就是在.m文件中定义的变量
 概念2：就是通过@property自动生成的私有成员变量;
 使用：私有变量也是只能在本类中使用，分类和子类都不能使用。
 
 */
- (void)run {
    ClassA *a = [ClassA new];
    ClassASub *aSub = [ClassASub new];
#pragma mark - 访问方法
    // 1.正常访问公有对象方法，类方法
    [ClassA classMethodA];
    [a methodA];
    
    // 2.OC的动态消息传递机制，使得OC没有严格意义上的私有方法。
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [a performSelector:@selector(privateMethodA)];
    [ClassA performSelector:@selector(privateClassMethodA)];
    // 3.子类会继承父类的私有方法，使用OC动态消息传递机制就可以访问到父类的私有方法，并且该私有方法遵循方法重写
    [aSub performSelector:@selector(privateMethodA)];
    // 4.category同上
    [a categoryPublicMethod];
    [a performSelector:@selector(categoryPrivateMethod)];
    // 5.extension同上
    [a performSelector:@selector(extensionMethod)];
#pragma clang diagnostic pop
    
#pragma mark - 访问变量
    // 1.实例变量遵循使用@public、@protected、@private修饰的规则，另外使用@property声明的变量是私有变量。
    NSLog(@"%d", a->varPublic);            // 可以访问共有变量
    //        NSLog(@"%d", a->var2);               // 不可访问私有变量，编译错误
    //        NSLog(@"%d", a->varPublicProperty);  // 不可访问，@property声明的变量是私有变量
    
    // static测试
    staticTest();
}

void staticTest() {
    // 在main中访问ClassB类中的静态常量，静态变量
    //    extern const int var_global;
    NSLog(@"%d", var_global);
    //    extern int var_static;
    NSLog(@"%d", --var_static);
    
}

@end
