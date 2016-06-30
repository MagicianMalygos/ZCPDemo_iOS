//
//  SinaShareDemoHomeController.m
//  SinaShareDemo
//
//  Created by apple on 16/2/29.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "SinaShareDemoHomeController.h"
#import "AppDelegate.h"

@interface SinaShareDemoHomeController () <WBHttpRequestDelegate>

@property (nonatomic, strong) UISwitch *textSwitch;     // 文字开关
@property (nonatomic, strong) UISwitch *imageSwitch;    // 图片开关
@property (nonatomic, strong) UISwitch *mediaSwitch;    // 多媒体开关（与图片互斥）
@property (nonatomic, strong) UIButton *shareButton;    // 分享按钮

@end

@implementation SinaShareDemoHomeController

#pragma mark - life cycles
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self SDKTest];
    
    // 提示label
    [self.view addSubview:[self createTitleLabelWithFrame:CGRectMake(15, 170, 290, 20) title:@"分享:" configBlock:^(UILabel *label) {
    }]];
    [self.view addSubview:[self createTitleLabelWithFrame:CGRectMake(10, 200, 80, 30) title:@"文字" configBlock:nil]];
    [self.view addSubview:[self createTitleLabelWithFrame:CGRectMake(10, 240, 80, 30) title:@"图片" configBlock:nil]];
    [self.view addSubview:[self createTitleLabelWithFrame:CGRectMake(10, 280, 80, 30) title:@"多媒体" configBlock:nil]];
    
    // Switch
    self.textSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(100, 200, 120, 30)];
    self.imageSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(100, 240, 120, 30)];
    self.mediaSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(100, 280, 120, 30)];[self.view addSubview:self.textSwitch];
    [self.view addSubview:self.imageSwitch];
    [self.view addSubview:self.mediaSwitch];
    
    // Button
    [self.view addSubview:self.shareButton];
}

#pragma mark - button click
- (void)shareButtonPressed {
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kRedirectURI;
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare] authInfo:authRequest access_token:@""];
    request.userInfo = @{@"ShareMessageFrom": @"ViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
        request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    [WeiboSDK sendRequest:request];
}



#pragma mark - getter / setter
- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _shareButton.frame = CGRectMake(210, 200, 90, 110);
        _shareButton.titleLabel.numberOfLines = 2;
        _shareButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_shareButton setTitle:NSLocalizedString(@"分享消息到微博", nil) forState:UIControlStateNormal];
        [_shareButton addTarget:self action:@selector(shareButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareButton;
}

#pragma mark - Private Method
- (UILabel *)createTitleLabelWithFrame:(CGRect)frame title:(NSString *)title configBlock:(void(^)(UILabel *label)) block {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = NSLocalizedString(title, nil);
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    if (block) {
        block(label);
    }
    return label;
}
- (void)SDKTest {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weiboSDKGetAidSucess) name:WeiboSDKGetAidSucessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weiboSDKGetAidFail) name:WeiboSDKGetAidFailNotification object:nil];
    
    NSLog(@"是否安装微博客户端：%d", [WeiboSDK isWeiboAppInstalled]);  // X
    NSLog(@"是否可以通过微博客户端进行分享：%d", [WeiboSDK isCanShareInWeiboAPP]);  // X
    NSLog(@"是否可以使用微博客户端进行SSO授权：%d", [WeiboSDK isCanSSOInWeiboApp]);  // X
    
//    NSLog(@"打开微博客户端程序：%d", [WeiboSDK openWeiboApp]); // V
    NSLog(@"微博客户端itunes安装地址：%@", [WeiboSDK getWeiboAppInstallUrl]);
    NSLog(@"当前微博客户端所支持的SDK最高版本：%@", [WeiboSDK getWeiboAppSupportMaxSDKVersion]);
    NSLog(@"获取当前微博SDK的aid：%@", [WeiboSDK getWeiboAid]);
    
    
}

- (WBMessageObject *)messageToShare {
    WBMessageObject *message = [WBMessageObject message];
    
    if (self.textSwitch.on) {
        message.text = NSLocalizedString(@"金领国际", nil);
    }
    
    if (self.imageSwitch.on) {
        WBImageObject *image = [WBImageObject object];
        image.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"png"]];
        message.imageObject = image;
    }
    
    if (self.mediaSwitch.on) {
        WBWebpageObject *webpage = [WBWebpageObject object];
        webpage.objectID = @"identifier1";
        webpage.title = NSLocalizedString(@"分享网页标题", nil);
        webpage.description = [NSString stringWithFormat:NSLocalizedString(@"分享网页内容简介-%.0f", nil), [[NSDate date] timeIntervalSince1970]];
        webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"png"]];
        webpage.webpageUrl = @"http://sina.cn?a=1";
        message.mediaObject = webpage;
    }
    
    return message;
}

#pragma mark - notification
- (void)weiboSDKGetAidSucess {
    NSLog(@"Success!!!");
}
- (void)weiboSDKGetAidFail {
    NSLog(@"Fail!!!");
}


@end
