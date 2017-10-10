//
//  PageVCDemoHomeController.m
//  PageViewController
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "PageVCDemoHomeController.h"
#import "MyViewController.h"
#import "BookViewController.h"
#import <malloc/malloc.h>

@interface PageVCDemoHomeController ()

@property (nonatomic, strong) UIPageViewController *pageVC;

@property (nonatomic, strong) UIButton *firstButton;
@property (nonatomic, strong) UIButton *secondButton;
@property (nonatomic, strong) UIButton *thirdButton;

@property (nonatomic, strong) UIViewController *firstVC;
@property (nonatomic, strong) UIViewController *secondVC;
@property (nonatomic, strong) UIViewController *thirdVC;

@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipe;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipe;

@end

@implementation PageVCDemoHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildVC];
    [self addOtherButton];
}

- (void)addChildVC {
    
    [self.view addSubview:self.pageVC.view];
    [self.view addSubview:self.firstButton];
    [self.view addSubview:self.secondButton];
    [self.view addSubview:self.thirdButton];
    
    // add event
    [self.firstButton addTarget:self action:@selector(firstButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.secondButton addTarget:self action:@selector(secondButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.thirdButton addTarget:self action:@selector(thirdButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    // add gesture
    self.leftSwipe              = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeGestureRecognizer:)];
    self.rightSwipe             = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeGestureRecognizer:)];
    self.leftSwipe.direction    = UISwipeGestureRecognizerDirectionRight;
    self.rightSwipe.direction   = UISwipeGestureRecognizerDirectionLeft;
    [self.pageVC.view addGestureRecognizer:self.leftSwipe];
    [self.pageVC.view addGestureRecognizer:self.rightSwipe];
}

- (void)addOtherButton {
    // Jump to switch style view controller
    UIButton *jumpButton        = [UIButton buttonWithType:UIButtonTypeCustom];
    jumpButton.frame            = CGRectMake(0, 0, SCREENWIDTH / 2, 50);
    jumpButton.backgroundColor  = [UIColor purpleColor];
    jumpButton.tag              = 1;
    jumpButton.titleLabel.font  = [UIFont systemFontOfSize:14.0f];
    [jumpButton setTitle:@"视图切换样式" forState:UIControlStateNormal];
    [jumpButton addTarget:self action:@selector(jumpToNextVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jumpButton];
    
    // Jump to book view controller
    UIButton *jumpButton2       = [UIButton buttonWithType:UIButtonTypeCustom];
    jumpButton2.frame           = CGRectMake(SCREENWIDTH / 2, 0, SCREENWIDTH / 2, 50);
    jumpButton2.backgroundColor = [UIColor orangeColor];
    jumpButton2.tag             = 2;
    jumpButton2.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [jumpButton2 setTitle:@"图书风格UI界面" forState:UIControlStateNormal];
    [jumpButton2 addTarget:self action:@selector(jumpToNextVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jumpButton2];
}

#pragma mark - swipe gesture recognizer
- (void)leftSwipeGestureRecognizer:(UISwipeGestureRecognizer *)swipe {
    [self.pageVC setViewControllers:@[self.firstVC] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
    }];
}
- (void)rightSwipeGestureRecognizer:(UISwipeGestureRecognizer *)swipe {
    [self.pageVC setViewControllers:@[self.secondVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
    }];
}

#pragma mark - event response
- (void)firstButtonClick {
    [self.pageVC setViewControllers:@[self.firstVC] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
}
- (void)secondButtonClick {
    UIPageViewControllerNavigationDirection directionForward = UIPageViewControllerNavigationDirectionForward;
    if ([self.pageVC.viewControllers firstObject] != self.firstVC) {
        directionForward = UIPageViewControllerNavigationDirectionReverse;
    }
    
    [self.pageVC setViewControllers:@[self.secondVC] direction:directionForward animated:YES completion:nil];
}

- (void)thirdButtonClick {
    [self.pageVC setViewControllers:@[self.thirdVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

- (void)jumpToNextVC:(UIButton *)button {
    if (button.tag == 1) {
        [self.navigationController pushViewController:[MyViewController new] animated:YES];
    } else if (button.tag == 2) {
        BookViewController *bookVC = [[BookViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        [self.navigationController pushViewController:bookVC animated:YES];
    }
}

#pragma mark - getter / setter
- (UIPageViewController *)pageVC {
    if (_pageVC == nil) {
        _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageVC.view.frame              = CGRectMake(0, 150, SCREENWIDTH, SCREENHEIGHT - 150);
        _pageVC.view.backgroundColor    = [UIColor whiteColor];
        [_pageVC setViewControllers:@[self.firstVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        }];
    }
    return _pageVC;
}

- (UIButton *)firstButton {
    if (_firstButton == nil) {
        _firstButton                    = [UIButton buttonWithType:UIButtonTypeCustom];
        _firstButton.frame              = CGRectMake(0, 100, SCREENWIDTH / 3, 50);
        _firstButton.backgroundColor    = [UIColor purpleColor];
        _firstButton.titleLabel.font    = [UIFont systemFontOfSize:14.0f];
        [_firstButton setTitle:@"switch 1th VC" forState:UIControlStateNormal];
    }
    return _firstButton;
}
- (UIButton *)secondButton {
    if (_secondButton == nil) {
        _secondButton                   = [UIButton buttonWithType:UIButtonTypeCustom];
        _secondButton.frame             = CGRectMake(SCREENWIDTH / 3, 100, SCREENWIDTH / 3, 50);
        _secondButton.backgroundColor   = [UIColor orangeColor];
        _secondButton.titleLabel.font   = [UIFont systemFontOfSize:14.0f];
        [_secondButton setTitle:@"switch 2th VC" forState:UIControlStateNormal];
    }
    return _secondButton;
}

- (UIButton *)thirdButton {
    if (!_thirdButton) {
        _thirdButton                    = [UIButton buttonWithType:UIButtonTypeCustom];
        _thirdButton.frame              = CGRectMake(SCREENWIDTH * 2/3, 100, SCREENWIDTH / 3, 50);
        _thirdButton.backgroundColor    = [UIColor brownColor];
        _thirdButton.titleLabel.font    = [UIFont systemFontOfSize:14.0f];
        [_thirdButton setTitle:@"switch 3th VC" forState:UIControlStateNormal];
    }
    return _thirdButton;
}

- (UIViewController *)firstVC {
    if (_firstVC == nil) {
        _firstVC                        = [[UIViewController alloc] init];
        _firstVC.view.frame             = CGRectMake(0, 150, SCREENWIDTH, SCREENHEIGHT - 150);
        _pageVC.view.backgroundColor    = [UIColor redColor];
    }
    return _firstVC;
}
- (UIViewController *)secondVC {
    if (_secondVC == nil) {
        _secondVC                       = [[UIViewController alloc] init];
        _secondVC.view.frame            = CGRectMake(0, 150, SCREENWIDTH, SCREENHEIGHT - 150);
        _secondVC.view.backgroundColor  = [UIColor greenColor];
    }
    return _secondVC;
}

- (UIViewController *)thirdVC {
    if (_thirdVC == nil) {
        _thirdVC                       = [[UIViewController alloc] init];
        _thirdVC.view.frame            = CGRectMake(0, 150, SCREENWIDTH, SCREENHEIGHT - 150);
        _thirdVC.view.backgroundColor  = [UIColor blueColor];
    }
    return _thirdVC;
}

@end
