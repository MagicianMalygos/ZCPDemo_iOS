//
//  CATransform3DDemoHomeController.m
//  Demo
//
//  Created by 朱超鹏(外包) on 17/2/21.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "CATransform3DDemoHomeController.h"

@interface CATransform3DDemoHomeController ()

@property (nonatomic, strong) UIButton *animationView;

@end

@implementation CATransform3DDemoHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // setup animation view
    self.animationView                  = [UIButton buttonWithType:UIButtonTypeCustom];
    self.animationView.frame            = CGRectMake(0, 0, 15, 32);
    self.animationView.center           = self.view.center;
    self.animationView.backgroundColor  = [UIColor redColor];
    [self.animationView setBackgroundImage:[UIImage imageNamed:@"fire"] forState:UIControlStateNormal];
    [self.animationView addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.animationView];
}

- (void)example1 {
    CABasicAnimation *theAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    // 起始状态
    CATransform3D transform = CATransform3DMakeScale(1.0, 1.0, 1.0); // x,y,z缩放倍数
    [theAnimation setFromValue:[NSValue valueWithCATransform3D:transform]];
    
    // 结束状态
    transform = CATransform3DMakeScale(0.5, 0.5, 1.0);
    [theAnimation setToValue:[NSValue valueWithCATransform3D:transform]];
    
    // 参数设置
    [theAnimation setAutoreverses:YES];
    [theAnimation setDuration:1.0];
    [theAnimation setRepeatCount:2];
    
    // 设置动画
    [self.animationView.layer addAnimation:theAnimation forKey:nil];
}

- (void)example2 {
    CABasicAnimation *theAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    CATransform3D transform = CATransform3DMakeRotation(0, 1, 0, 0); // 旋转角度的弧度值，X * PI/180
    [theAnimation setFromValue:[NSValue valueWithCATransform3D:transform]];
    
    transform = CATransform3DMakeRotation(1.57, 1, 0, 0);
    [theAnimation setToValue:[NSValue valueWithCATransform3D:transform]];
    
    [theAnimation setAutoreverses:YES];
    [theAnimation setDuration:1.0];
    [theAnimation setRepeatCount:2];
    
    [self.animationView.layer addAnimation:theAnimation forKey:nil];
}

- (void)example3 {
    CABasicAnimation *theAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D rotateTransform = CATransform3DMakeRotation(1.57, 0, 0, -1);
    CATransform3D scaleTransform = CATransform3DMakeScale(5, 5, 5);
    CATransform3D positionTransform = CATransform3DMakeTranslation(100, 0, 0);
    
    CATransform3D combinedTransform = CATransform3DConcat(rotateTransform, scaleTransform);
    combinedTransform = CATransform3DConcat(combinedTransform, positionTransform);
    
    [theAnimation setFromValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]];
    [theAnimation setToValue:[NSValue valueWithCATransform3D:combinedTransform]];
    
    [theAnimation setDuration:5.0];
    [self.animationView.layer addAnimation:theAnimation forKey:nil];
    [self.animationView.layer setTransform:combinedTransform];
}

- (void)click {
//    [self example1];
//    [self example2];
    [self example3];
}

@end
