//
//  MyViewController.m
//  PageViewController
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;

@property (nonatomic, strong) UIViewController *vc1;
@property (nonatomic, strong) UIViewController *vc2;
@property (nonatomic, strong) UIViewController *vc3;

@property (nonatomic, weak) UIViewController *currentVC;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.btn1];
    [self.view addSubview:self.btn2];
    [self.view addSubview:self.btn3];
    
    [self.btn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
    [self.btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
    [self.btn3 addTarget:self action:@selector(btn3Click) forControlEvents:UIControlEventTouchUpInside];
    
    [self addChildViewController:self.vc1];
    [self addChildViewController:self.vc2];
    [self addChildViewController:self.vc3];
    
    self.currentVC = self.vc1;
    [self.view addSubview:self.currentVC.view];
}

#pragma mark - btn click
- (void)btn1Click {
    if (self.currentVC != self.vc1) {
        [self transitionFromViewController:self.currentVC toViewController:self.vc1 duration:1.0f options:UIViewAnimationOptionTransitionCurlUp animations:nil completion:^(BOOL finished) {
            self.currentVC = self.vc1;
        }];
    }
}
- (void)btn2Click {
    if (self.currentVC != self.vc2) {
        [self transitionFromViewController:self.currentVC toViewController:self.vc2 duration:1.0f options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
            self.currentVC = self.vc2;
        }];
    }
}
- (void)btn3Click {
    if (self.currentVC != self.vc3) {
        [self transitionFromViewController:self.currentVC toViewController:self.vc3 duration:1.0f options:UIViewAnimationOptionTransitionFlipFromTop animations:nil completion:^(BOOL finished) {
            self.currentVC = self.vc3;
        }];
    }
}

#pragma mark - getter / setter
- (UIButton *)btn1 {
    if (_btn1 == nil) {
        _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn1.frame = CGRectMake(0, 20, SCREENWIDTH / 3, 50);
        _btn1.backgroundColor = [UIColor redColor];
    }
    return _btn1;
}
- (UIButton *)btn2 {
    if (_btn2 == nil) {
        _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn2.frame = CGRectMake(SCREENWIDTH / 3, 20, SCREENWIDTH / 3, 50);
        _btn2.backgroundColor = [UIColor greenColor];
    }
    return _btn2;
}
- (UIButton *)btn3 {
    if (_btn3 == nil) {
        _btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn3.frame = CGRectMake(SCREENWIDTH * 2 / 3, 20, SCREENWIDTH / 3, 50);
        _btn3.backgroundColor = [UIColor blueColor];
    }
    return _btn3;
}
- (UIViewController *)vc1 {
    if (_vc1 == nil) {
        _vc1 = [[UIViewController alloc] init];
        _vc1.view.frame = CGRectMake(0, 100, SCREENWIDTH, SCREENHEIGHT - 100);
        _vc1.view.backgroundColor = [UIColor redColor];
    }
    return _vc1;
}
- (UIViewController *)vc2 {
    if (_vc2 == nil) {
        _vc2 = [[UIViewController alloc] init];
        _vc2.view.frame = CGRectMake(0, 100, SCREENWIDTH, SCREENHEIGHT - 100);
        _vc2.view.backgroundColor = [UIColor greenColor];
    }
    return _vc2;
}
- (UIViewController *)vc3 {
    if (_vc3 == nil) {
        _vc3 = [[UIViewController alloc] init];
        _vc3.view.frame = CGRectMake(0, 100, SCREENWIDTH, SCREENHEIGHT - 100);
        _vc3.view.backgroundColor = [UIColor blueColor];
    }
    return _vc3;
}

@end
