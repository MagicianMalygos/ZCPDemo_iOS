//
//  NSString+Category.m
//  ZCPKit
//
//  Created by zhuchaopeng on 16/9/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "NSString+Category.h"
#import "ZCPURLHelper.h"

@implementation NSString (Category)

#pragma mark 是否包含特定字符串
- (BOOL)contains:(NSString *)str {
    if (nil == str || [str length] < 1) {
        return NO;
    }
    return [self rangeOfString:str].location != NSNotFound;
}

@end

#pragma mark - 日期与字符串转换相关

@implementation NSString (Date)

#pragma mark 日期转换成字符串
+ (NSString *)stringFromDate:(NSDate *)date {
    return [self stringFromDate:date withDateFormat:@"yyyy-MM-dd"];
}
+ (NSString *)stringFromYDMHmsDate:(NSDate *)date {
    return [self stringFromDate:date withDateFormat:@"yyyy-MM-dd HH-mm-ss"];
}
+ (NSString *)stringFromDate:(NSDate *)date withDateFormat:(NSString *)format {
    NSDateFormatter *formatter = [NSDateFormatter staticDateFormatter];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

#pragma mark 当前NSString对象转换成日期
- (NSDate *)toDate {
    return [NSDate dateFromString:self withDateFormat:@"yyyy-MM-dd HH-mm-ss"];
}

@end

#pragma mark - Remove Emoji

@implementation NSString (RemoveEmoji)

#pragma mark 判断字符串中是否含有Emoji表情
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
#pragma mark 移除字符串中的Emoji表情
- (instancetype)stringRemoveEmoji {
    NSMutableString* __block buffer = [NSMutableString stringWithCapacity:[self length]];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              [buffer appendString:([substring isEmoji])? @"": substring];
                          }];
    
    return buffer;
}

#pragma mark 判断字符是否是Emoji
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

@end

#pragma mark - URL

#pragma mark 获取url里面的参数
@implementation NSString (URL)

+ (NSString *)appURLScheme {
    return APP_URL_SCHEME;
}

- (BOOL)isWebURL {
    NSURL *URL = [NSURL URLWithString:self];
    return ([URL.scheme caseInsensitiveCompare:@"http"] == NSOrderedSame)
    || ([URL.scheme caseInsensitiveCompare:@"https"] == NSOrderedSame)
    || ([URL.scheme caseInsensitiveCompare:@"ftp"] == NSOrderedSame)
    || ([URL.scheme caseInsensitiveCompare:@"ftps"] == NSOrderedSame)
    || ([URL.scheme caseInsensitiveCompare:@"data"] == NSOrderedSame)
    || ([URL.scheme caseInsensitiveCompare:@"file"] == NSOrderedSame);
}

- (BOOL)isAppURL {
    NSURL       *URL            = [NSURL URLWithString:self];
    NSString    *appScheme      = [NSString appURLScheme];
    BOOL        flag            = ([URL.scheme caseInsensitiveCompare:appScheme] == NSOrderedSame);
    return flag;
}

#pragma mark 获取url里面的参数
- (NSDictionary *)getURLParams {
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    NSURL *url = [NSURL URLWithString:self];
    NSArray *params = [url.query componentsSeparatedByString:@"&"];
    for (NSString *param in params) {
        NSArray *param_key_value = [param componentsSeparatedByString:@"="];
        if (param_key_value.count == 2) {
            NSString *key = [param_key_value objectAtIndex:0];
            NSString *value = [param_key_value objectAtIndex:1];
            [paramDic setObject:[value stringByRemovingPercentEncoding] forKey:[key stringByRemovingPercentEncoding]];
        }
    }
    return paramDic;
}

@end
