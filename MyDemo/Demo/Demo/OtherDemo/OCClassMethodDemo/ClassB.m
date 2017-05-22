//
//  ClassB.m
//  AccessOCPrivateMethod
//
//  Created by apple on 15/12/1.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ClassB.h"

@implementation ClassB

- (void)sharedB {
    static int a = 0;  // 作用域为本方法
    a++;
    singleB = [ClassB new];
}
//
//- (void)test {
//    a++;      // 无法访问
//}

@end
