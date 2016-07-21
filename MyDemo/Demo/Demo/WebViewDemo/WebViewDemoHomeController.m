//
//  WebViewDemoHomeController.m
//  WebViewDemo
//
//  Created by apple on 15/11/26.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "WebViewDemoHomeController.h"

@interface WebViewDemoHomeController () <UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *webView;           // web视图
@property (nonatomic, weak) UIView *itemView;             // 选项视图

@property (nonatomic, weak) UIButton *loadRequestBtn;     // 加载request按钮
@property (nonatomic, weak) UIButton *loadHTMLStringBtn;  // 加载HTMLString按钮
@property (nonatomic, weak) UIButton *loadDataBtn;        // 加载Data按钮

@property (nonatomic, weak) UIButton *forwardBtn;         // 前进按钮
@property (nonatomic, weak) UIButton *backBtn;            // 后退按钮
@property (nonatomic, weak) UIButton *reloadBtn;          // 刷新按钮

@end

@implementation WebViewDemoHomeController

@synthesize webView = _webView;

/*
 *  懒加载选项视图
 */
- (UIView *)itemView {
    if (_itemView == nil) {
        // 实例化选项视图
        UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT - 70, SCREENWIDTH, 70)];
        [itemView setBackgroundColor:[UIColor yellowColor]];
        
        // 实例化加载数据按钮
        UIButton *loadRequestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *loadHTMLStringBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *loadDataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 实例化web视图
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, 20, self.view.frame.size.width, self.view.frame.size.height - self.itemView.frame.size.height - 20)];
    self.webView = webView;
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    [self.view addSubview:self.itemView];
}

#pragma mark - - - - - - Call Back - - - - -
- (void)loadRequestBtnClick {
    ZCPLog(@"loadRequestBtnClick!");
    // 设置请求
    NSURL *url = [NSURL URLWithString:@"http://h5.baidu.com/"]; //
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
    NSData *data = [NSData dataWithContentsOfURL:url];
    [self.webView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:url];
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
    [self.webView reload];
    ZCPLog(@"Reload!");
}

#pragma mark - - - - - - UIWebViewDelegate - - - - -
/*
 *  准备开始加载URL时执行
 @prarm UIWebViewNavigationType navigationType 用户行为:
 0 UIWebViewNavigationTypeLinkClicked，用户触击了一个链接。
 1 UIWebViewNavigationTypeFormSubmitted，用户提交了一个表单。
 2 UIWebViewNavigationTypeBackForward，用户触击前进或返回按钮。
 3 UIWebViewNavigationTypeReload，用户触击重新加载的按钮。
 4 UIWebViewNavigationTypeFormResubmitted，用户重复提交表单
 5 UIWebViewNavigationTypeOther，发生其它行为。
 
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    ZCPLog(@"shouldLoadWithRequest!\nrequest:%@\nnavigationType:%ld", request, navigationType);
    
//    NSURL *url = [request URL];
//    // 当用户触击一个链接时，使用浏览器去加载url
//    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
//        if ([[UIApplication sharedApplication] canOpenURL:url]) {
//            [[UIApplication sharedApplication] openURL:url];
//        }
//        return NO;
//    }
    return YES;
}
/*
 *  开始加载URL时执行
 */
- (void)webViewDidStartLoad:(UIWebView *)webView {
    ZCPLog(@"webViewDidStartLoad!");
}
/*
 *  加载URL完毕时执行
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    ZCPLog(@"webViewDidFinishLoad!\nStateInfo:\ngoback:%d\ngoforward:%d\nloading:%d", self.webView.canGoBack, self.webView.canGoForward, self.webView.loading);
}
/*
 *  当请求页面出现错误的时候执行
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    ZCPLog(@"didFailLoadWithError! error:%@", error);
}

@end
