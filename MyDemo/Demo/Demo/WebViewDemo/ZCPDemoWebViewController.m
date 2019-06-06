//
//  ZCPDemoWebViewController.m
//  Demo
//
//  Created by zcp on 2019/6/4.
//  Copyright © 2019 zcp. All rights reserved.
//

#import "ZCPDemoWebViewController.h"

@interface ZCPDemoWebViewController () <WKNavigationDelegate>

@end

@implementation ZCPDemoWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [WKWebViewJavascriptBridge enableLogging];
    {
        UIButton *button = [UIButton new];
        button.backgroundColor = [UIColor redColor];
        button.frame = CGRectMake(0, 200, 200, 50);
        [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"获取H5用户输入信息" forState:UIControlStateNormal];
        [self.view addSubview:button];
    }
    
    {
        UIButton *button = [UIButton new];
        button.backgroundColor = [UIColor redColor];
        button.frame = CGRectMake(0, 260, 200, 50);
        [button addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"刷新" forState:UIControlStateNormal];
        [self.view addSubview:button];
    }
}

#pragma mark - event response

- (void)click {
    [self.jsBridge callHandler:@"getH5UserInput" data:@{@"secret": @"zcp123"} responseCallback:^(id responseData) {
        NSDictionary *dict = responseData;
        NSLog(@"Native收到回调：{phoneNumber: %@}", dict[@"phoneNumber"]);
    }];
}

- (void)click2 {
    [self loadURLString:@"https://mp.weixin.qq.com/s/rhYKLIbXOsUJC_n6dt9UfA"];
    
//    [self reload];
}

#pragma mark -

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
   
    [super webView:webView decidePolicyForNavigationAction:navigationAction decisionHandler:decisionHandler];
    

//    NSURL *URL = navigationAction.request.URL;
//
//    // 解析openWith参数，决定跳转方式
//    NSDictionary *queryDict = [URL.query getURLParams];
//    if (queryDict && [queryDict objectForKey:@"_openWith"]) {
//        NSString *openWith = [queryDict objectForKey:@"_openWith"];
//        // 如果开启新页面
//        if ([openWith isEqualToString:@"webView_Blank"]) {
////            [self openGeneralUrl:navigationAction.request.URL];
//            decisionHandler(WKNavigationActionPolicyCancel);
//            return;
//        }
//
//        // 如果在当前页面加载
//        if ([openWith isEqualToString:@"webView_Keep"]) {
//        }
//
//        // 如果在手机浏览器加载
//        if ([openWith isEqualToString:@"browser"]) {
//            [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
//            decisionHandler(WKNavigationActionPolicyCancel);
//            return;
//        }
//    }
}

@end
