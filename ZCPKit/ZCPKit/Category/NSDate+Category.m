//
//  NSDate+Category.m
//  ZCPKit
//
//  Created by zhuchaopeng on 16/9/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "NSDate+Category.h"
#import "NSDateFormatter+Category.h"

#pragma mark - 日期与字符串转换相关

@implementation NSDate (String)

// 字符串转换成日期
+ (NSDate *)dateFromString:(NSString *)dateString {
    return [self dateFromString:dateString withDateFormat:@"yyyy-MM-dd"];
}

+ (NSDate *)dateFromYDMHmsString:(NSString *)dateString {
    return [self dateFromString:dateString withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSDate *)dateFromString:(NSString *)dateString withDateFormat:(NSString *)format {
    NSDateFormatter *formatter = [NSDateFormatter staticDateFormatter];
    [formatter setDateFormat:format];
    return [formatter dateFromString:dateString];
}

// 当前NSDate对象转换成字符串
- (NSString *)toString {
    return [NSString stringFromDate:self];
}

@end
