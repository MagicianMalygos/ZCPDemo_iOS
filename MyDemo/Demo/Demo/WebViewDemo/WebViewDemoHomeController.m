//
//  WebViewDemoHomeController.m
//  WebViewDemo
//
//  Created by apple on 15/11/26.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "WebViewDemoHomeController.h"
#import <WebKit/WebKit.h>

@interface WebViewDemoHomeController () <UIWebViewDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, weak) UIView *itemView;             // 选项视图

@property (nonatomic, weak) UIButton *loadRequestBtn;     // 加载request按钮
@property (nonatomic, weak) UIButton *loadHTMLStringBtn;  // 加载HTMLString按钮
@property (nonatomic, weak) UIButton *loadDataBtn;        // 加载Data按钮

@property (nonatomic, weak) UIButton *forwardBtn;         // 前进按钮
@property (nonatomic, weak) UIButton *backBtn;            // 后退按钮
@property (nonatomic, weak) UIButton *reloadBtn;          // 刷新按钮

@end

@implementation WebViewDemoHomeController


- (void)loadURLString:(NSString *)urlString {
    NSURL *URL = [NSURL URLWithString:urlString];
    [self loadURL:URL];
}

- (void)loadURL:(NSURL *)URL {
    NSTimeInterval timeout = 30;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeout];
    request.HTTPShouldHandleCookies = YES;
    request.mainDocumentURL = URL;
    [self.webView loadRequest:request];
}








- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.itemView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.webView.frame = CGRectMake(self.view.x, 0, self.view.width, self.view.height - 70);
    self.itemView.frame = CGRectMake(0, self.webView.height, self.view.width, 70);
}

#pragma mark - - - - - - Call Back - - - - -
- (void)loadRequestBtnClick {
    ZCPLog(@"loadRequestBtnClick!");
    // 设置请求
//    NSURL *url = [NSURL URLWithString:@"http://h5.baidu.com/"];
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSTimeInterval timeInterval = 60;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:timeInterval];
    [self.webView loadRequest:request];
    
    // 也可以设置加载文件请求
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"a" ofType:@"html"];
//    NSURL *url = [NSURL fileURLWithPath:filePath];
//    NSTimeInterval timeInterval = 60;
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:timeInterval];
    
    [self.webView loadRequest:request];
}
- (void)loadHTMLStringBtnClick {
    ZCPLog(@"loadHTMLStringBtnClick!");
    // 设置请求
    [self.webView loadHTMLString:@"<pre>1.aaa</br>2.bbb</br></pre>" baseURL:nil];
}
- (void)loadDataBtnClick {
    ZCPLog(@"loadDataBtnClick!");
    // 设置请求
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"a" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)goBackPage {
    [self.webView goBack];
    ZCPLog(@"Go back!");
}
- (void)goForwardPage {
    [self.webView goForward];
    ZCPLog(@"Go forward!");
}
- (void)reloadPage {
//    [self.webView reload];
    ZCPLog(@"Reload!");
    
    NSURL *url = [NSURL URLWithString:@"https://mp.weixin.qq.com/s/rhYKLIbXOsUJC_n6dt9UfA"];
    NSTimeInterval timeInterval = 60;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:timeInterval];
    [self.webView loadRequest:request];
}

#pragma mark - getters and setters

- (WKWebView *)webView {
    if (!_webView) {
        self.view.bounds;
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];

    }
    return _webView;
}

- (UIView *)itemView {
    if (_itemView == nil) {
        // 实例化选项视图
        UIView *itemView = [[UIView alloc] init];
        [itemView setBackgroundColor:[UIColor yellowColor]];
        
        // 实例化加载数据按钮
        UIButton *loadRequestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *loadHTMLStringBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *loadDataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [loadRequestBtn setTitle:@"loadRequestBtn" forState:UIControlStateNormal];
        [loadHTMLStringBtn setTitle:@"loadHTMLStringBtn" forState:UIControlStateNormal];
        [loadDataBtn setTitle:@"loadDataBtn" forState:UIControlStateNormal];
        
        [loadRequestBtn setFrame:CGRectMake(10, 5, 80, 20)];
        [loadHTMLStringBtn setFrame:CGRectMake(SCREENWIDTH / 2 - 40, 5, 80, 20)];
        [loadDataBtn setFrame:CGRectMake(SCREENWIDTH - 10 - 80, 5, 80, 20)];
        [loadRequestBtn setBackgroundColor:[UIColor redColor]];
        [loadHTMLStringBtn setBackgroundColor:[UIColor greenColor]];
        [loadDataBtn setBackgroundColor:[UIColor blueColor]];
        // 添加按钮点击事件响应方法
        [loadRequestBtn addTarget:self action:@selector(loadRequestBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [loadHTMLStringBtn addTarget:self action:@selector(loadHTMLStringBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [loadDataBtn addTarget:self action:@selector(loadDataBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.loadRequestBtn = loadRequestBtn;
        self.loadHTMLStringBtn = loadHTMLStringBtn;
        self.loadDataBtn = loadDataBtn;
        [itemView addSubview:self.loadRequestBtn];
        [itemView addSubview:self.loadHTMLStringBtn];
        [itemView addSubview:self.loadDataBtn];
        
        // 实例化前进、返回按钮
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 40, 80, 20)];
        UIButton *reloadBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 40, 40, 80, 20)];
        UIButton *forwardBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH - 10 - 80, 40, 80, 20)];
        
        [backBtn setTitle:@"backBtn" forState:UIControlStateNormal];
        [reloadBtn setTitle:@"reloadBtn" forState:UIControlStateNormal];
        [forwardBtn setTitle:@"forwardBtn" forState:UIControlStateNormal];
        
        [backBtn setBackgroundColor:[UIColor redColor]];
        [reloadBtn setBackgroundColor:[UIColor greenColor]];
        [forwardBtn setBackgroundColor:[UIColor blueColor]];
        // 添加按钮点击事件响应方法
        [backBtn addTarget:self action:@selector(goBackPage) forControlEvents:UIControlEventTouchUpInside];
        [reloadBtn addTarget:self action:@selector(reloadPage) forControlEvents:UIControlEventTouchUpInside];
        [forwardBtn addTarget:self action:@selector(goForwardPage) forControlEvents:UIControlEventTouchUpInside];
        self.backBtn = backBtn;
        self.reloadBtn = reloadBtn;
        self.forwardBtn = forwardBtn;
        [itemView addSubview:self.backBtn];
        [itemView addSubview:self.reloadBtn];
        [itemView addSubview:self.forwardBtn];
        
        _itemView = itemView;
        [self.view addSubview:_itemView];
    }
    return _itemView;
}

@end
