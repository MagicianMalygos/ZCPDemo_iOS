//
//  LECPlayerControl.h
//  LECPlayerUIKit
//
//  Created by tingting on 16/5/6.
//  Copyright © 2016年 CC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LECPlayerUIProtocol.h"
#import "LECPlayerUIDefine.h"
#import "LECPlayerOption.h"

@interface LECPlayerControl : NSObject

@property (nonatomic,  weak) id<LECPlayerControlDelegate>delegate;
@property (nonatomic, assign) __block LECPlayerState playerState;// 播放状态
@property (nonatomic, assign) BOOL hiddenStatusBarWhenFullScreen;//Default is YES
@property (nonatomic, assign) BOOL isFullScreen;//是否全屏
@property (nonatomic, assign) BOOL hiddenBackButton;//隐藏返回按钮,Default is NO;
@property (nonatomic, assign) BOOL hiddenMediaTitle;//隐藏视频标题,Defaule is NO;
@property (nonatomic, assign) BOOL autoPlay;//Default is YES;
@property (nonatomic, assign) BOOL enableGravitySensor;//Default is NO;
@property (nonatomic, strong) UIImage * loadingLogoImage;//播放器加载时候的Logo
@property (nonatomic, assign) float playerVolume;//播放器音量,0.0-1.0,Default is 1.0;
@property (nonatomic, assign, readonly) BOOL autoRotation;//是否自动转屏,在ViewController的- (BOOL)shouldAutorotate方法中return该属性

//播放器视图初始化创建
- (UIView *)createPlayerWithOwner:(id)owner frame:(CGRect)frame;

- (void)destroyPlayer;
- (void)play;//播放
- (BOOL)pause;// 暂停
- (void)stop;// 停止
/*
 配合hiddenStatusBarWhenFullScreen使用在UIViewController的- (BOOL)prefersStatusBarHidden方法中return此方法;
 */
- (BOOL)statusBarHiddenState;

//转屏相关
- (CGRect)shouldRotateToOrientation:(UIDeviceOrientation)orientation;




@end
