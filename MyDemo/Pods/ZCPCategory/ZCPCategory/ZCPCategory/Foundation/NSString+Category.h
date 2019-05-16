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

#pragma mark - 
/**
 判断是否包含特定字符串
 */
- (BOOL)contains:(NSString *)str;

/**
 转换为json对象
 */
- (id)JSONObject;

- (NSString *)urlEncodeString;
- (NSString *)urlDecodeString;

#pragma mark - iconfont

/**
 将hex字符串转换成iconfont字符串

 @param hexString hex字符串，如"f846"、"e507"
 @return iconfont字符串，如"\U0000f846"、"\U0000e507"
 */
+ (NSString *)iconFromHexString:(NSString *)hexString;

#pragma mark - 日期/字符串转换

/**
 日期转换成字符串 yyyy-MM-dd格式
 */
+ (NSString *)stringFromDate:(NSDate *)date;

/**
 日期转换成字符串 yyyy-MM-dd HH-mm-ss格式
 */
+ (NSString *)stringFromYDMHmsDate:(NSDate *)date;

/**
 日期转换成字符串 自定义转换格式
 */
+ (NSString *)stringFromDate:(NSDate *)date withDateFormat:(NSString *)format;

/**
 转换成日期 yyyy-MM-dd格式
 */
- (NSDate *)toDate;

/**
 转换成日期 yyyy-MM-dd HH:mm:ss格式
 */
- (NSDate *)toYDMHmsDate;

/**
 转换成日期 自定义格式
 */
- (NSDate *)toDateWithDateFormat:(NSString *)format;


#pragma mark - Remove Emoji
/**
 判断字符串中是否含有Emoji表情
 */
- (BOOL)isIncludeEmoji;

/**
 移除字符串中的Emoji表情。不改变原字符串，返回移除后的字符串
 */
- (NSString *)stringRemoveEmoji;

#pragma mark - chinese

/**
 判断是否为汉字
 */
+ (BOOL)isChinesecharacter:(NSString *)string;

/**
 计算汉字的个数
 */
+ (NSInteger)chineseCountOfString:(NSString *)string;

/**
 计算字母的个数
 */
+ (NSInteger)characterCountOfString:(NSString *)string;

@end
