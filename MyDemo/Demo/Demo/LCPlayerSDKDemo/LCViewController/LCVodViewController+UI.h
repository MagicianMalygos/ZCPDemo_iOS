//
//  LCVodViewController+UI.h
//  LCPlayerSDKConsumerDemo
//
//  Created by CC on 15/12/4.
//  Copyright © 2015年 CC. All rights reserved.
//

#import "LCBaseViewController.h"
#import "LECVodPlayerControl.h"

/**
 *  @author CC
 *
 *  皮肤点播播放器页面
 */
@interface LCVodViewController_UI : LCBaseViewController
@property (nonatomic, strong) LECVodPlayerControl * control;
@property (nonatomic, strong) UIView * lcPlayerView;
@end
