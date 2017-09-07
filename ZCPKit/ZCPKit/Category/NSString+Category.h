//
//  NSString+Category.h
//  ZCPKit
//
//  Created by zhuchaopeng on 16/9/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDateFormatter+Category.h"
#import "NSDate+Category.h"

@interface NSString (Category)

/**
 是否包含特定字符串

 @param str 特定字符串

 @return 是否包含
 */
- (BOOL)contains:(NSString *)str;

@end

#pragma mark - 日期与字符串转换相关

@interface NSString (Date)

/**
 日期转换成字符串

 @param date 时间对象

 @return 转换后的字符串，yyyy-MM-dd格式
 */
+ (NSString *)stringFromDate:(NSDate *)date;

/**
 日期转换成字符串

 @param date 时间对象

 @return 转换后的字符串，yyyy-MM-dd HH-mm-ss格式
 */
+ (NSString *)stringFromYDMHmsDate:(NSDate *)date;

/**
 日期转换成字符串

 @param date   时间对象
 @param format 转换格式

 @return 转换后的字符串
 */
+ (NSString *)stringFromDate:(NSDate *)date withDateFormat:(NSString *)format;

/**
 当前NSString对象转换成日期
 
 @return 转换后的日期
 */
- (NSDate *)toDate;

@end

#pragma mark - Remove Emoji

@interface NSString (RemoveEmoji)

/**
 判断字符串中是否含有Emoji表情

 @return 是否含有
 */
- (BOOL)isIncludeEmoji;

/**
 移除字符串中的Emoji表情
 不改变原字符串，返回移除后的字符串

 @return 移除emoji表情后的字符串
 */
- (instancetype)stringRemoveEmoji;

@end

#pragma mark - URL

@interface NSString (URL)

/**
 应用url协议

 @return NSString
 */
+ (NSString *)appURLScheme;


/**
 是否web url

 @return BOOL
 */
- (BOOL)isWebURL;

/**
 是否app url

 @return BOOL
 */
- (BOOL)isAppURL;


/**
 获取url里面的参数
 
 @return 参数集
 */
- (NSDictionary *)getURLParams;

@end


