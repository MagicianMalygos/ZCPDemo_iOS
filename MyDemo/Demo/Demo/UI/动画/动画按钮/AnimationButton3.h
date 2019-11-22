//
//  AnimationButton3.h
//  Demo
//
//  Created by 朱超鹏 on 2018/7/10.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimationButtonDelegate.h"

/// 优酷视频播放按钮
@interface AnimationButton3 : UIControl

/// 代理
@property (nonatomic, weak) id<AnimationButtonDelegate> delegate;
/// 播放状态
@property (nonatomic, assign, getter=isPlaying, readonly) BOOL playing;

@end
