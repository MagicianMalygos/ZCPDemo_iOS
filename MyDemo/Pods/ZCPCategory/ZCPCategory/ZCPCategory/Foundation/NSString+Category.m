//
//  NSString+Category.m
//  ZCPKit
//
//  Created by zhuchaopeng on 16/9/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)

#pragma mark -
// 判断是否包含特定字符串
- (BOOL)contains:(NSString *)str {
    if (nil == str || [str length] < 1) {
        return NO;
    }
    return [self rangeOfString:str].location != NSNotFound;
}

/// 转换为json对象
- (id)JSONObject {
    NSError *err        = nil;
    NSObject *object    = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&err];
    if (err == nil) {
        return object;
    } else {
        return nil;
    }
}

+ (NSString *)UUIDString {
    CFUUIDRef u = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef s = CFUUIDCreateString(kCFAllocatorDefault, u);
    CFRelease(u);
    return (NSString *)CFBridgingRelease(s);
}

- (NSString *)urlEncodeString {
    NSString *result = (__bridge_transfer NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
    return result;
}

- (NSString *)urlDecodeString {
    NSString *result = (__bridge_transfer NSString*)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (__bridge CFStringRef)self, CFSTR(""), kCFStringEncodingUTF8);
    return result;
}

#pragma mark - iconfont

/// 将hex字符串转换成iconfont字符串
+ (NSString *)iconFromHexString:(NSString *)hexString {
    hexString = hexString.lowercaseString;
    int  length = (int)hexString.length;
    unichar sum = 0;
    for (int i = length - 1; i >= 0; i--) {
        
        char c = (char)[hexString characterAtIndex:i];
        if (c >= '0' && c <= '9') {
            c = c - '0';
        } else if(c >= 'a' && c <= 'f') {
            c = c - 'a' + 10;
        }
        sum += c * (int)pow(16, length - 1 - i);
    }
    
    NSString *icon = [NSString stringWithCharacters:&sum length:1];
    return icon;
}

#pragma mark - 日期/字符串转换
// 日期转换成字符串 yyyy-MM-dd格式
+ (NSString *)stringFromDate:(NSDate *)date {
    NSString *sDate = [self stringFromDate:date withDateFormat:@"yyyy-MM-dd"];
    return sDate;
}

// 日期转换成字符串 yyyy-MM-dd HH-mm-ss格式
+ (NSString *)stringFromYDMHmsDate:(NSDate *)date {
    NSString *sDate = [self stringFromDate:date withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return sDate;
}

// 日期转换成字符串 自定义转换格式
+ (NSString *)stringFromDate:(NSDate *)date withDateFormat:(NSString *)format {
    NSDateFormatter *formatter = [NSDateFormatter staticDateFormatter];
    [formatter setDateFormat:format];
    NSString *sDate = [formatter stringFromDate:date];
    return sDate;
}

// 转换成日期 yyyy-MM-dd格式
- (NSDate *)toDate {
    NSDate *date = [NSDate dateFromString:self];
    return date;
}

// 转换成日期 yyyy-MM-dd HH:mm:ss格式
- (NSDate *)toYDMHmsDate {
    NSDate *date = [NSDate dateFromYDMHmsString:self];
    return date;
}

// 转换成日期 自定义格式
- (NSDate *)toDateWithDateFormat:(NSString *)format {
    NSDate *date = [NSDate dateFromString:self withDateFormat:format];
    return date;
}

#pragma mark - Remove Emoji
// 判断字符串中是否含有Emoji表情
- (BOOL)isIncludeEmoji {
    BOOL __block result = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              if ([substring isEmoji]) {
                                  *stop = YES;
                                  result = YES;
                              }
                          }];
    return result;
}

// 移除字符串中的Emoji表情。不改变原字符串，返回移除后的字符串
- (NSString *)stringRemoveEmoji {
    NSMutableString* __block buffer = [NSMutableString stringWithCapacity:[self length]];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              [buffer appendString:([substring isEmoji])? @"": substring];
                          }];
    
    return buffer;
}

// 判断字符是否是Emoji
- (BOOL)isEmoji {
    
    NSCharacterSet *variationSelectors = [NSCharacterSet characterSetWithRange:NSMakeRange(0xFE00, 16)];
    if ([self rangeOfCharacterFromSet:variationSelectors].location != NSNotFound) {
        return YES;
    }
    
    const unichar high = [self characterAtIndex: 0];
    
    // Surrogate pair (U+1D000-1F9FF)
    if (0xD800 <= high && high <= 0xDBFF) {
        const unichar low = [self characterAtIndex: 1];
        const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
        
        return (0x1D000 <= codepoint && codepoint <= 0x1F9FF);
        
        // Not surrogate pair (U+2100-27BF)
    } else {
        return (0x2100 <= high && high <= 0x27BF);
    }
}

#pragma mark - chinese

+ (BOOL)isChinesecharacter:(NSString *)string{
    if (string.length == 0) {
        return NO;
    }
    unichar c = [string characterAtIndex:0];
    if (c >=0x4E00 && c <=0x9FA5)     {
        return YES;//汉字
    }else {
        return NO;//英文
    }
}

+ (NSInteger)chineseCountOfString:(NSString *)string{
    int ChineseCount = 0;
    if (string.length == 0) {
        return 0;
    }
    for (int i = 0; i<string.length; i++) {
        unichar c = [string characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FA5){
            ChineseCount++ ;//汉字
        }
    }
    return ChineseCount;
}

+ (NSInteger)characterCountOfString:(NSString *)string{
    int characterCount = 0;
    if (string.length == 0) {
        return 0;
    }
    for (int i = 0; i<string.length; i++) {
        unichar c = [string characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FA5){
        }else {
            characterCount++;//英文
        }
    }
    return characterCount;
}

@end
