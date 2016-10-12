//
//  ViewController.m
//  OrientationDemo
//
//  Created by zhuchaopeng on 16/10/12.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ViewController.h"
#import "ModeViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *rotationView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"测试1";
    
    [self.view addSubview:self.rotationView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.rotationView.frame = CGRectMake(0, 0, 100, 50);
    self.rotationView.center = self.view.center;
}

- (UIView *)rotationView {
    if (!_rotationView) {
        _rotationView = [[UIView alloc] init];
        _rotationView.backgroundColor = [UIColor greenColor];
        _rotationView.userInteractionEnabled = YES;
        [_rotationView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoNextVC)]];
    }
    return _rotationView;
}

- (void)gotoNextVC {
    ModeViewController *mvc = [[ModeViewController alloc] init];
    [self presentViewController:mvc animated:YES completion:nil];
}

#pragma mark - 旋转

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft;
}

#pragma mark - 状态栏

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}


@end
