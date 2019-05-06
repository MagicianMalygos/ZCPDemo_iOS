//
//  NSDateFormatter+Category.m
//  ZCPKit
//
//  Created by zhuchaopeng on 16/9/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "NSDateFormatter+Category.h"

#pragma mark - 日期格式化单例对象

static NSDateFormatter *staticDateFormatter;

@implementation NSDateFormatter (Category)

+ (nonnull instancetype)staticDateFormatter {
    static dispatch_once_t once;
    static id __singleton__;
    dispatch_once(&once, ^{
        __singleton__ = [[self alloc] init];
    });
    return __singleton__;
}

@end
