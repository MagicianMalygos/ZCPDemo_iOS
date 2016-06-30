//
//  UIViewController+Category.h
//  Apartment
//
//  Created by apple on 15/12/31.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Category)

// 返回上一级视图
- (void)backTo;

// 清除navbar
- (void) clearNavigationBar;

// 设置nav背景颜色
- (void)setNavigationColor:(UIColor *)color;
// 设置tabbar背景颜色
- (void)setTabBarColor:(UIColor *)color;

@end
