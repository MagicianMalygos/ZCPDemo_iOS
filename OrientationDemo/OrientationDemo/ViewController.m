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
@property (nonatomic, strong) UIView *rotationView_m;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"测试1";
    
    [self.view addSubview:self.rotationView];
    [self.view addSubview:self.rotationView_m];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat centerX = self.view.center.x;
    CGFloat centerY = self.view.center.y;
    
    self.rotationView.frame     = CGRectMake(centerX - 50, centerY - 25, 50, 50);
    self.rotationView_m.frame   = CGRectMake(centerX, centerY - 25, 50, 50);
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
- (UIView *)rotationView_m {
    if (!_rotationView_m) {
        _rotationView_m = [[UIView alloc] init];
        _rotationView_m.backgroundColor = [UIColor redColor];
        _rotationView_m.userInteractionEnabled = YES;
        [_rotationView_m addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoNextVC_m)]];
    }
    return _rotationView_m;
}

- (void)gotoNextVC {
    ViewController *vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)gotoNextVC_m {
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
