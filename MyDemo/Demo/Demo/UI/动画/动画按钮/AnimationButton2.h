//
//  AnimationButton2.h
//  Demo
//
//  Created by 朱超鹏 on 2018/7/6.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AnimationButton2Delegate;

/**
 爱奇艺按钮
 */
@interface AnimationButton2 : UIControl

/// 线的颜色
@property (nonatomic, strong) UIColor *lineColor;
/// 代理
@property (nonatomic, weak) id<AnimationButton2Delegate> delegate;

@end

/**
 爱奇艺按钮回调方法
 */
@protocol AnimationButton2Delegate <NSObject>

/**
 按钮被点击回调
 
 @param button 按钮
 */
- (void)animationButton2DidClick:(AnimationButton2 *)button;

/**
 按钮动画结束回调

 @param button 按钮
 @param isPlaying 播放状态
 */
- (void)animationButtonDidStopAnimation:(AnimationButton2 *)button playing:(BOOL)isPlaying;

@end
