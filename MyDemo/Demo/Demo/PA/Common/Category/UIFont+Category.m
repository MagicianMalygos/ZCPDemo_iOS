//
//  UIFont+Category.m
//  haofang
//
//  Created by Aim on 14-4-2.
//  Copyright (c) 2014年 平安好房. All rights reserved.
//

#import "UIFont+Category.h"

@implementation UIFont (Category)

// 默认字体
+ (UIFont *)defaultFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"Helvetica" size:size];
}
+ (UIFont *)defaultBoldFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"Helvetica-Bold" size:size];
}

@end
