//
//  ZCPWebViewController.m
//  ZCPKit
//
//  Created by zhuchaopeng on 16/9/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPWebViewController.h"
#import "ZCPUtil.h"

@interface ZCPWebViewController () <NSURLConnectionDataDelegate>

// url字符串中包含的参数
@property (nonatomic, strong)   NSDictionary  *urlParams;

// 通用的ActionDic
@property (nonatomic, strong)   NSDictionary  *actionDic;

// 是否显示导航栏
@property (nonatomic, strong)   NSNumber      *needsNavigationBar;
// 前一页面在跳转过来时nav bar是否是隐藏的
@property (nonatomic, assign)   BOOL          fromPageNavBarHidden;

// webview 是否透明
@property (nonatomic, strong)   NSNumber      *webViewTransparent;

@property (strong, nonatomic)   NSString      *shareMsg;

// preload share image
@property (strong, nonatomic)   UIImage       *shareImage;

@property (nonatomic, copy)     NSString      *titleFromUrl;


// 是否关闭右滑返回手势，默认为NO
@property (nonatomic, assign)   BOOL          disableBackGesture;

@property (nonatomic, weak)     id<PAWebViewControllerBackDelegate> delegate;

@end

@implementation ZCPWebViewController

#pragma mark - init
- (instancetype)initWithParams:(NSDictionary *)params {
    if (params && [params isKindOfClass:[NSDictionary class]]) {
        
        NSString *url                   = [params objectForKey:@"_url"];
        NSString *title                 = [params objectForKey:@"_title"];
        NSString *needsNavigationBar    = [params objectForKey:@"_needsNavigationBar"];
        
        NSNumber *disableBackGesture    = [params objectForKey:@"_disableBackGesture"];
        self.postParams                 = [params objectForKey:@"_postParams"];
        self.delegate                   = [params objectForKey:@"_delegate"];
        
        if (disableBackGesture) {
            self.disableBackGesture     = [disableBackGesture boolValue];
        }
        
        self                            = [self initWithURL:url];
        self.title                      = title;
        self.needsNavigationBar         = needsNavigationBar ? [NSNumber numberWithBool:[needsNavigationBar boolValue]] : @YES;
        self.titleFromUrl               = title;
        
    } else {
        self = [super init];
    }
    return self;
}

- (instancetype)initWithURL:(NSString *)url {
    if (self = [super init]) {
        if (url && [url isKindOfClass:[NSString class]]) {
            self.urlString                  = url;
            
            //赋初值
            self.needsNavigationBar         = @YES;
            
            [self parseURL];
        }
    }
    
    return self;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //initialize
    [self initialize];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.fromPageNavBarHidden = self.navigationController.navigationBarHidden;
    self.navigationController.navigationBarHidden = ![self.needsNavigationBar boolValue];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setCustomBackgroundColor:[UIColor whiteColor]];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = self.fromPageNavBarHidden;
}

- (void)viewWillLayoutSubviews{
    self.webView.width          = self.view.width;
    self.webView.height         = self.view.height;
}

- (void)dealloc {
    _webView.delegate = nil;
}

#pragma mark - load webview

#pragma mark 加载webview
- (void)loadWebView{
    if (![self.view.subviews containsObject:self.webView]) {
        [self.view addSubview:self.webView];
    }
    
    //webview背景是否透明
    if (self.webViewTransparent && [self.webViewTransparent boolValue]) {
        [_webView clearBackgroundColor];
    }else{
        _webView.opaque = NO;
    }
    
    //load url
    NSString * url = [self urlToLoad];
    [self loadURL:url];
}

#pragma mark 加载url
- (void)loadURL:(NSString *)url {

    // url encode // 目前这句意义不明，有点多余
//    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *URL            = [NSURL URLWithString:url];
    NSTimeInterval timeout = 30;
    
//    [self.webView loadCookies:URL];
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeout];
//    [request addDefaultHttpHeaders];
    [request setHTTPShouldHandleCookies:YES];
    request.mainDocumentURL = URL;
    
    if (self.postParams) {
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        NSString *query = [self stringFromQueryParameters:self.postParams];
        [request setHTTPBody:[query dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [self.webView loadRequest:request];
    
    self.navigationController.navigationBarHidden = ![self.needsNavigationBar boolValue];
}

#pragma mark 重加载
- (void)reload{
    [self loadURL:self.urlString];
}


#pragma mark - setter/getter
- (UIWebView *)webView {
    if (_webView == nil) {
        self.webView = [[UIWebView alloc] initWithFrame:({
            CGRectMake(0, 0, self.view.width, self.view.height);
        })];
//        [_webView configureJSAPI];
        _webView.delegate           = self;
        _webView.scalesPageToFit    = YES;
    }
    
    return _webView;
}

- (NSString *)urlToLoad{
    NSString * url  = nil;
    url             = self.urlString;
    return url;
}

- (NSNumber *)needsNavigationBar {
    if (_needsNavigationBar == nil) {
        self.needsNavigationBar     = @YES;
    }
    return _needsNavigationBar;
}

#pragma mark - setup
- (void)clearNavigationBar {
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)initLoadingBarButton {
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:indicator];
    self.navigationItem.rightBarButtonItem = rightButton;
    [indicator startAnimating];
}

#pragma mark - initialize
- (void)initialize{
    //load webview

    self.title = @"正在载入...";
    [self loadWebView];
    
    //set background color
    self.webView.backgroundColor = [UIColor colorFromHexRGB:@"ececec"];
    
    [self initLoadingBarButton];
}

#pragma mark - functions
- (void)parseURL{
    [self parseURL:self.urlString];
}

- (void)parseURL:(NSString *)url{
    if (url) {
        NSDictionary * params   = [url getURLParams];
        self.urlParams          = params;
    }
}

- (id)paramForKey:(NSString *)key {
    return [self.urlParams objectForKey:key];
}

//禁止用户选择
- (void)banUserSelect{
    [_webView stringByEvaluatingJavaScriptFromString:
     @"document.documentElement.style.webkitUserSelect='none';"];
}

// 禁用长按弹出框
- (void)banTouchCallout{
    [_webView stringByEvaluatingJavaScriptFromString:
     @"document.documentElement.style.webkitTouchCallout='none';"];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    //show loading
    [[ZCPIndicator sharedInstance] showIndicator];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    BOOL flag           = YES;
    
    NSURL * url         = [request URL];
	NSString *urlString = [url absoluteString];
    
    if (!(urlString && urlString.length)) {
        flag            = NO;
        return flag;
    }
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        if ([request.URL isAppURL]) {
            // pahaofang://
            openURL(urlString);
//            [[PANavigator sharedInstance] openURL:request.URL.absoluteString];
        } else {
            // http://
            // always open in new view controller
            openURL(urlString);
        }
        flag = NO;
    }
    
    return flag;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {

    //hide loading
    [[ZCPIndicator sharedInstance] dismissIndicator];

    [self banTouchCallout];
    
    [self banUserSelect];
    
    [self clearNavigationBar];
    
    __weak typeof(self) weakSelf = self;
    
    if (!self.titleFromUrl) {
        // FIXED: 过早设置标题，文字晃动
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            weakSelf.title = weakSelf.titleFromUrl;
            
            // If title from url is empty, try to apply title from html page.
            if ([weakSelf.title length] == 0) {
                NSString *titleFromHTML = [self titleFromHTMLPage:webView];
                if ([titleFromHTML length] > 0) {
                    weakSelf.title = titleFromHTML;
                }
            }
        });
    } else {
        self.title = self.titleFromUrl;
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    // Ignore NSURLErrorDomain error -999.
    if([error code] == NSURLErrorCancelled) return;
    // Ignore "Fame Load Interrupted" errors. Seen after app store links.
    if (error.code == 102 && [error.domain isEqual:@"WebKitErrorDomain"]) return;
    
    //hide loading
    [[ZCPIndicator sharedInstance] dismissIndicator];
    self.title = @"加载失败";
    [self clearNavigationBar];
}


#pragma mark - UIViewController (Category)
- (void)backTo {
    if(self.delegate && [self.delegate respondsToSelector:@selector(webViewDidClickBackBarButton)]){
        [self.delegate webViewDidClickBackBarButton];
        return;
    }
    [super backTo];
}

- (NSString *)titleFromHTMLPage:(UIWebView *)webView {
    return [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

#pragma mark - PAViewControllerStates

#pragma mark 控制是否可以右滑返回(可以做成传参来控制)
- (BOOL)disableInteractiveGesture {
    return self.disableBackGesture;
}

#pragma mark - 支持postParam的工具方法

- (NSString *)stringFromQueryParameters:(NSDictionary*)queryParameters {
    NSMutableArray* parts = [NSMutableArray array];
    [queryParameters enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        NSString *part = [NSString stringWithFormat: @"%@=%@",
                          PAPercentEscapedQueryStringKeyFromStringWithEncoding(key, NSUTF8StringEncoding),
                          PAPercentEscapedQueryStringValueFromStringWithEncoding([value stringValue], NSUTF8StringEncoding)
                          ];
        [parts addObject:part];
    }];
    return [parts componentsJoinedByString: @"&"];
}

static NSString * const kPACharactersToBeEscapedInQueryString = @":/?&=;+!@#$()',*";

static NSString * PAPercentEscapedQueryStringKeyFromStringWithEncoding(NSString *string, NSStringEncoding encoding) {
    static NSString * const kPACharactersToLeaveUnescapedInQueryStringPairKey = @"[].";
    return (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, (__bridge CFStringRef)kPACharactersToLeaveUnescapedInQueryStringPairKey, (__bridge CFStringRef)kPACharactersToBeEscapedInQueryString, CFStringConvertNSStringEncodingToEncoding(encoding));
}

static NSString * PAPercentEscapedQueryStringValueFromStringWithEncoding(NSString *string, NSStringEncoding encoding) {
    return (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, NULL, (__bridge CFStringRef)kPACharactersToBeEscapedInQueryString, CFStringConvertNSStringEncodingToEncoding(encoding));
}

@end
