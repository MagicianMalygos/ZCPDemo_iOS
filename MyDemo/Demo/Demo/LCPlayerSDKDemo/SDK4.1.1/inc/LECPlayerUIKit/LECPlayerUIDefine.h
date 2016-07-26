//
//  LECPlayerUIDefine.h
//  LECPlayerUIKit
//
//  Created by CC on 16/4/27.
//  Copyright © 2016年 CC. All rights reserved.
//

#ifndef LECPlayerUIDefine_h
#define LECPlayerUIDefine_h

const static NSString *kDownloadExistAlert = @"该视频已经下载完成";
const static NSString *kStartNewDownloadExistAlert = @"已加入离线下载列表";
const static NSString *kDownloadFailedAlert = @"下载失败";


#define kBaseGestureSensitivity   0.000025
#define kBaseSysGestureSensitivity   0.00025

/*
 皮肤层按钮事件类型
 */
typedef NS_ENUM(NSInteger, LECPlayerUIActionEvent) {
    LECPlayerUIActionEventBack = 100,//返回事件
    LECPlayerUIActionEventRate = 101,//查看码率
    LECPlayerUIActionEventChangeScreen = 102,//全屏半屏
    LECPlayerUIActionEventPlayStop = 103, //播放、暂停、停止
    LECPlayerUIActionEventLockRotation = 104, //锁定屏幕旋转
    LECPlayerUIActionEventDownload = 105, //下载
    LECPlayerUIActionEventBackToLiveTime = 106, //返回当前直播最新时间
    LECPlayerUIActionEventPlay = 107,// 播放
    LECPlayerUIActionEventPause = 108,// 暂停
    LECPlayerUIActionEventGyroscope = 109 //设置全景陀螺仪开关
};


/*
 播放手势事件
 */
typedef NS_ENUM(NSInteger, LECPlayerGestureEvent) {
    LECPlayerGestureEventNone = 0,
    LECPlayerGestureEventSeek = 1,
    LECPlayerGestureEventBrightness = 2,
    LECPlayerGestureEventVolume = 3
};

/*
 皮肤层按钮设置,控制按钮展示设置
 */
typedef NS_OPTIONS(NSUInteger, LECPlayerUIButton) {
    LECPlayerUIButtonNone                = 0,//无
    LECPlayerUIButtonOnlineNum           = 1 << 0,//在线人数
    LECPlayerUIButtonLockRotation        = 1 << 1,//锁屏
    LECPlayerUIButtonDownload            = 1 << 2,//下载
    LECPlayerUIButtonRateSwitch          = 1 << 3,//切换码率
    LECPlayerUIButtonBack                = 1 << 4//返回
};

/*
 播放屏幕状态
 */
typedef NS_ENUM(NSInteger, LECPlayerScreenState) {
    LECPlayerScreenStateHalfScreen = 0,
    LECPlayerScreenStateFullScreen = 1
};

/*
 播放Control事件状态
 */
typedef NS_ENUM(NSInteger, LECPlayerControlEvent) {
    LECPlayerControlEventNone = 0,  //无状态
    LECPlayerControlEventStart = 1,//开始加载Control
    LECPlayerControlEventRegisterFinish,//注册完成
    LECPlayerControlEventPrepareDone,//Player准备完成可以开播
    LECPlayerControlEventBufferStart,//开始缓冲
    LECPlayerControlEventBufferEnd,//结束缓冲
    LECPlayerControlEventEOF,//播放结束
    LECPlayerControlEventFail//统一失败处理
};

/*
 播放器类型
 */
typedef NS_OPTIONS(NSInteger, LECPlayerStytle){
    LECPlayerStytleVod = 0,
    LECPlayerStytleLive = 1,
    LECPlayerStytleActivity = 2
};

/*
 Pan手势事件方向
 */
typedef NS_ENUM(NSInteger, LECPanGestureDirection) {
    LECPanGestureDirectionNone = 0,
    LECPanGestureDirectionUp = 1,
    LECPanGestureDirectionLeft = 2,
    LECPanGestureDirectionDown = 3,
    LECPanGestureDirectionRight = 4
};

/*
 错误页面类型
 */
typedef NS_ENUM(NSInteger, LECPlayerState) {
    LECPlayerStateUnregister = 0,  //未注册
    LECPlayerStatePrepareToPlay = 1,
    LECPlayerStateStop = 2,
    LECPlayerStatePlay = 3,
    LECPlayerStatePause = 4
};

/*
 错误页面类型
 */
typedef NS_ENUM(NSInteger, LCErrorViewEvent) {
    LECErrorViewEventNone = 0,  //无错误
    LECErrorViewEventLaunching = 1,//启动加载
    LECErrorViewEventNoMedia = 2,//无媒体资源状态
    LECErrorViewEventFail = 3,//统一失败页面
    LECErrorViewEventLoading = 4,//缓冲卡顿等加载事件
    LECErrorViewEventEOF = 5//结束
};

/*
 下载按钮状态
 */
typedef NS_ENUM(NSInteger, LECDownloadButtonState) {
    LECDownloadButtonStateNormal = 0,//普通状态
    LECDownloadButtonStateNone = 1,  //无下载按钮
    LECDownloadButtonStateDownloading = 2,//下载中
    LECDownloadButtonStateDownload = 3,//已经下载
    LECDownloadButtonStateDisable = 4,//下载不可用
};

typedef NS_ENUM(NSInteger, LECDeviceOrientationState) {
    LECDeviceOrientationStateUnKnown = 0,
    LECDeviceOrientationPortrait = 1,
    LECDeviceOrientationStateUpsideDown = 2,
    LECDeviceOrientationLandscapeLeft = 3,
    LECDeviceOrientationLandscapeRight = 4,

};

#endif /* LECPlayerUIDefine_h */
