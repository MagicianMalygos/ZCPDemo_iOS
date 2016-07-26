//
//  LCVodViewController+UI.m
//  LCPlayerSDKConsumerDemo
//
//  Created by CC on 15/12/4.
//  Copyright © 2015年 CC. All rights reserved.
//

#import "LCVodViewController+UI.h"


@interface LCVodViewController_UI ()<LECPlayerControlDelegate>

@end

@implementation LCVodViewController_UI

- (void)viewDidLoad {
    [super viewDidLoad];
    _control = [[LECVodPlayerControl alloc] init];
    // 在开启设备陀螺仪状态下是否允许自动转屏
    _control.enableGravitySensor = YES;
     // 设置在全屏状态下是否隐藏状态栏
    _control.hiddenStatusBarWhenFullScreen = YES;
    _control.delegate = self;
    _control.enableDownload = YES;
    
    _lcPlayerView = [_control createPlayerWithOwner:self frame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20)];
    _lcPlayerView.autoresizingMask =
    UIViewAutoresizingFlexibleWidth;
    [_control registerVodPlayerWithUU:self.uu vu:self.vu];
    
    [self.view addSubview:_lcPlayerView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

//废弃播放器
- (void)dealloc{
    if (_control) {
        [_control destroyPlayer];
    }
}

#pragma mark - 转屏处理逻辑
- (void)viewWillLayoutSubviews
{
    CGRect frame = [_control shouldRotateToOrientation:(UIDeviceOrientation)[UIApplication sharedApplication].statusBarOrientation];
    if (!CGRectIsEmpty(frame))
    {
        _lcPlayerView.frame = frame;
    }
}
#pragma mark - 设置是否自动转屏
- (BOOL)shouldAutorotate
{
    return  _control.autoRotation;
}

#pragma mark - LECPlayerControlDelegate
- (void)lecPlayerControlDidClickBackBtn:(NSObject *)playerControl{
    if (_control) {
        //销毁播放器
        [_control destroyPlayer];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
// 获取状态栏状态
- (BOOL)prefersStatusBarHidden
{
    return _control.statusBarHiddenState;
}

#pragma mark - 按钮事件
- (IBAction)clickToBack:(id)sender
{
    //销毁播放器
    [_control destroyPlayer];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
