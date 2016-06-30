//
//  NSString+PACheckValid.m
//  haofang
//
//  Created by DengJinlong on 1/20/15.
//  Copyright (c) 2015 平安好房. All rights reserved.
//

#import "NSString+PACheckValid.h"

@implementation NSString (PACheckValid)

- (BOOL)isValidNumber {
    if (self.trim.length==0) {
        return NO;
    }
    NSString *pattern = @"^\\d+$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    
    return [regextestmobile evaluateWithObject:self];
}

- (BOOL)isValidPhoneNumber {
    if (self.trim.length==0) {
        return NO;
    }
    NSString *pattern = @"^1[0-9]{10}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    
    return [regextestmobile evaluateWithObject:self];
}

//是否是默认昵称
- (BOOL)isDefaultNickName {
    if (self.trim.length==0) {
        return NO;
    }
    NSString *pattern = @"^\\d{3}\\*{4}\\d{4}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    
    return [regextestmobile evaluateWithObject:self];
}

//是否是合法邮箱
-(BOOL)isValidateEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]+";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL check = [emailTest evaluateWithObject:self];
    return check;
}

// 英文字符，汉字，数字
- (BOOL)isValidNickName {
    if (self.length > 20) {
        return NO;
    }
    NSString *pattern = @"^[\u4e00-\u9fa5a-zA-Z0-9]+$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [regextestmobile evaluateWithObject:self];
}

// 设置密码，注册时使用
- (BOOL)isValidPasswd  {
    if (self.length < 6 || self.length > 16) {
        return NO;
    }
    //    NSString *pattern = @"^[a-zA-Z0-9]+$";
    //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    //    return [regextestmobile evaluateWithObject:self];
    return YES;
}

- (BOOL)isValidVerifyCode {
    if (self.length != 6 || ![self isPureInt]) {
        return NO;
    }
    return YES;
} 

- (BOOL)isZJDValidBankCard {
    if (self.trim.length==0) {
        return NO;
    }
    NSString *regex = @"^(\\d{16,21})$";
    return [[self getMatchesForRegex:regex] count] != 0;
}

- (BOOL)isValidBankCard {
    if (self.trim.length==0) {
        return NO;
    }
    NSString *regex = @"^(\\d{16}|\\d{19})$";
    return [[self getMatchesForRegex:regex] count] != 0;
}

- (BOOL) validChineseName {
    if (self.trim.length==0) {
        return NO;
    }
    NSString *regex = @"^[\u4e00-\u9fa5]{2,10}$";
    return [[self getMatchesForRegex:regex] count] != 0;
}


- (BOOL) validIDCardNumber {
    if (self.trim.length==0) {
        return NO;
    }
    NSString *regex = @"^(\\d{17}x|\\d{18})$";
    return [[self getMatchesForRegex:regex] count] != 0;
}


// 合法的支付密码（注意，支付密码规则和登陆密码略有不同）
- (BOOL) validPaymentPassword {
    NSString *formatRegex = @"^[a-zA-Z\\d]{6,20}$";
    if ([[self getMatchesForRegex:formatRegex] count] == 0) {
        return NO;
    }
    
    formatRegex = @"(\\d[a-zA-Z]|[a-zA-Z]\\d)+";
    if ([[self getMatchesForRegex:formatRegex] count] == 0) {
        return NO;
    }
    
    return YES;
}

//验证登陆密码 6~20位数字、字母（2.3.0去掉特殊字符校验）
- (BOOL)validLoginPassword{
    NSString *formatRegex = @"^(?=.*[0-9]+.*[A-Za-z]+.*|.*[A-Za-z]+.*[0-9]+.*).{6,20}$";
    if ([[self getMatchesForRegex:formatRegex] count] == 0) {
        return NO;
    }
    return YES;
}


// 检查金额是否正确
- (BOOL) validCurrency {
    NSString *currencyRegex = @"^(\\d{1,3},?)+(\\.\\d{1,2})?$";
    NSArray *matches = [self getMatchesForRegex:currencyRegex];
    return matches.count > 0;
}

//是否有效的浮点型
-(bool) isValidFloat{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

//是否有效的整型
-(bool) isValidInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

@end
