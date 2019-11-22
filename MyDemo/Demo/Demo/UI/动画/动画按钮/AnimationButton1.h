//
//  AnimationButton1.h
//  Demo
//
//  Created by 朱超鹏 on 2018/7/3.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimationButtonDelegate.h"

/// 汉堡包按钮
@interface AnimationButton1 : UIControl

/// 线的颜色
@property (nonatomic, strong) UIColor *lineColor;
/// 代理
@property (nonatomic, weak) id<AnimationButtonDelegate> delegate;
/// 打开状态
@property (nonatomic, assign, getter=isOpen, readonly) BOOL open;

@end
