//
//  NSString+PAFormat.h
//  haofang
//
//  Created by DengJinlong on 1/20/15.
//  Copyright (c) 2015 平安好房. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PAFormat)

// 将人数规格化
+ (NSString *)getFormateFromNumberOfPeople:(NSInteger)numberOfPeople;

+ (NSString *)getFormateFileLength:(NSUInteger)length;

@end

#pragma mark - 电话格式化
@interface NSString (Telephone)
//将手机号码分割开 3-4-4
- (NSString *)getFormateNOFromMobilePhone;
//将电话号码分割开 3-3-4
- (NSString *)getFormateNOFromTelephone;
//获取用于显示电话的字符串
- (NSString *)getShowPhone;
//获取符合拨打电话规则的字符串
- (NSString *)getDellPhone;
//剔除通讯录中电话的特殊字符
- (NSString *)getLegalPhone;
@end

#pragma mark - 金额格式化
@interface NSString (CurrencyForm)
// 1000 格式化为 1,000
+ (NSString*) stringWithCurrencyRMBFormWithPrice:(CGFloat)price;
// 1000 格式化为 1000元
+ (NSString*) stringWithCurrencyChineseFormWithPrice:(CGFloat)price;
@end

#pragma - 银行卡格式化
@interface NSString (CardFormat) 
// 格式化为 xxxx xxxx xxxx xxxx
- (NSString *)formateBankCard;
// 可以指定分隔符
- (NSString *)formateBankCardWithSeparetor:(NSString *)separetor;
// 去除多余号
- (NSString *)removeBankCardSeparetor:(NSString *)separetor;
@end