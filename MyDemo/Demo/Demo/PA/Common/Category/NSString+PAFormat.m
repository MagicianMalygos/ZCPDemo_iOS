//
//  NSString+PAFormat.m
//  haofang
//
//  Created by DengJinlong on 1/20/15.
//  Copyright (c) 2015 平安好房. All rights reserved.
//

#import "NSString+PAFormat.h"

@implementation NSString (PAFormat)

// 将人数规格化
+ (NSString *)getFormateFromNumberOfPeople:(NSInteger)numberOfPeople {
    NSString *result = @"0";
    if (numberOfPeople >= 10000) {
        numberOfPeople -= numberOfPeople % 1000;
        result = [NSString stringWithFormat:@"%.1fw", numberOfPeople / 10000.0f];
    } else if (numberOfPeople >= 1000) {
        numberOfPeople -= numberOfPeople % 100;
        result = [NSString stringWithFormat:@"%.1fk", numberOfPeople / 1000.0f];
    } else {
        result = [NSString stringWithFormat:@"%li", numberOfPeople];
    }
    return result;
}

+ (NSString *)getFormateFileLength:(NSUInteger)length {
    return [NSByteCountFormatter stringFromByteCount:length countStyle:NSByteCountFormatterCountStyleFile];
}

@end

@implementation NSString (Telephone)

//将手机号码分割开 3-4-4
- (NSString *)getFormateNOFromMobilePhone{
    NSString *resultphone = @"";
    
    int i=3;
    if (i<self.length) {
        resultphone = [resultphone stringByAppendingString:[self substringToIndex:i]];
        resultphone = [resultphone stringByAppendingString:@" "];
    }
    NSRange range;
    range.location = 3;
    range.length = 4;
    i+=4;
    if (i<self.length) {
        resultphone = [resultphone stringByAppendingString:[self substringWithRange:range]];
        resultphone = [resultphone stringByAppendingString:@" "];
        
        resultphone = [resultphone stringByAppendingString:[self substringFromIndex:7]];
    }
    
    return resultphone;
}

//将电话号码分割开 3-3-4
- (NSString *)getFormateNOFromTelephone{
    NSString *resultphone = @"";
    
    int i=3;
    if (i<self.length) {
        resultphone = [resultphone stringByAppendingString:[self substringToIndex:i]];
        resultphone = [resultphone stringByAppendingString:@" "];
    }
    NSRange range;
    range.location = 3;
    range.length = 3;
    i+=3;
    if (i<self.length) {
        resultphone = [resultphone stringByAppendingString:[self substringWithRange:range]];
        resultphone = [resultphone stringByAppendingString:@" "];
        
        resultphone = [resultphone stringByAppendingString:[self substringFromIndex:6]];
    }
    
    return resultphone;
}

//获取用于显示电话的字符串
- (NSString *)getShowPhone{
    NSString *phone = @"";
    if ([self isValidPhoneNumber]) {
        return self;
    }else{
        if ([self contains:@","]) {
            NSArray *phoneArray = [self componentsSeparatedByString:@","];
            if (phoneArray.count>1) {
                phone = [[phoneArray objectAtIndex:0] getFormateNOFromTelephone];
                phone = [phone stringByAppendingString:@" 转 "];
                phone = [phone stringByAppendingString:[phoneArray objectAtIndex:1]];
            }
        }else{
            phone = [self getFormateNOFromTelephone];
        }
    }
    return phone;
}

//获取符合拨打电话规则的字符串
- (NSString *)getDellPhone{
    if (![self isValidPhoneNumber]) {
        if ([self contains:@"-"]) {//处理拨打分机号的字符串
            return [self stringByReplacingOccurrencesOfString:@"-" withString:@","];
        }
    }
    return self;
}

//剔除通讯录中电话的特殊字符
- (NSString *)getLegalPhone
{
    static NSArray *illegalChars = nil;
    if (illegalChars == nil) {
        illegalChars = @[@"(", @")", @"-", @"_", @" ", @" "];
    }
    NSString *result = self;
    for (NSString *illegal in illegalChars) {
        result = [result stringByReplacingOccurrencesOfString:illegal withString:@""];
    }
    return result;
}

@end

@implementation NSString (CurrencyForm)

+ (NSString*) stringWithCurrencyRMBFormWithPrice:(CGFloat)price {
    NSMutableString* value = [[NSMutableString alloc] initWithFormat:@"%.02f", price];
    
    NSRange range = [value rangeOfString:@"."];
    NSInteger index = range.location;
    while (index - 3 > 0) {
        index -= 3;
        [value insertString:@"," atIndex:index];
    }
    
    return value;
}

+ (NSString*) stringWithCurrencyChineseFormWithPrice:(CGFloat)price {
    NSString* value = nil;
    if (price < 10000.0f) {
        value = [NSString stringWithFormat:@"%.02f元", price];
    } else if (price < 1000000.0f) {
        value = [NSString stringWithFormat:@"%.02f万元", price / 10000.0f];
    } else if (price < 100000000.0f) {
        value = [NSString stringWithFormat:@"%.02f百万元", price / 1000000.0f];
    } else {
        value = [NSString stringWithFormat:@"%.02f亿元", price / 100000000.0f];
    }
    
    return value;
}

@end

@implementation NSString (CardFormat)

- (NSString *)formateBankCard {
    return [self formateBankCardWithSeparetor:@" "];
}

- (NSString *)formateBankCardWithSeparetor:(NSString *)separetor {
    NSString *sp = (separetor?:@" ");
    NSString *integerString = [self stringByReplacingOccurrencesOfString:sp withString:@""];
    
    NSUInteger selfLen = [integerString length];
    NSUInteger len = 4;
    NSMutableString *newString = [NSMutableString string];
    NSUInteger i = 0;
    for (; i < selfLen; i += len) {
        // 防止range溢出
        NSUInteger rangeLength = (i+len>=selfLen)?(selfLen-i):len;
        NSRange range = NSMakeRange(i, rangeLength);
        [newString appendString:[integerString substringWithRange:range]];
        if(i != selfLen-4 && rangeLength == len){
            [newString appendString:sp];
        }
    }
    
    return newString;
}

- (NSString *)removeBankCardSeparetor:(NSString *)separetor {
    NSString *sp = (separetor?:@" ");
    NSString *integerString = [self stringByReplacingOccurrencesOfString:sp withString:@""];
    return integerString;
}

@end
