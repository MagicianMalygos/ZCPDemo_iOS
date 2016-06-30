//
//  UIColor+Category.m
//  haofang
//
//  Created by PengFeiMeng on 3/26/14.
//  Copyright (c) 2014 平安好房. All rights reserved.
//

#import "UIColor+Category.h"

@implementation UIColor (Category)

/**
 *  系统的Nav颜色
 */
+ (UIColor *)systemNavigationColor {
    return [UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:1.0f];
}

/**
 *  button默认颜色
 */
+ (UIColor *)buttonDefaultColor {
    return [UIColor colorFromHexRGB:@"3a76cf"];
}
/**
 *  按钮标题默认颜色
 */
+ (UIColor *)buttonTitleDefaultColor {
    return [UIColor colorFromHexRGB:@"dbdbdb"];
}

// 默认文字颜色
+ (UIColor *)textDefaultColor {
    return [UIColor colorFromHexRGB:@"636363"];
}
// 默认加粗文字颜色
+ (UIColor *)boldTextDefaultColor {
    return [UIColor colorFromHexRGB:@"424c64"];
}
// 默认浅色文字颜色
+ (UIColor *)lightTextDefaultColor {
    return [UIColor colorFromHexRGB:@"a5a5a5"];
}


/*!
 * @method 通过16进制计算颜色
 * @abstract
 * @discussion
 * @param 16机制
 * @result 颜色对象
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString
{
    NSString *cString = [[inColorString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    
    if ([cString length] < 6)
        return [UIColor whiteColor];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (UIColor *)colorFromHex:(UInt32)color
{
    UIColor *result = nil;
    UInt8 alphaByte, redByte, greenByte, blueByte;
    
    alphaByte = ( color & 0xFF000000 ) >> 24;
    redByte = ( color & 0x00FF0000 ) >> 16;
    greenByte = ( color & 0x0000FF00 ) >> 8;
    blueByte = ( color & 0x000000FF );
    
    result = [UIColor colorWithRed:redByte/255.0 green:greenByte/255.0 blue:blueByte/255.0 alpha:alphaByte/255.0];
    return result;
}

+ (UIColor*) colorRGBonvertToHSB:(UIColor*)color withBrighnessDelta:(CGFloat)delta {
    CGFloat hue = 0.0f;
    CGFloat saturation = 0.0f;
    CGFloat brightness = 0.0f;
    CGFloat alpha = 0.0f;
    
    [color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    brightness += delta;
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}

+ (UIColor *)PACalRedColor
{
    return [UIColor colorWithRed:248.0f/255.0f green:80.0f/255.0f blue:32.0f/255.0f alpha:1.0f];
}

+ (UIColor *)PACalYellowColor
{
    return [UIColor colorWithRed:247.0f/255.0f green:192.0f/255.0f blue:1.0f/255.0f alpha:1.0f];
}

+ (UIColor *)PACalGreenColor
{
    return [UIColor colorWithRed:85.0f/255.0f green:177.0f/255.0f blue:53.0f/255.0f alpha:1.0f];
}

@end
