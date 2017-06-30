//
//  RegexDemo.h
//  Demo
//
//  Created by 朱超鹏 on 17/3/2.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 正则表达式

@interface RegexDemo : NSObject

// 校验密码强度。包含大小写字母和数字，不能使用特殊字符，长度在8-16之间
- (BOOL)judgePassword:(NSString *)str;
// 校验中文
- (BOOL)judgeChinese:(NSString *)str;
// 校验纯数字英文下划线
- (BOOL)judgeNumberWordUpperLine:(NSString *)str;
// 校验e-mail地址
- (BOOL)judgeEmail:(NSString *)str;
// 校验身份证号15
- (BOOL)judgeIDCard15:(NSString *)str;
// 校验身份证号18
- (BOOL)judgeIDCard18:(NSString *)str;
// 校验日期
- (BOOL)judgeDate:(NSString *)str;
// 校验手机号
- (BOOL)judgePhoneNumber:(NSString *)str;

- (BOOL)judge:(NSString *)str regex:(NSString *)regex;

@end
