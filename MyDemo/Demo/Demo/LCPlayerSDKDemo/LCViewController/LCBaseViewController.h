//
//  LCBaseViewController.h
//  LCPlayerSDKConsumerDemo
//
//  Created by CC on 15/12/15.
//  Copyright © 2015年 CC. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDuration  1.0f


typedef NS_ENUM(NSInteger, LCPlayType){
    LCPlayIdType = 0, // 通过uu,vu播放
    LCPlayUrlType = 1 // 通过url播放
};

typedef NS_ENUM(NSInteger, LCPlayerIdType){
    LCPlayLiveIdType,
    LCPlayStreamIdType,
    LCPlayUrlAddressType
};

/*
 点播测试UU和VU
 */
#define kVod_UU   @"40ff268ca7"
#define kVod_VU   @"6c658686bf"

/*
 直播测试ID
 */
#define kLive_ID  @"201601213001695"


/*
 活动测试ID
 */
#define kActivity_ID   @"A2016012101229"

#define ViewWidth 320
#define segmentY 70
#define segmentH [UIScreen mainScreen].bounds.size.height


/**
 *  @author CC
 *
 *  基类,提供公共基础方法
 */

@interface LCBaseViewController : UIViewController

@property (nonatomic, strong) NSString *uu;

@property (nonatomic, strong) NSString *vu;

@property (nonatomic, strong) NSString *url;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSString *activityId;

- (void)showTips:(NSString *)tips;

- (NSString *)timeFormate:(NSTimeInterval)time;


@end
