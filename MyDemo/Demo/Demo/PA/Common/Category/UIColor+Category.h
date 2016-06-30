//
//  UIColor+Category.h
//  haofang
//
//  Created by PengFeiMeng on 3/26/14.
//  Copyright (c) 2014 平安好房. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)

// 系统的Nav颜色
+ (UIColor *)systemNavigationColor;

// button默认颜色
+ (UIColor *)buttonDefaultColor;
// 按钮标题默认颜色
+ (UIColor *)buttonTitleDefaultColor;

// 默认文字颜色
+ (UIColor *)textDefaultColor;
// 默认加粗文字颜色
+ (UIColor *)boldTextDefaultColor;
// 默认文字颜色
+ (UIColor *)lightTextDefaultColor;

// 计算器饼图颜色
+ (UIColor *)PACalRedColor;
+ (UIColor *)PACalYellowColor;
+ (UIColor *)PACalGreenColor;

//根据颜色字符串获取Color
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;
+ (UIColor *)colorFromHex:(UInt32)color;

+ (UIColor*) colorRGBonvertToHSB:(UIColor*)color withBrighnessDelta:(CGFloat)delta;

@end
