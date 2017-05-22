//
//  RegexDemo.m
//  Demo
//
//  Created by 朱超鹏 on 17/3/2.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "RegexDemo.h"

@implementation RegexDemo

- (void)run {
    
    // 1.ok
    [self test:@"校验密码强度"
        method:@"judgePassword:"
          data:@[@{@"123": @"NO"},
                 @{@"1234567": @"NO"},
                 @{@"abc123": @"NO"},
                 @{@"Zcp123": @"YES"},
                 @{@"Zchaopeng123": @"YES"},
                 @{@"Zcpmac1_80437": @"YES"},
                 @{@"Zcpabcdef1234567890": @"NO"}]];
    // 2.ok
    [self test:@"校验中文"
        method:@"judgeChinese:"
          data:@[@{@"一二三": @"YES"},
                 @{@"中国人": @"YES"},
                 @{@"……&": @"NO"},
                 @{@"123": @"NO"},
                 @{@"an": @"NO"},
                 @{@"……&哈": @"NO"},
                 @{@"123哈": @"NO"},
                 @{@"an哈": @"NO"},
                 @{@"😁": @"NO"}]];
    // 3.no
    [self test:@"校验纯数字英文下划线"
        method:@"judgeNumberWordUpperLine:"
          data:@[@{@"中": @"NO"}, // no
                 @{@"……&": @"NO"},
                 @{@"123": @"YES"},
                 @{@"abc": @"YES"},
                 @{@"__": @"YES"},
                 @{@"abc123": @"YES"},
                 @{@"abc_123": @"YES"},
                 @{@"😁": @"NO"}]];
    
    // 4.ok
    [self test:@"校验e-mail地址"
        method:@"judgeEmail:"
          data:@[@{@"164757979@qq.com": @"YES"},
                 @{@"@.com": @"NO"},
                 @{@"123@456.": @"NO"},
                 @{@"1234an@": @"NO"}]];
    
    // 5.ok
    [self test:@"校验身份证号15"
        method:@"judgeIDCard15:"
          data:@[@{@"411081225123411": @"NO"},
                 @{@"222102926182241": @"NO"},
                 @{@"000000000000000": @"NO"},
                 @{@"110105710923582": @"YES"},
                 @{@"1234567890": @"NO"}]];
    // 6.ok
    [self test:@"校验身份证号18"
        method:@"judgeIDCard18:"
          data:@[@{@"411081192251234114": @"NO"},
                 @{@"222102199261822419": @"NO"},
                 @{@"000000190000000001": @"NO"},
                 @{@"110105197109235829": @"YES"},
                 @{@"41108119931211205X": @"YES"},
                 @{@"1234567890": @"NO"}]];
    // 7.ok
    [self test:@"校验日期"
        method:@"judgeDate:"
          data:@[@{@"2017-3-3": @"NO"},
                 @{@"2017-03-03": @"YES"},
                 @{@"2000-02-29": @"YES"},
                 @{@"2001-02-29": @"NO"},
                 @{@"2001-02-28": @"YES"},
                 @{@"2000-02-30": @"NO"},
                 @{@"2000-04-31": @"NO"},
                 @{@"2000-08-31": @"YES"}]];
    // 8.ok
    [self test:@"校验手机号"
        method:@"judgePhoneNumber:"
          data:@[@{@"18850459303": @"YES"},
                 @{@"12345678901": @"NO"},
                 @{@"18300001111": @"YES"},
                 @{@"15402201124": @"NO"}]];
}




#pragma mark - judege

// 校验密码强度。包含大小写字母和数字，不能使用特殊字符，长度在8-16之间
- (BOOL)judgePassword:(NSString *)str {
    return [self judge:str regex:@"^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{6,18}$"];
}
// 校验中文
- (BOOL)judgeChinese:(NSString *)str {
    return [self judge:str regex:@"^[\u4e00-\u9fa5]{0,}$"];
    
}
// 校验纯数字英文下划线
- (BOOL)judgeNumberWordUpperLine:(NSString *)str {
    return [self judge:str regex:@"^\\w+$"];
}
// 校验e-mail地址
- (BOOL)judgeEmail:(NSString *)str {
    return [self judge:str regex:@"[\\w!#$%&'*+/=?^_`{|}~-]+(?:\\.[\\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\\w](?:[\\w-]*[\\w])?\\.)+[\\w](?:[\\w-]*[\\w])?"];
}
// 校验身份证号15
- (BOOL)judgeIDCard15:(NSString *)str {
    return [self judge:str regex:@"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$"];
}
// 校验身份证号18
- (BOOL)judgeIDCard18:(NSString *)str {
    return [self judge:str regex:@"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$"];
}
// 校验日期
- (BOOL)judgeDate:(NSString *)str {
    return [self judge:str regex:@"^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$"];
}
// 校验手机号
- (BOOL)judgePhoneNumber:(NSString *)str {
    return [self judge:str regex:@"^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\\d{8}$"];
}
// 





#pragma mark - private method

- (void)test:(NSString *)msg method:(NSString *)method data:(NSArray *)arr  {
    __block NSString *testResult = @"";
    __block NSString *trueResult = @"";
    for (NSDictionary *dic in arr) {
        WEAK_SELF;
        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            BOOL result     = [weakSelf performSelector:NSSelectorFromString(method) withObject:key];
            trueResult      = [trueResult stringByAppendingString:[NSString stringWithFormat:@"%@ ", obj]];
            if (result) {
                testResult  = [testResult stringByAppendingString:@"YES "];
            } else {
                testResult  = [testResult stringByAppendingString:@"NO "];
            }
        }];
    }
    ZCPLog(@"%@：\ntest：%@\ntrue：%@", msg, testResult, trueResult);
}

- (BOOL)judge:(NSString *)str regex:(NSString *)regex {
    NSPredicate *predicate  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:str];
}

@end
