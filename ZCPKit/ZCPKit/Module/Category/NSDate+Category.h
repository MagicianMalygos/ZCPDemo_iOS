//
//  NSDate+Category.h
//  ZCPKit
//
//  Created by zhuchaopeng on 16/9/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDateFormatter+Category.h"
#import "NSString+Category.h"


#pragma mark - 日期与字符串转换相关

@interface NSDate (String)

/**
 字符串转换成日期

 @param dateString 日期字符串，yyyy-MM-dd格式

 @return 转换后的日期
 */
+ (NSDate *)dateFromString:(NSString *)dateString;

/**
 字符串转换成日期

 @param dateString 日期字符串，yyyy-MM-dd HH:mm:ss格式

 @return 转换后的日期
 */
+ (NSDate *)dateFromYDMHmsString:(NSString *)dateString;


/**
 字符串转换成日期

 @param dateString 日期字符串
 @param format     转换格式

 @return 转换后的日期
 */
+ (NSDate *)dateFromString:(NSString *)dateString withDateFormat:(NSString *)format;
/* 当前NSDate转为字符串 */


/**
 当前NSDate对象转换成字符串
 yyyy-MM-dd格式

 @return 转换后的字符串
 */
- (NSString *)toString;

@end
