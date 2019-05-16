//
//  UIView+EasyFrame.h
//  ZCPKit
//
//  Created by zhuchaopeng on 16/9/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Background)

/**
 设置背景颜色

 @param color 背景颜色
 */
- (void)setCustomBackgroundColor:(UIColor *)color;

/**
 清除背景颜色
 */
- (void)clearBackgroundColor;



/**
 获取view所属viewController
 */
- (UIViewController*)viewController;

/**
 清除所有子视图
 */
- (void)removeAllSubviews;

/**
 根据view生成image
 */
- (UIImage *)imageFromView;

@end
