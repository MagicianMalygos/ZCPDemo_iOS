//
//  AlgorithmDemo.m
//  Demo
//
//  Created by apple on 16/4/12.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "AlgorithmDemo.h"
#import "TreeDemo.h"

@implementation AlgorithmDemo

- (void)run {
    [self noRepeatRandomListWithMin:1 max:4];
    
    NSLog(@"%@", [self getListWithMax:13 count:5]);
    NSLog(@"%@", [self getListWithMax:13 count:5]);
    NSLog(@"%@", [self getListWithMax:13 count:5]);
    NSLog(@"%@", [self getListWithMax:13 count:5]);
    
    NSLog(@"%@", [self getListWithMax:13 count:5]);
    NSLog(@"%@", [self getListWithMax:15 count:10]);
    NSLog(@"%@", [self getListWithMax:10 count:5]);
    NSLog(@"%@", [self getListWithMax:9 count:2]);
    
    // -- 二叉树 --
    [TreeDemo run];
}

- (void)noRepeatRandomListWithMin:(int)min max:(int)max {
    
    // -- 生成随机序列 --
    // 1
    // 初始化数组
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:max - min + 1];
    for (int i = min; i <= max; i++) {
        [arr addObject:@(i)];
    }
    // 产生随机序列
    for (int index = max - min; index >= 0; index--) {
        int randomIndex = RANDOM(0, max - min);
        NSInteger temp = [arr[index] integerValue];
        arr[index] = @([arr[randomIndex] integerValue]);
        arr[randomIndex] = @(temp);
    }
    
    // 打印结果
    for (NSNumber *n in arr) {
        printf("%li", [n integerValue]);
    }
    printf("\n");
    
    // 2
    int a[100];
    
    // 初始化数组
    int index = 0;
    for (int i = min; i <= max; i++) {
        a[index ++] = i;
    }
    // 产生随机序列
    for (int index = max - min; index >= 0; index--) {
        int randomIndex = RANDOM(0, max - min);
        int temp = a[index];
        a[index] = a[randomIndex];
        a[randomIndex] = temp;
    }
    // 打印结果
    for (int i = 0; i < max - min + 1; i++) {
        printf("%d", a[i]);
    }
    printf("\n");
}

- (NSArray *)getListWithMax:(int)max count:(int)count {
    NSMutableArray *arr = [NSMutableArray array];
    NSMutableArray *resultArr = [NSMutableArray array];

    for (int i = 1; i <= max; i++) {
        [arr addObject:@(i)];
    }
    
    for (int alreadyCount = 0; alreadyCount < count; alreadyCount++) {
        int randomIndex = RANDOM(0, arr.count - 1);
        NSNumber *resultNumber = arr[randomIndex];
        [resultArr addObject:[NSNumber numberWithInt:[resultNumber intValue]]];
        [arr removeObject:resultNumber];
    }
    return resultArr;
}

@end
