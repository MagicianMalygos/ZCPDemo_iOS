//
//  AnimationButton1.h
//  Demo
//
//  Created by 朱超鹏 on 2018/7/3.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AnimationButton1Delegate;

/**
 汉堡包按钮
 */
@interface AnimationButton1 : UIControl

/// 线的颜色
@property (nonatomic, strong) UIColor *lineColor;
/// 代理
@property (nonatomic, weak) id<AnimationButton1Delegate> delegate;

@end

/**
 汉堡包按钮回调方法
 */
@protocol AnimationButton1Delegate <NSObject>

/**
 按钮被点击回调

 @param button 按钮
 */
- (void)animationButton1DidClick:(AnimationButton1 *)button;

/**
 按钮动画结束回调

 @param button 按钮
 @param flag 动画是否执行完成
 */
- (void)animationButtonDidStopAnimation:(AnimationButton1 *)button finished:(BOOL)flag;

@end
