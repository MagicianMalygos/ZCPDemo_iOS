//
//  LCActivityInfoManager.h
//  LECPlayerSDK
//
//  Created by 侯迪 on 10/11/15.
//  Copyright (c) 2015 letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCActivityItem.h"
#import "LCActivityConfigItem.h"
#import "LECPlayer.h"
#import "LECActivityPlayer.h"
#import "LECLivingPlayer.h"
#import "LCActivityItem.h"

typedef NS_ENUM(NSInteger, LCActivityEvent) {
    LCActivityEventActivityConfigUpdate = 0,
    LCActivityEventOnlineAudiencesNumberUpdate = 1,
};

typedef NS_ENUM(NSInteger, LCActivityRegisterStatus) {
    LCActivityRegisterStatusNone = 0,           //未初始化
    LCActivityRegisterStatusRegistering = 1,    //初始化中
    LCActivityRegisterStatusReady = 2           //注册完成
};

typedef void (^ActivityInfoRequestCompletionBlock)(BOOL success);

@class LCActivityInfoManager;

@protocol LCActivityManagerDelegate <NSObject>

@optional
- (void) activityManager:(LCActivityInfoManager *) manager event:(LCActivityEvent) event;

@end

@interface LCActivityInfoManager : NSObject

@property (nonatomic, readonly) NSString *activityId;//活动ID
@property (nonatomic, readonly) LCActivityItem *activityItem;//活动对象
@property (nonatomic, readonly) LCActivityConfigItem *activityConfigItem;//活动配置对象
@property (nonatomic, readonly) NSInteger onlineAudiencesNumber;//在线观看人数
@property (nonatomic, readonly) LCActivityRegisterStatus activityRegisterStatus;//注册状态
@property (nonatomic, weak) id<LCActivityManagerDelegate> delegate;//活动代理


+ (id) sharedManager;
- (BOOL)registerActivityWithActivityId:(NSString *) activityId completion:(ActivityInfoRequestCompletionBlock)completion;
- (BOOL)registerActivityWithActivityId:(NSString *) activityId
                                option:(LCPlayerOption *)option
                            completion:(ActivityInfoRequestCompletionBlock)completion;
//结束活动
- (void)releaseActivity;
//检测活动状态
- (BOOL)requestActivityStatus:(void (^)(BOOL requestSuccess, LCActivityStatus activityStatus))completion;
- (BOOL)reportActivityWithActivityId:(NSString *) activityId completion:(ActivityInfoRequestCompletionBlock)completion;

@end
