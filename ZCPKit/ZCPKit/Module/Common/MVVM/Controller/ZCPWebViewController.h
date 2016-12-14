//
//  ZCPWebViewController.h
//  ZCPKit
//
//  Created by zhuchaopeng on 16/9/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

// ----------------------------------------------------------------------
#pragma mark - webview返回事件代理
// ----------------------------------------------------------------------
@protocol PAWebViewControllerBackDelegate <NSObject>

// webview返回按钮响应事件
- (void)webViewDidClickBackBarButton;

@end

// ----------------------------------------------------------------------
#pragma mark - WebViewController 用来装载网页，并做响应处理
// ----------------------------------------------------------------------
@interface ZCPWebViewController : ZCPViewController <UIWebViewDelegate>

// url
@property (nonatomic, copy) NSString * urlString;
// webview
@property (nonatomic, strong) UIWebView * webView;
// params
@property (nonatomic, strong) NSDictionary *postParams;

// 根据传入的url地址初始化
- (instancetype)initWithURL:(NSString *)url;

// 重新加载url
- (void)reload;

// 获得字典中的某个参数
- (id)paramForKey:(NSString *)key;

@end
