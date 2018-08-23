//
//  CASection9Demo.m
//  Demo
//
//  Created by 朱超鹏 on 2018/8/21.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "CASection9Demo.h"

@interface CASection9Demo ()

@property (nonatomic, strong) CALayer *moveLayer;
@property (nonatomic, strong) CAShapeLayer *trackLayer;
@property (nonatomic, strong) UISlider *animationProgress;

@end

@implementation CASection9Demo

// ----------------------------------------------------------------------
#pragma mark - demo
// ----------------------------------------------------------------------

#pragma mark CAMediaTiming协议
- (void)demo1 {
    // CAMediaTiming协议定义了在一段动画内用来控制逝去时间的属性的集合，
    // CALayer和CAAnimation都实现了这个协议，所以时间可以被任意基于一个图层或者一段动画的类控制。
    
    
}

#pragma mark 层级关系时间
- (void)demo2 {
    
}

#pragma mark 手动动画
- (void)demo3 {
    
    // 如果moveLayer设置一个起始的timeOffset，没有效果，且滑动时效果不太对。除非延迟设置
    
    self.animationProgress      = [[UISlider alloc] init];
    self.animationProgress.frame = CGRectMake(100, 10, self.width - 200, 20);
    self.animationProgress.minimumValue = 0;
    self.animationProgress.maximumValue = 10;
    self.animationProgress.value = 5;
    [self.animationProgress addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.animationProgress];
    
    UIBezierPath *path          = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(50, self.height / 2)];
    [path addCurveToPoint:CGPointMake(self.width - 50, self.height / 2) controlPoint1:CGPointMake(150, self.height / 2 - 200) controlPoint2:CGPointMake(self.width - 100, self.height / 2 + 200)];
    
    // 移动layer
    self.moveLayer              = [CALayer layer];
    self.moveLayer.contents     = (__bridge id)[UIImage imageNamed:@"plane"].CGImage;
    self.moveLayer.frame        = CGRectMake(0, 0, 50, 50);
    self.moveLayer.position     = CGPointMake(50, self.height / 2);
    [self.layer addSublayer:self.moveLayer];
    
    CAKeyframeAnimation *ani3   = [CAKeyframeAnimation animation];
    ani3.keyPath                = @"position";
    ani3.path                   = path.CGPath;
    ani3.duration               = 10.0f;
    ani3.rotationMode           = kCAAnimationRotateAuto;
    ani3.fillMode               = kCAFillModeBoth;
    ani3.removedOnCompletion    = NO;
    [self.moveLayer addAnimation:ani3 forKey:@"moveAnimation"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.moveLayer.timeOffset = 5;
    });
    
    // 轨迹layer
    self.trackLayer             = [CAShapeLayer layer];
    self.trackLayer.path        = path.CGPath;
    self.trackLayer.fillColor   = [UIColor clearColor].CGColor;
    self.trackLayer.strokeColor = [UIColor redColor].CGColor;
    self.trackLayer.lineWidth   = 5;
    [self.layer addSublayer:self.trackLayer];
}

- (void)valueChange {
    NSLog(@"%f", self.animationProgress.value);
    self.moveLayer.timeOffset = self.animationProgress.value;
}

@end
