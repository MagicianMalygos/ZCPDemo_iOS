//
//  ModeViewController.m
//  OrientationDemo
//
//  Created by zhuchaopeng on 16/10/12.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ModeViewController.h"

@interface ModeViewController ()

@property (nonatomic, strong) UIView *rotationView;

@end

@implementation ModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
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
        _rotationView.backgroundColor = [UIColor orangeColor];
        _rotationView.userInteractionEnabled = YES;
        [_rotationView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoNextVC)]];
    }
    return _rotationView;
}

- (void)gotoNextVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 旋转


#pragma mark - 状态栏

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault ;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationNone;
}

@end
