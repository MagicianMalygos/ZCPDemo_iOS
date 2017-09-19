//
//  TestOperation.m
//  Demo
//
//  Created by 朱超鹏 on 2017/9/15.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "TestOperation.h"

@implementation TestOperation

- (instancetype)init {
    if (self = [super init]) {
        self.lock = [[NSRecursiveLock alloc] init];
    }
    return self;
}

- (void)start {
    [self.lock lock];
    if (!self.isCancelled) {
        NSLog(@"开始执行任务%@ %@ %@", self, [NSThread currentThread], [NSOperationQueue currentQueue]);
    }
    [self.lock unlock];
}

@end
