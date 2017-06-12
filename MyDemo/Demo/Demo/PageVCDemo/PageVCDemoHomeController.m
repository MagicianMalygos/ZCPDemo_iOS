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
#import "UIImage+Category.h"
#import <malloc/malloc.h>

@interface PageVCDemoHomeController ()

@property (nonatomic, strong) UIPageViewController *pageVC;

@property (nonatomic, strong) UIButton *firstButton;
@property (nonatomic, strong) UIButton *secondButton;

@property (nonatomic, strong) UIViewController *firstVC;
@property (nonatomic, strong) UIViewController *secondVC;

@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipe;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipe;

@end

@implementation PageVCDemoHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:self.pageVC];
    [self.view addSubview:self.pageVC.view];
    
    [self.view addSubview:self.firstButton];
    [self.view addSubview:self.secondButton];
    
    [self.firstButton addTarget:self action:@selector(firstButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.secondButton addTarget:self action:@selector(secondButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeGestureRecognizer:)];
    self.rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeGestureRecognizer:)];
    
    self.leftSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    self.rightSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.pageVC.view addGestureRecognizer:self.leftSwipe];
    [self.pageVC.view addGestureRecognizer:self.rightSwipe];
    
    // Jump to switch style view controller
    UIButton *jumpButton        = [UIButton buttonWithType:UIButtonTypeCustom];
    jumpButton.frame            = CGRectMake(0, 20, 100, 50);
    jumpButton.backgroundColor  = [UIColor magentaColor];
    jumpButton.tag              = 1;
    [jumpButton setTitle:@"swichStyle" forState:UIControlStateNormal];
    [jumpButton addTarget:self action:@selector(jumpToNextVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jumpButton];
    
    // Jump to book view controller
    UIButton *jumpButton2       = [UIButton buttonWithType:UIButtonTypeCustom];
    jumpButton2.frame           = CGRectMake(100, 20, 100, 50);
    jumpButton2.backgroundColor = [UIColor orangeColor];
    jumpButton2.tag             = 2;
    [jumpButton2 setTitle:@"book" forState:UIControlStateNormal];
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

#pragma mark - button click
- (void)firstButtonClick {
    [self.pageVC setViewControllers:@[self.firstVC] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
    }];
}
- (void)secondButtonClick {
    [self.pageVC setViewControllers:@[self.secondVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
    }];
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
        _pageVC.view.frame = CGRectMake(0, 200, SCREENWIDTH, SCREENHEIGHT - 200);
        _pageVC.view.backgroundColor = [UIColor redColor];
        
        
        [_pageVC setViewControllers:@[self.firstVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        }];
    }
    return _pageVC;
}

- (UIButton *)firstButton {
    if (_firstButton == nil) {
        _firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _firstButton.frame = CGRectMake(0, 150, SCREENWIDTH / 2, 50);
        _firstButton.backgroundColor = [UIColor purpleColor];
        [_firstButton setTitle:@"切换到第一个控制器" forState:UIControlStateNormal];
    }
    return _firstButton;
}
- (UIButton *)secondButton {
    if (_secondButton == nil) {
        _secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _secondButton.frame = CGRectMake(SCREENWIDTH / 2, 150, SCREENWIDTH / 2, 50);
        _secondButton.backgroundColor = [UIColor orangeColor];
        [_secondButton setTitle:@"切换到第二个控制器" forState:UIControlStateNormal];
    }
    return _secondButton;
}

- (UIViewController *)firstVC {
    if (_firstVC == nil) {
        _firstVC = [[UIViewController alloc] init];
        _firstVC.view.frame = CGRectMake(0, 200, SCREENWIDTH, SCREENHEIGHT - 200);
        _pageVC.view.backgroundColor = [UIColor greenColor];
    }
    return _firstVC;
}
- (UIViewController *)secondVC {
    if (_secondVC == nil) {
        _secondVC = [[UIViewController alloc] init];
        _secondVC.view.frame = CGRectMake(0, 200, SCREENWIDTH, SCREENHEIGHT - 200);
        _secondVC.view.backgroundColor = [UIColor blueColor];
    }
    return _secondVC;
}

@end
