//
//  UIImage+ExplodeHelpMethod.h
//  Demo
//
//  Created by 朱超鹏 on 2018/6/25.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ExplodeHelpMethod)

/**
 获取指定位置的像素点颜色
 
 @param point 位置
 @return 该位置上的像素点颜色
 */
- (UIColor *)getPixelColorWithLocation:(CGPoint)point;

@end
