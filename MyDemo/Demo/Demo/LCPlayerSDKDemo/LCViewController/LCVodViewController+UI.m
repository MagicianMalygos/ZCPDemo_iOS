//
//  LCVodViewController+UI.m
//  LCPlayerSDKConsumerDemo
//
//  Created by CC on 15/12/4.
//  Copyright © 2015年 CC. All rights reserved.
//

#import "LCVodViewController+UI.h"
#import "LCPlayerViewControl.h"


@interface LCVodViewController_UI ()<LCPlayerControlDelegate>

@property (nonatomic, strong) LCPlayerViewControl * control;
@property (nonatomic, strong) UIView * lcPlayerView;

@end

@implementation LCVodViewController_UI

- (void)viewDidLoad {
    [super viewDidLoad];
    _control = [[LCPlayerViewControl alloc] init];
    _control.hiddenStatusBarWhenFullScreen = YES;
    _control.hiddenBackButton = NO;
    _control.enableDownload = NO;
    _control.delegate = self;
    _lcPlayerView = [_control createPlayerWithOwner:self frame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [_control registerVodPlayerWithUU:@"hqilswlgvx" vu:@"b12ff1eef5"];
    NSLog(@"%d", _control.isFullScreen);
    [self.view addSubview:_lcPlayerView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (BOOL)prefersStatusBarHidden
{
    return [_control statusBarHiddenState];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

#pragma mark - LCPlayerControlDelegate
- (void)lcPlayerControlDidClickBackBtn:(LCPlayerControl *)playerControl{
    //销毁播放器
    [_control destroyPlayer];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 按钮事件
- (IBAction)clickToBack:(id)sender
{
    //销毁播放器
    [_control destroyPlayer];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
