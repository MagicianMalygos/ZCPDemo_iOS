//
//  PageVCDemoHomeController.m
//  PageViewController
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "PageVCDemoHomeController.h"
#import "MyViewController.h"
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
    
    // Jump to next ViewController
    UIButton *jumpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    jumpButton.frame = CGRectMake(0, 20, 50, 50);
    jumpButton.backgroundColor = [UIColor magentaColor];
    [jumpButton addTarget:self action:@selector(jumpToNextVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jumpButton];
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
- (void)jumpToNextVC {
    [self.navigationController pushViewController:[MyViewController new] animated:YES];
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
    }
    return _firstButton;
}
- (UIButton *)secondButton {
    if (_secondButton == nil) {
        _secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _secondButton.frame = CGRectMake(SCREENWIDTH / 2, 150, SCREENWIDTH / 2, 50);
        _secondButton.backgroundColor = [UIColor orangeColor];
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
