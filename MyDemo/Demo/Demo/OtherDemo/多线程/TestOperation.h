//
//  TestOperation.h
//  Demo
//
//  Created by 朱超鹏 on 2017/9/15.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestOperation : NSOperation

@property (readwrite, nonatomic, strong) NSRecursiveLock *lock;

@end
