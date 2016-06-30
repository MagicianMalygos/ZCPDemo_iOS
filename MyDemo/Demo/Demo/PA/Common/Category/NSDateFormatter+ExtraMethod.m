//
//  NSDateFormatter+ExtraMethod.m
//  haofang
//
//  Created by leo on 14-9-5.
//  Copyright (c) 2014年 平安好房. All rights reserved.
//

#import "NSDateFormatter+ExtraMethod.h"

static NSDateFormatter *staticDateFormatter;

@implementation NSDateFormatter (ExtraMethod)

+ (NSDateFormatter *)staticDateFormatter
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticDateFormatter = [[NSDateFormatter alloc] init];
    });
    return staticDateFormatter;
}

@end
