//
//  UIImage+Category.m
//  ZCPCategory
//
//  Created by zcp on 2019/5/16.
//  Copyright © 2019 zcp. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = [UIGraphicsGetImageFromCurrentImageContext() stretchableImageByCenter];
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color radiu:(CGFloat)radiu {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f + radiu*2, 1.0f + radiu*2);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radiu].CGPath);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextDrawPath(context, kCGPathFill);
    
    UIImage *theImage = [UIGraphicsGetImageFromCurrentImageContext() stretchableImageByCenter];
    UIGraphicsEndImageContext();
    return theImage;
}

- (UIImage *)stretchableImageByCenter {
    CGFloat leftCapWidth = floorf(self.size.width / 2);
    if (leftCapWidth == self.size.width / 2) {
        leftCapWidth--;
    }
    
    CGFloat topCapHeight = floorf(self.size.height / 2);
    if (topCapHeight == self.size.height / 2) {
        topCapHeight--;
    }
    
    return [self stretchableImageWithLeftCapWidth:leftCapWidth
                                     topCapHeight:topCapHeight];
}

@end
