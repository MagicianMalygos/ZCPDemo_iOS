//
//  IOS12ICONAnimationButton2.h
//  Demo
//
//  Created by 朱超鹏 on 2018/7/20.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IOS12ICONAnimationButton2 : UIControl

/// 倒计时时间，单位秒
@property (nonatomic, assign) NSInteger time;

/// 开始动画
- (void)startAnimation;

/// 停止动画
- (void)stopAnimation;

@end
