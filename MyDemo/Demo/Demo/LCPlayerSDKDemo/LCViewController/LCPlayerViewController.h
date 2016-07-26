//
//  LCPlayerViewController.h
//  LCPlayerSDKConsumerDemo
//
//  Created by tingting on 16/3/31.
//  Copyright © 2016年 CC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCBaseViewController.h"

typedef NS_ENUM (NSInteger,LCPlayerType){
    LCVodViewType = 0,
    LCVodUIViewType = 1,
    LCLiveViewType = 2,
    LCLiveUIViewType = 3,
    LCActivityViewType = 4,
    LCActivityUIViewType = 5,
    LCUrlViewType = 6,
    LCOtherViewType
};


@interface LCPlayerViewController : LCBaseViewController

@property (nonatomic, assign) NSInteger playerType;
@property (nonatomic, strong) NSString *viewTitle;

@end
