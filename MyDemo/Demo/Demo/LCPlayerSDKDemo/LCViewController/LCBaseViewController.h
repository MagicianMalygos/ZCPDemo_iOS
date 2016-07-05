//
//  LCBaseViewController.h
//  LCPlayerSDKConsumerDemo
//
//  Created by CC on 15/12/15.
//  Copyright © 2015年 CC. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDuration  2.0f

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
#define kActivity_ID   @"A2016032900000ai"



/**
 *  @author CC
 *
 *  基类,提供公共基础方法
 */

@interface LCBaseViewController : UIViewController


- (void)showTips:(NSString *)tips;

- (NSString *)timeFormate:(NSTimeInterval)time;


@end
