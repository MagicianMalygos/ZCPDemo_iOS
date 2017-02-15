//
//  RuntimeDemo.m
//  Demo
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "RuntimeDemo.h"
#import "RuntimeTest1.h"
#import "RuntimeTest2.h"
#import "RuntimeTest3.h"
#import "RuntimeExampleDemo.h"

@implementation RuntimeDemo

- (void)run {
    // 认识数据类型
    //    Test *test = [Test new];
    //    [test ex_registerClassPair];
    //    NSLog(@"\n\n\n\n");
    //    [test classOperation];
    //    NSLog(@"\n\n\n\n");
    //    [test dynamicCreate];
    //    NSLog(@"\n\n\n\n");
    //    [test operationFouction];
    
    //    Test2 *test2 = [Test2 new];
    //    [test2 typeEncoding];
    //    NSLog(@"\n\n\n\n");
    //    test2.frame = CGRectMake(100, 100, 100, 100);
    //    test2.backgroundColor = [UIColor redColor];
    //    [test2 setTapActionWithBlock:^{
    //        NSLog(@"Tap");
    //    }];
    //    [self.view addSubview:test2];
    //    NSLog(@"\n\n\n\n");
    //    [test2 propertyOperation];
    
    // 消息处理机制
    RuntimeTest3 *test3 = [RuntimeTest3 new];
    [test3 cognize];
}

@end
