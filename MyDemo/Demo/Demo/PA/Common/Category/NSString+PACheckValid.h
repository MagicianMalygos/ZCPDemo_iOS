//
//  NSString+PACheckValid.h
//  haofang
//
//  Created by DengJinlong on 1/20/15.
//  Copyright (c) 2015 平安好房. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 数值有效性检查

@interface NSString (PACheckValid)

- (BOOL)isValidNumber;
- (BOOL)isValidPhoneNumber;
//是否是默认昵称
- (BOOL)isDefaultNickName;
//是否是合法邮箱
-(BOOL)isValidateEmail;
- (BOOL)isValidNickName;
- (BOOL)isValidPasswd;
- (BOOL)isValidVerifyCode;
/**
 *  @brief  银行卡有效检查 16 或 19位
 */
- (BOOL)isValidBankCard;
/**
 *  @brief 银行卡6-21位
 */
- (BOOL)isZJDValidBankCard; 


/*!
 @method
 @abstract      检查是否是有效的中文名字
 @return        返回验证成功与否
 */
- (BOOL) validChineseName;

/*!
 @method
 @abstract      是否是有效的身份证号码（18位数字或者17位数字加最后以x结尾）
 @return        返回验证成功与否
 */
- (BOOL) validIDCardNumber;

/*!
 @method
 @abstract      检查是否是合法的支付密码
 @return        返回验证成功与否
 */
- (BOOL) validPaymentPassword;

/*!
 @method
 @abstract      检查是否是合法的登陆密码
 @return        返回验证成功与否
 */
- (BOOL)validLoginPassword;

/*!
 @method
 @abstract      检查金额是否正确
 @return        返回验证成功与否
 */
- (BOOL) validCurrency;

//是否有效的浮点型
-(bool) isValidFloat;

//是否有效的整型
-(bool) isValidInt;

@end


