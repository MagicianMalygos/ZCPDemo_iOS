//
//  AnimationButtonDelegate.h
//  Demo
//
//  Created by 朱超鹏 on 2018/7/16.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 按钮回调协议
 */
@protocol AnimationButtonDelegate <NSObject>

/**
 按钮被点击回调
 
 @param button 按钮
 */
- (void)animationButtonDidClick:(UIView *)button;

/**
 按钮动画结束回调
 
 @param button 按钮
 @param flag 动画是否执行完成
 */
- (void)animationButtonDidStopAnimation:(UIView *)button state:(BOOL)state;

@end
