//
//  Test3.h
//  RuntimeDemo
//
//  Created by apple on 16/2/26.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <objc/runtime.h>

// TODO: 时间性能测量用
// 结束时间除以CLOCKS_PER_SEC得到耗时秒数
#define START_COUNT_TIME(start) clock_t start = clock()
#define END_COUNT_TIME(start) (clock() - start)

@interface RuntimeTest3 : NSObject

- (void)cognize;

@end

/*
    // 方法选择器，表示一个方法的selector的指针，SEL就是为了查找方法的最终实现IMP的
    typedef struct objc_selector *SEL;
 
    // IMP实际上是一个函数指针，指向方法实现的首地址
    id (*IMP)(id, SEL, ...)
 
    // Method用来表示类定义中的方法
    typedef struct objc_method *Method;
 
    struct objc_method {
        SEL method_name                     OBJC2_UNAVAILABLE;  // 方法名
        char *method_types                  OBJC2_UNAVAILABLE;
        IMP method_imp                      OBJC2_UNAVAILABLE;  // 方法实现
    }
 */
