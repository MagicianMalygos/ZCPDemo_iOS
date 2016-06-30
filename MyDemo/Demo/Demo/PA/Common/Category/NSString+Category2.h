//
//  NSString+Category.h
//  haofang
//
//  Created by Aim on 14-3-19.
//  Copyright (c) 2014年 平安好房. All rights reserved.
//



#import <CommonCrypto/CommonDigest.h>
#import "NSString+PACheckValid.h"
#import "NSString+PAFormat.h"

NSString *fixIconString(NSString *iconString);

/* 对一个字符串进行安全URLEncode */
#define safeURLEncode(str)  (nil == str ? @"" : [str urlEncoding])

/* ---- */
#define empty(str)          (nil == str || [str length] < 1)


#pragma mark - 通用方法

/**
 *  SDK自带的 NSString 类添加一些实用方法
 */
@interface NSString (Category2)

/* NSDate转换为日期字符串 */
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)stringFromYDMHmsDate:(NSDate *)date;
+ (NSString *)stringFromDate:(NSDate *)date withDateFormat:(NSString *)format;
/* 当前字符串转为NSDate */
- (NSDate *)toDate;


//中英文长度，按字节来算
- (NSInteger)getValidLenth;

/* 计算字符串的md5值 */
- (NSString *)md5;

/* 去掉字符串两端的空白字符 */
- (NSString *) trim;

/* 对字符串URLencode编码 */
- (NSString *)urlEncoding;

/* 对字符串URLdecode解码 */
- (NSString *)urlDecoding;

/* 判断一个字符串是否全由字母组成 */
- (BOOL)is_letters;

/* 判断一个字符串是否全由数字组成 */
- (BOOL)is_numbers;

/* 判断一个字符串是否是url */
- (BOOL)is_url;

//找出字符串中的数字字符串
-(NSString *)findNumStringIndexFromString;

/* 创建一个唯一的UDID */
+ (NSString *)createUDID;

/* 从UIColor对象生成一个字符串 */
+ (NSString *)fromColor:(UIColor *)color;

/* 从字符串生成一个UIColor对象 */
- (UIColor *)toColor;

/* 从字符串生成一个UIColor对象，并指定一个默认颜色 */
- (UIColor *)toColorWithDefaultColor:(UIColor *)defaultColor;

/* 忽略大小写比较两个字符串 */
- (BOOL)equalsIgnoreCase:(NSString *)str;

/* 是否包含特定字符串 */
- (BOOL)contains:(NSString *)str;

/* 把HTML转换为TEXT文本 */
- (NSString *)html2text;

/* 移除一些HTML标签 */
- (NSString *)striptags;

/* 格式化文本 */
- (NSString *)textindent;

/* 获取文本大小 */
- (NSString *)NumberSize2StringSize:(NSInteger)numberSize;

/* 字符串是不是一个纯整数型 */
- (BOOL)isPureInt;

/* 获取 UTF8 编码的 NSData 值 */
- (NSData *)toUtf8Data;

// url相关操作
// 获取url里面的参数
- (NSDictionary *)getURLParams;

// url相关操作
// 获取url里面的以hiddenInput_开头的参数，以键值对的形式用&拼接
- (NSString *)getHiddenInput;

// 对字符串添加url参数
- (NSString *)stringByAddingURLParams:(NSDictionary *)params;


/*!
 @method
 @abstract      获取字符串中与初入正则表达式匹配规则符合的字符串数组
 @param         regex : 正则表达式
 @return        返回匹配正则表达式规则的字符串数组
 */
- (NSArray *)getMatchesForRegex:(NSString *)regex;
/*!
 @method
 @abstract      将字符串中与正则表达式匹配的字符串替换成指定的字符串
 @param         regex : 正则表达式
 @param         replace : 替换字符串
 @return        返回替换后的新字符串对象
 */
- (NSString *)stringByReplaceRegex:(NSString *)regex withString:(NSString *)replace;

// 删除最后一个字符
- (NSString *)substringByCutTail;

- (NSString *)maskedPhoneNumber;

//unicode转换
-(NSString *) utf8ToUnicode;
@end

#pragma mark - 对密码进行加密

@interface NSString(PAPasswordAdditions)
- (NSString *)passwdEncode;
@end


#pragma mark - 电话格式化

#pragma mark - 金额格式化
@interface NSString (Money)
- (NSString *)formateMoney;
@end

#pragma - 银行卡格式化
// see NSString+PAFormat.h

#pragma mark - Bse64编码
@interface NSString (DES)
- (NSString *)DESBase64EncodeWithKey:(NSString *)key;
- (NSString *)Base64DESDecodeWithKey:(NSString *)key;
@end

@interface NSString (VideoName)
+ (NSString *)createVideoName;
@end

