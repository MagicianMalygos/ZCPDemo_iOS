//
//  ZCPDemoWebViewController.m
//  Demo
//
//  Created by zcp on 2019/6/4.
//  Copyright © 2019 zcp. All rights reserved.
//

#import "ZCPDemoWebViewController.h"

@interface ZCPDemoWebViewController () <ZCPBaseWebViewControllerDelegate>

@end

@implementation ZCPDemoWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [WKWebViewJavascriptBridge enableLogging];
    [self testLoad];
}

#pragma mark - test

- (void)testJSAPI {
    [self.jsBridge callHandler:@"getH5UserInput" data:@{@"secret": @"zcp123"} responseCallback:^(id responseData) {
        NSDictionary *dict = responseData;
        NSLog(@"Native收到回调：{phoneNumber: %@}", dict[@"phoneNumber"]);
    }];
}

- (void)testReload {
    [self reload];
}

- (void)testLoad {
    NSString *url = @"";
    url = [[NSBundle mainBundle] URLForResource:@"network_unavailable_cn.html" withExtension:nil].absoluteString;
//    url = @"https://www.baidu.com";
//    url = @"https://mp.weixin.qq.com/s/rhYKLIbXOsUJC_n6dt9UfA";
    [self loadURLString:url];
}

#pragma mark - ZCPBaseWebViewControllerDelegate

- (void)openUnconventionalURL:(NSURL *)URL {
    // 可以在此处判断scheme
    openURL(URL.absoluteString);
}

@end
