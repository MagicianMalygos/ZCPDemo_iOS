//
//  NSString+URL.m
//  ZCPKit
//
//  Created by 朱超鹏 on 2017/10/9.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)

// 是否是web url
- (BOOL)isWebURL {
    NSURL *URL      = [NSURL URLWithString:self];
    BOOL isWebURL   = ([URL.scheme caseInsensitiveCompare:@"http"] == NSOrderedSame) ||
    ([URL.scheme caseInsensitiveCompare:@"https"] == NSOrderedSame) ||
    ([URL.scheme caseInsensitiveCompare:@"ftp"] == NSOrderedSame) ||
    ([URL.scheme caseInsensitiveCompare:@"ftps"] == NSOrderedSame) ||
    ([URL.scheme caseInsensitiveCompare:@"data"] == NSOrderedSame) ||
    ([URL.scheme caseInsensitiveCompare:@"file"] == NSOrderedSame);
    return isWebURL;
}

// 获取url里面的参数
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

/// 检测字符串中的url
- (NSArray <NSString *>*)detectLink {
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    NSArray *checkingResults = [detector matchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    NSMutableArray *links = [NSMutableArray array];
    for (NSTextCheckingResult *result in checkingResults) {
        NSURL *URL = result.URL;
        NSString *url = URL.absoluteString;
        [links addObject:url];
    }
    return links;
}

@end
