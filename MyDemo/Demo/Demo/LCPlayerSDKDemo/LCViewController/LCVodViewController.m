//
//  LCVodViewController.m
//  LCPlayerSDKConsumerDemo
//
//  Created by CC on 15/12/2.
//  Copyright © 2015年 CC. All rights reserved.
//

#import "LCVodViewController.h"
#import "LCVodDownloadViewController.h"
#import "LECVODPlayer.h"

#define LCRect_PlayerHalfFrame    CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 250);

@interface LCVodViewController ()<LECPlayerDelegate>
{
    __block BOOL _isPlay;
    __block BOOL _isSeeking;
    BOOL _isFullScreen;
}
@property (nonatomic, strong) LECVODPlayer *vodPlayer;
@property (nonatomic,   weak) IBOutlet UILabel * titleLabel;
@property (nonatomic,   weak) IBOutlet UIView * playerView;
@property (nonatomic,   weak) IBOutlet UIButton * playStateBtn;
@property (nonatomic,   weak) IBOutlet UISlider * playSlider;
@property (nonatomic,   weak) IBOutlet UIButton * playerRateBtn;
@property (nonatomic,   weak) IBOutlet UIButton * downloadBtn;
@property (nonatomic,   weak) IBOutlet UILabel * timeInfoLabel;
@property (nonatomic,   weak) IBOutlet UIActivityIndicatorView * loadIndicatorView;

@end

@implementation LCVodViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        _isFullScreen = NO;
        _isPlay = NO;
        _isSeeking = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initVodPlayerView];
}

- (void)initVodPlayerView
{
    if (!_vodPlayer) {
        _vodPlayer = [[LECVODPlayer alloc] init];
        _vodPlayer.delegate = self;
    }
    _playerView.frame = LCRect_PlayerHalfFrame;
    _vodPlayer.videoView.frame = _playerView.bounds;
    _vodPlayer.videoView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|
    UIViewAutoresizingFlexibleWidth|
    UIViewAutoresizingFlexibleHeight;
    _vodPlayer.videoView.contentMode = UIViewContentModeScaleAspectFit;
    [_playerView addSubview:_vodPlayer.videoView];
    [_playerView sendSubviewToBack:_vodPlayer.videoView];

    __weak typeof(self) wSelf = self;
    [_vodPlayer registerWithUu:kVod_UU
                            vu:kVod_VU
                    completion:^(BOOL result) {
                        if (result)
                        {
                            NSLog(@"播放器注册成功");
                            [wSelf play];//注册完成后自动播放
                            wSelf.titleLabel.text = wSelf.vodPlayer.videoTitle;
                            LCStreamRateItem * lItem = wSelf.vodPlayer.selectedStreamRateItem;
                            wSelf.downloadBtn.enabled = _vodPlayer.allowDownload;
                            [wSelf.playerRateBtn setTitle:lItem.name
                                                 forState:(UIControlStateNormal)];
                        }
                        else
                        {
                            [self showTips:@"播放器注册失败,请检查UU和VU"];
                            [_loadIndicatorView stopAnimating];
                        }
                    }];
}

#pragma mark - 播放控制
- (void)play
{
    if (_isPlay)
    {
        return;
    }
    __weak typeof(self) wSelf = self;
    [_vodPlayer playWithCompletion:^{
        [wSelf.playStateBtn setTitle:@"暂停" forState:(UIControlStateNormal)];
        _isPlay = YES;
    }];
}

- (void)stop
{
    if (!_isPlay)
    {
        return;
    }
    __weak typeof(self) wSelf = self;
    [_vodPlayer stopWithCompletion:^{
        wSelf.playSlider.value = 0.0;
        [wSelf.playStateBtn setTitle:@"播放" forState:(UIControlStateNormal)];
        _isPlay = NO;
    }];
}

- (void)pause
{
    if (!_isPlay)
    {
        return;
    }
    [_vodPlayer pause];
    [self.playStateBtn setTitle:@"播放" forState:(UIControlStateNormal)];
    _isPlay = NO;
}

#pragma mark - LECPlayerDelegate
/*播放器播放状态*/
- (void) lecPlayer:(LECPlayer *) player
       playerEvent:(LECPlayerPlayEvent) playerEvent
{
    switch (playerEvent)
    {
        case LECPlayerPlayEventPrepareDone:
            [_loadIndicatorView stopAnimating];
            _titleLabel.text = _vodPlayer.videoTitle;
            break;
        case LECPlayerPlayEventEOS:
            [self showTips:@"播放结束"];
            self.playSlider.value = 0.0;
            _timeInfoLabel.text = @"00:00:00/00:00:00";
            [self.playStateBtn setTitle:@"播放" forState:(UIControlStateNormal)];
            _isPlay = NO;
            break;
        case LECPlayerPlayEventGetVideoSize:
            
            break;
        case LECPlayerPlayEventRenderFirstPic:
            [_loadIndicatorView stopAnimating];
            break;
        case LECPlayerPlayEventBufferStart:
            _loadIndicatorView.hidden = NO;
            [_loadIndicatorView startAnimating];
            NSLog(@"开始缓冲");
            break;
        case LECPlayerPlayEventBufferEnd:
            [_loadIndicatorView stopAnimating];
            NSLog(@"缓冲结束");
            break;
            
        case LECPlayerPlayEventSeekComplete:
            NSLog(@"完成Seek操作");
            _isSeeking = NO;
            [_loadIndicatorView stopAnimating];
            break;
            
        case LECPlayerPlayEventNoStream:
        {
            NSString * error = [NSString stringWithFormat:@"%@:%@",player.errorCode,player.errorDescription];
            NSLog(@"无媒体信息:%@",error);
            [_loadIndicatorView stopAnimating];
            [self showTips:error];
        }
            break;
        case LECPlayerPlayEventPlayError:
        {
            NSString * error = [NSString stringWithFormat:@"%@:%@",player.errorCode,player.errorDescription];
            NSLog(@"播放器错误:%@",error);
            [_loadIndicatorView stopAnimating];
            [self showTips:error];
        }
            break;
            
        default:
            break;
    }
}

/*播放器播放时间回调*/
- (void) lecPlayer:(LECPlayer *) player
          position:(int64_t) position
     cacheDuration:(int64_t) cacheDuration
          duration:(int64_t) duration
{
    if (!_isSeeking)
    {
        float value = (float)position/(float)duration;
        [_playSlider setValue:value];
    }
    NSString * playTimeStr = [self timeFormate:position];
    NSString * totalTimeStr = [self timeFormate:duration];
    _timeInfoLabel.text = [NSString stringWithFormat:@"%@/%@",playTimeStr,totalTimeStr];
    NSLog(@"播放位置:%lld,缓冲位置:%lld,总时长:%lld",position,cacheDuration,duration);
}

- (void) lecPlayer:(LECPlayer *) player contentTypeChanged:(LECPlayerContentType) contentType
{
    switch (contentType)
    {
        case LECPlayerContentTypeFeature:
            NSLog(@"正在播放正片");
            break;
        case LECPlayerContentTypeAdv:
            NSLog(@"正在播放广告");
            [_loadIndicatorView stopAnimating];
            break;
            
        default:
            break;
    }
}

#pragma mark - 按钮事件
- (IBAction)clickToBack:(id)sender
{
    //销毁播放器
    [self stop];
    [_vodPlayer unregister];
    _vodPlayer = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickToChangePlayState:(id)sender
{
    if (_isPlay)
    {
        [self pause];
        return;
    }
    [self play];
}

- (IBAction)slideToChangePlayProgress:(id)sender
{
    float value = _playSlider.value;
    [_vodPlayer seekToPosition:_vodPlayer.duration*value completion:^{
        _isSeeking = NO;
    }];
}

- (IBAction)slideToChangeValue:(id)sender
{
    _isSeeking = YES;
}

- (IBAction)clickToChangePlayerRate:(id)sender
{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"码率"
                                                                              message:@"请选择您要切换的清晰度"
                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * cancelAction =[UIAlertAction actionWithTitle:@"取消"
                                                           style:(UIAlertActionStyleCancel)
                                                         handler:NULL];
    [alertController addAction:cancelAction];
    
    
    NSArray * list = self.vodPlayer.streamRatesList;
    
    for (LCStreamRateItem * lItem in list)
    {
        if (lItem.isEnabled)
        {
            __weak typeof(self) wSelf = self;
            UIAlertAction * action =[UIAlertAction actionWithTitle:lItem.name
                                                                   style:(UIAlertActionStyleDefault)
                                                                 handler:^(UIAlertAction * _Nonnull action) {
                                                                     [wSelf.vodPlayer switchSelectStreamRateItem:lItem
                                                                                                completion:^{
                                                                                                    [wSelf.playerRateBtn setTitle:lItem.name forState:(UIControlStateNormal)];
                                                                                                }];
                                                                 }];
            [alertController addAction:action];
        }
    }
    
    [self presentViewController:alertController animated:YES completion:NULL];
}

- (IBAction)clickToShowDownloadPage:(id)sender
{
    [self pause];
    LCVodDownloadViewController * viewController = [[LCVodDownloadViewController alloc] initWithNibName:@"LCVodDownloadViewController" bundle:nil uu:kVod_UU vu:kVod_VU rate:self.vodPlayer.selectedStreamRateItem];
    [self.navigationController pushViewController:viewController
                                         animated:YES];
}

- (IBAction)clickToChangePlayerScreen:(id)sender
{
    _isFullScreen = !_isFullScreen;
    [self changeScreenAction];
}

#pragma mark - 转屏处理逻辑
- (void)viewWillLayoutSubviews
{
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        if (width < height)
        {
            CGFloat tmp = width;
            width = height;
            height = tmp;
        }
        _isFullScreen = YES;
        _playerView.frame = CGRectMake(0, 0, width, height);
    }
    else
    {
        _isFullScreen = NO;
        _playerView.frame = LCRect_PlayerHalfFrame;
    }
}

- (void)changeScreenAction
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)])
    {
        NSNumber *num = [[NSNumber alloc] initWithInt:(_isFullScreen?UIInterfaceOrientationLandscapeRight:UIInterfaceOrientationPortrait)];
        [[UIDevice currentDevice] performSelector:@selector(setOrientation:) withObject:(id)num];
        [UIViewController attemptRotationToDeviceOrientation];
    }
    SEL selector=NSSelectorFromString(@"setOrientation:");
    NSInvocation *invocation =[NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
    [invocation setSelector:selector];
    [invocation setTarget:[UIDevice currentDevice]];
    int val = _isFullScreen?UIInterfaceOrientationLandscapeRight:UIInterfaceOrientationPortrait;
    [invocation setArgument:&val atIndex:2];
    [invocation invoke];
}

#pragma mark - 转屏设置相关
- (BOOL)shouldAutorotate
{
    return YES;
}


@end
