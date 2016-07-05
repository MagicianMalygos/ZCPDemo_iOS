//
//  LCPlayerControl.h
//  LECPlayerSDK
//
//  Created by CC on 15/12/8.
//  Copyright © 2015年 letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LCPlayerViewGlobalDefine.h"
#import "LCPlayerOption.h"



@class LCPlayerControl;
@protocol LCPlayerControlDelegate <NSObject>

- (void)lcPlayerControl:(LCPlayerControl *)playerControl didChangePlayerFullScreenState:(BOOL)fullScreen;

- (void)lcPlayerControlDidClickBackBtn:(LCPlayerControl *)playerControl;

- (void)lcPlayerControl:(LCPlayerControl *)playerControl
             mediaTitle:(NSString *)mediaTitle
        currentPlayTime:(NSTimeInterval)currentPlayTimestamp
              totalTime:(NSTimeInterval)totalTime;

- (void)lcPlayerControl:(LCPlayerControl *)playerControl
            playerEvent:(LCPlayerControlEvent)event
                  error:(NSError *)error;

@optional
- (BOOL)lcPlayerControl:(LCPlayerControl *)playerControl
   showCommonHUDMessage:(NSString *) message;
//如果不实现该方法，或返回YES，则调用SDK内部方法展示提示；否则需开发者在该方法的实现中自行展示HUD


@end


@interface LCPlayerControl : NSObject


@property (nonatomic,  weak) id<LCPlayerControlDelegate> delegate;
@property (nonatomic, assign, readonly) __block LCPlayerState playerState;// 错误页面类型
@property (nonatomic, assign, readonly) BOOL isFullScreen;//是否全屏
@property (nonatomic, assign) BOOL hiddenBackButton;//隐藏返回按钮,Default is NO;
@property (nonatomic, assign) BOOL hiddenMediaTitle;//隐藏视频标题,Defaule is NO;
@property (nonatomic, assign) BOOL hiddenStatusBarWhenFullScreen;//Default is YES
@property (nonatomic, assign) BOOL autoPlay;//Default is YES;
@property (nonatomic, assign) BOOL enableGravitySensor;//Default is NO;
@property (nonatomic, assign) BOOL enableNetworkStatusNotify;//开启网络状态提醒；Default is YES;
@property (nonatomic, strong) UIImage * loadingLogoImage;//播放器加载时候的Logo
@property (nonatomic, assign) float playerVolume;//播放器音量,0.0-1.0,Default is 1.0;


//播放器控制相关
- (void)play;//播放
- (BOOL)pause;// 暂停
- (void)stop;// 停止
- (void)destroyPlayer;//销毁播放器
/*
 配合hiddenStatusBarWhenFullScreen使用在UIViewController的- (BOOL)prefersStatusBarHidden方法中return此方法;
 */
- (BOOL)statusBarHiddenState;//获取状态栏状态


@end
