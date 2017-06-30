//
//  ADDemoHomeViewController.m
//  Demo
//
//  Created by 朱超鹏 on 2017/6/28.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "ADDemoHomeViewController.h"
#import <iAd/iAd.h>

@interface ADDemoHomeViewController () <ADBannerViewDelegate, ADInterstitialAdDelegate, UIScrollViewDelegate>

// 横幅广告视图
@property (nonatomic, strong) ADBannerView *adBannerView;

// 插页广告
@property (nonatomic, strong) ADInterstitialAd *interstitial;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *pageList;

@end

@implementation ADDemoHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame = [[UIScreen mainScreen] bounds];
    self.scrollView.frame = CGRectMake(0, 58, self.view.width, 150);
    self.pageControl.frame = CGRectMake(self.scrollView.center.x - 25, self.scrollView.bottom - 30, 50, 30);
    
    /* 1.横幅广告
     在iPhone设备竖屏的情况下，横幅广告的高度为50点，宽度是自适应的。
     在iPhone设备横屏的情况下，横幅广告的高度为32点，宽度是自适应的。
     在iPad设备竖屏的情况下，横幅广告的高度为66点，宽度是自适应的。
     */
    NSLog(@"%@", self.interstitial);
    [self.view addSubview:self.adBannerView];
    
    
    // 2.
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    
    self.pageList = [NSMutableArray array];
    UIView *page1 = [[UIView alloc] init];
    page1.backgroundColor = [UIColor redColor];
    UIView *page2 = [[UIView alloc] init];
    page2.backgroundColor = [UIColor greenColor];
    UIView *page3 = [[UIView alloc] init];
    page3.backgroundColor = [UIColor blueColor];
    
    [self.pageList addObject:page1];
    [self.pageList addObject:page2];
    [self.pageList addObject:page3];
    
    [self reloadPage];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

#pragma mark - private

- (void)reloadPage {
    self.pageControl.numberOfPages = self.pageList.count;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width * self.pageList.count, self.scrollView.height);
    
    for (int i = 0; i < self.pageList.count; i++) {
        UIView *view = self.pageList[i];
        [view removeFromSuperview];
        
        view.frame = CGRectMake(i * self.scrollView.width, 0, self.scrollView.width, 150);
        [self.scrollView addSubview:view];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    self.pageControl.currentPage = offset.x / scrollView.width;
}

#pragma mark - ADBannerViewDelegate

- (void)bannerViewWillLoadAd:(ADBannerView *)banner {
    NSLog(@"banner view will load ad");
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    NSLog(@"banner view did load ad");
}

// ADError for a list of possible error codes.
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"did fail to receive ad. %@", error);
}

/*!
 * @method bannerViewActionShouldBegin:willLeaveApplication:
 *
 * Called when the user taps on the banner and some action is to be taken.
 * Actions either display full screen content modally, or take the user to a
 * different application.
 *
 * The delegate may return NO to block the action from taking place, but this
 * should be avoided if possible because most ads pay significantly more when
 * the action takes place and, over the longer term, repeatedly blocking actions
 * will decrease the ad inventory available to the application.
 *
 * Applications should reduce their own activity while the advertisement's action
 * executes.
 */
- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave {
    NSLog(@"will Leave. %d", willLeave);
    return YES;
}

/*!
 * @method bannerViewActionDidFinish:
 *
 * Called when a modal action has completed and control is returned to the
 * application. Games, media playback, and other activities that were paused in
 * bannerViewActionShouldBegin:willLeaveApplication: should resume at this point.
 */
- (void)bannerViewActionDidFinish:(ADBannerView *)banner {
    NSLog(@"banner view action did finish");
}

#pragma mark - ADInterstitialAdDelegate

- (void)interstitialAd:(ADInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

- (void)interstitialAdDidLoad:(ADInterstitialAd *)interstitialAd {
    NSLog(@"广告加载成功");
    UIView *interstitialContainer = [[UIView alloc] initWithFrame:CGRectZero];
    interstitialContainer.tag = 'A'+'D';
    [self.pageList insertObject:interstitialContainer atIndex:self.pageControl.currentPage];
    [self.interstitial presentInView:interstitialContainer];
}

- (void)interstitialAdDidUnload:(ADInterstitialAd *)interstitialAd {
    NSLog(@"广告卸载");
    for (UIView *view in self.pageList) {
        if (view.tag == 'A'+'D') {
            [view removeFromSuperview];
            [self.pageList removeObject:view];
            [self reloadPage];
        }
    }
}

#pragma mark - getter / setter

- (ADBannerView *)adBannerView {
    if (!_adBannerView) {
        _adBannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
        _adBannerView.origin = CGPointMake(0, 0);
        _adBannerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _adBannerView.delegate = self;
        _adBannerView.backgroundColor = [UIColor redColor];
    }
    return _adBannerView;
}

- (ADInterstitialAd *)interstitial {
    if (!_interstitial) {
        _interstitial = [[ADInterstitialAd alloc] init];
        _interstitial.delegate = self;
    }
    return _interstitial;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.bounces = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        [_pageControl addTarget:self action:@selector(reloadPage) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}

@end
