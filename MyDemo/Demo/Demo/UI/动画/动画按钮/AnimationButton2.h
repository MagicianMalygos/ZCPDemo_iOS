//
//  AnimationButton2.h
//  Demo
//
//  Created by 朱超鹏 on 2018/7/6.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimationButtonDelegate.h"

/// 爱奇艺视频播放按钮
@interface AnimationButton2 : UIControl

/// 线的颜色
@property (nonatomic, strong) UIColor *lineColor;
/// 代理
@property (nonatomic, weak) id<AnimationButtonDelegate> delegate;
/// 播放状态
@property (nonatomic, assign, getter=isPlaying, readonly) BOOL playing;

@end
