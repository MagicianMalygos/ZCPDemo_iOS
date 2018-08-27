//
//  CASection9Demo.m
//  Demo
//
//  Created by 朱超鹏 on 2018/8/21.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "CASection9Demo.h"

#define Demo1AnimationDuration    4

@interface CASection9Demo ()

@property (nonatomic, strong) CALayer *cubeLayer;
@property (nonatomic, strong) CALayer *lineLayer;

@property (nonatomic, strong) CALayer *moveLayer;
@property (nonatomic, strong) CAShapeLayer *trackLayer;
@property (nonatomic, strong) UISlider *animationProgress;

@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation CASection9Demo

// ----------------------------------------------------------------------
#pragma mark - demo
// ----------------------------------------------------------------------

// CAMediaTiming协议定义了在一段动画内用来控制逝去时间的属性的集合，
// CALayer和CAAnimation都实现了这个协议，所以时间可以被任意基于一个图层或者一段动画的类控制。

#pragma mark CAMediaTiming协议
- (void)demo1 {
    /*
     CAMediaTiming
        beginTime           CFTimeInterval(double)      开始时间，如果想要设置为当前时间+2s，需要设置为CACurrentMediaTime() + 2，默认为0
        duration            CFTimeInterval(double)      持续时间，默认为0
        speed               float                       速度倍数（相对于父时间环境），例如speed=2时，1秒动画，实际0.5秒就完成。
        timeOffset          CFTimeInterval(double)      动画执行的时间偏移量，要注意动画会循环执行，（假如设置为2，5秒的动画会从原本2秒的状态开始执行到5秒，然后会再从0秒到2秒），默认为0
        repeatCount         float                       重复次数，不能和repeatDuration同时使用，可以为分数，默认为0
        repeatDuration      CFTimeInterval(double)      在指定时间内重复执行，不能和repeatCount同时使用，默认为0
        autoreverses        BOOL                        自动反转，动画执行结束后再逆向执行，默认为NO
        fillMode            NSString*                   定义计时对象在其活动持续时间之外的行为，默认为removed
     
        有以下几个值：
            kCAFillModeForwards:    'forwards'          动画结束后保持状态。使动画结束后保持动画结束那一刻的值。需要将removedOnCompletion设置为NO，仅设置该模式是不起作用的。
            kCAFillModeBackwards:   'backwards'         设置该模式后，layer执行动画开始前就将保持动画开始那一刻的值。设置该模式的效果为：会先将对象设置到动画初始状态，然后等待beginTime之后再执行动画。未设置该模式的效果为：等待beginTime之后再瞬间将对象设置到动画初始状态，然后再执行动画。
            kCAFillModeBoth:        'both'              forwards + backward的组合效果
            kCAFillModeRemoved:     'removed'           动画结束后移除
     */
    
    // duration
    {
        UILabel *label          = [self getTestLabel];
        label.text              = @"duration";
        label.frame             = CGRectMake(10, 10, 80, 30);
        [self addSubview:label];
        
        CABasicAnimation *ani   = [self getMoveAnimation];
        ani.duration            = Demo1AnimationDuration;
        [label.layer addAnimation:ani forKey:nil];
    }
    // autoreverses
    {
        UILabel *label          = [self getTestLabel];
        label.text              = @"autoreverses";
        label.frame             = CGRectMake(10, 50, 80, 30);
        [self addSubview:label];
        
        CABasicAnimation *ani   = [self getMoveAnimation];
        ani.autoreverses        = YES;
        [label.layer addAnimation:ani forKey:nil];
    }
    // speed
    {
        UILabel *label          = [self getTestLabel];
        label.text              = @"speed";
        label.frame             = CGRectMake(10, 90, 80, 30);
        [self addSubview:label];
        
        CABasicAnimation *ani   = [self getMoveAnimation];
        ani.speed               = 2;
        [label.layer addAnimation:ani forKey:nil];
    }
    // timeOffset
    {
        UILabel *label          = [self getTestLabel];
        label.text              = @"timeOffset";
        label.frame             = CGRectMake(10, 130, 80, 30);
        [self addSubview:label];
        
        CABasicAnimation *ani   = [self getMoveAnimation];
        ani.timeOffset          = Demo1AnimationDuration / 2;
        [label.layer addAnimation:ani forKey:nil];
    }
    // repeatCount
    {
        UILabel *label          = [self getTestLabel];
        label.text              = @"repeatCount";
        label.frame             = CGRectMake(10, 170, 80, 30);
        [self addSubview:label];
        
        CABasicAnimation *ani   = [self getMoveAnimation];
        ani.repeatCount         = 2.5;
        [label.layer addAnimation:ani forKey:nil];
    }
    // repeatDuration
    {
        UILabel *label          = [self getTestLabel];
        label.text              = @"repeatDuration";
        label.frame             = CGRectMake(10, 210, 80, 30);
        [self addSubview:label];
        
        CABasicAnimation *ani   = [self getMoveAnimation];
        ani.repeatDuration      = Demo1AnimationDuration * 2.5;
        [label.layer addAnimation:ani forKey:nil];
    }
    // beginTime
    {
        UILabel *label          = [self getTestLabel];
        label.text              = @"beginTime";
        label.frame             = CGRectMake(self.width / 2 - 40, 250, 80, 30);
        [self addSubview:label];
        
        CABasicAnimation *ani   = [self getMoveAnimation];
        ani.beginTime           = CACurrentMediaTime() + 2;
        [label.layer addAnimation:ani forKey:nil];
    }
    // fillMode kCAFillModeBackwards
    {
        UILabel *label          = [self getTestLabel];
        label.text              = @"kCAFillModeBackwards";
        label.frame             = CGRectMake(self.width / 2 - 40, 290, 80, 30);
        [self addSubview:label];
        
        CABasicAnimation *ani   = [self getMoveAnimation];
        ani.beginTime           = CACurrentMediaTime() + 2;
        ani.fillMode            = kCAFillModeBackwards;
        [label.layer addAnimation:ani forKey:nil];
    }
    // fillMode kCAFillModeForwards
    {
        UILabel *label          = [self getTestLabel];
        label.text              = @"kCAFillModeForwards";
        label.frame             = CGRectMake(10, 330, 80, 30);
        [self addSubview:label];
        
        CABasicAnimation *ani   = [self getMoveAnimation];
        ani.fillMode            = kCAFillModeForwards;
        ani.removedOnCompletion = NO;
        [label.layer addAnimation:ani forKey:nil];
    }
}

#pragma mark 手动动画
- (void)demo2 {
    /*
     你将一个动画看作一个环,timeOffset改变的其实是动画在环内的起点,比如一个duration为5秒的动画,将timeOffset设置为2,那么动画的运行则是从原本2秒的位置开始到5秒,接着再从0秒到2秒,完成一次动画.
     */
    
    self.animationProgress              = [[UISlider alloc] init];
    self.animationProgress.frame        = CGRectMake(100, 10, self.width - 200, 20);
    self.animationProgress.minimumValue = 0;
    self.animationProgress.maximumValue = 10;
    self.animationProgress.value        = 0;
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
    self.moveLayer.speed        = 0;
    [self.layer addSublayer:self.moveLayer];
    
    CAKeyframeAnimation *ani3   = [CAKeyframeAnimation animation];
    ani3.keyPath                = @"position";
    ani3.path                   = path.CGPath;
    ani3.duration               = 10.0f;
    ani3.rotationMode           = kCAAnimationRotateAuto;
    [self.moveLayer addAnimation:ani3 forKey:@"moveAnimation"];
    
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

// ----------------------------------------------------------------------
#pragma mark - life cycle
// ----------------------------------------------------------------------

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview == nil) {
        [_displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        [_displayLink invalidate];
        _displayLink = nil;
    }
}

// ----------------------------------------------------------------------
#pragma mark - help method
// ----------------------------------------------------------------------

- (UILabel *)getTestLabel {
    UILabel *label          = [[UILabel alloc] init];
    label.textAlignment     = NSTextAlignmentCenter;
    label.font              = [UIFont systemFontOfSize:10.0f];
    label.numberOfLines     = 0;
    label.backgroundColor   = [UIColor redColor];
    label.textColor         = [UIColor whiteColor];
    return label;
}

- (CABasicAnimation *)getMoveAnimation {
    CABasicAnimation *ani   = [CABasicAnimation animation];
    ani.keyPath             = @"position.x";
    ani.fromValue           = @(35);
    ani.toValue             = @(self.width - 35);
    ani.duration            = Demo1AnimationDuration;
    return ani;
}

@end
