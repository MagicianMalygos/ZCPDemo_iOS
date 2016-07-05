//
//  LECActivityPlayer.h
//  LECPlayerSDK
//
//  Created by 侯迪 on 10/12/15.
//  Copyright (c) 2015 letv. All rights reserved.
//

#import "LECPlayer.h"
#import "LECGlobalDefine.h"

@interface LECActivityPlayer : LECPlayer

- (id) initWithUsingVODMode:(BOOL) usingVodMode;

- (BOOL) registerWithLiveId:(NSString *) liveId
                 completion:(void (^)(BOOL result))completion;

- (BOOL) registerWithStreamId:(NSString *) streamId
                   completion:(void (^)(BOOL result))completion;

- (BOOL) registerWithLiveId:(NSString *) liveId
                isLetvMedia:(BOOL) isLetvMedia
                 options:(LCPlayerOption *)options//设置业务相关参数以及用户ID等,没有可以为nil
                 completion:(void (^)(BOOL result))completion;

- (BOOL) registerWithStreamId:(NSString *) streamId
                  isLetvMedia:(BOOL) isLetvMedia
                   options:(LCPlayerOption *)options//设置业务相关参数以及用户ID等,没有可以为nil
                   completion:(void (^)(BOOL result))completion;

- (BOOL) backToLiveWithCompletion:(void (^)())completion;//回到当前时间的直播会调用该block

@property (nonatomic, readonly) NSInteger currentPlayTimestamp;//    当前播放的时间
@property (nonatomic, readonly) NSInteger serverRealTimestamp;//    服务器真实时间
@property (nonatomic, readonly) NSInteger streamStartTimestamp;//直播流开始的时间
@property (nonatomic, readonly) NSInteger streamEndTimestamp;//直播流结束的时间
@property (nonatomic, readonly) BOOL supportSeekOperation;//是否支持时移操作
@property (nonatomic, readonly,strong) NSString * loadingIconUrl;//启动加载的图标url

@end
