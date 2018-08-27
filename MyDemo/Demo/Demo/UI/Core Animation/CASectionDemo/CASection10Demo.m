//
//  CASection10Demo.m
//  Demo
//
//  Created by 朱超鹏 on 2018/8/27.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "CASection10Demo.h"

@interface CASection10Demo ()

@property (nonatomic, strong) CALayer *colorLayer1;
@property (nonatomic, strong) CALayer *colorLayer2;

@end

@implementation CASection10Demo

// ----------------------------------------------------------------------
#pragma mark - demo
// ----------------------------------------------------------------------

#pragma mark 动画速度
- (void)demo1 {
    /*
     1.线性动画过程：
     velocity = change / time
     上面的等式假设了速度在整个动画过程中都是恒定不变的，对于这种恒定速度的动画我们称之为“线性步调”。
     
     2.非线性动画过程：
     但是比如像小车慢慢启动加速再到慢慢减速停车这样的动画，由于存在加速度，所以速度并非恒定的。
     我们用“缓冲函数”来描述这种速度非恒定的动画
     
     3.CAMediaTimingFunction类
     可以使用Core Animation中的CAMediaTimingFunction类，来定义缓冲函数
     其中的name参数可选值如下：
        kCAMediaTimingFunctionLinear        创建了一个线性的计时函数，同样也是CAAnimation的timingFunction属性为空时候的默认函数
        kCAMediaTimingFunctionEaseIn        创建了一个慢慢加速，然后动画结束时突然停止的过程
        kCAMediaTimingFunctionEaseOut       创建了一个全速开始，然后慢慢减速停止的过程
        kCAMediaTimingFunctionEaseInEaseOut 创建了一个慢慢加速然后再慢慢减速的过程
        kCAMediaTimingFunctionDefault       它和kCAMediaTimingFunctionEaseInEaseOut类似，但是加速的过程很快，要注意它并非默认值
     
     4.UIView的动画缓冲
     [UIView animateWithDuration:(NSTimeInterval) delay:(NSTimeInterval) options:(UIViewAnimationOptions) animations:^(void)animations completion:^(BOOL finished)completion]
     上面方法中的options参数可选值如下：
        UIViewAnimationOptionCurveEaseInOut 同kCAMediaTimingFunctionEaseInEaseOut，默认值
        UIViewAnimationOptionCurveEaseIn    同kCAMediaTimingFunctionEaseIn
        UIViewAnimationOptionCurveEaseOut   同kCAMediaTimingFunctionEaseOut
        UIViewAnimationOptionCurveLinear    同kCAMediaTimingFunctionLinear
     */
    
    // kCAMediaTimingFunctionLinear
    {
        CALayer *gearLayer      = [CALayer layer];
        gearLayer.frame         = CGRectMake(0, 0, 50, 50);
        gearLayer.contents      = (__bridge id _Nullable)([UIImage imageNamed:@"gear"].CGImage);
        gearLayer.cornerRadius  = 25;
        gearLayer.masksToBounds = YES;
        [self.layer addSublayer:gearLayer];
        
        float moveDuration      = 5;
        float moveLen           = self.width - gearLayer.width;
        float moveVelocity      = moveLen / moveDuration;
        float circumference     = gearLayer.width * 2 * M_PI;
        float rotateDuration    = circumference / moveVelocity;
        
        CABasicAnimation *rotateAni     = [CABasicAnimation animation];
        rotateAni.keyPath               = @"transform.rotation.z";
        rotateAni.fromValue             = @(0);
        rotateAni.toValue               = @(M_PI * 2);
        rotateAni.duration              = rotateDuration;
        rotateAni.repeatDuration        = moveDuration;
        rotateAni.fillMode              = kCAFillModeForwards;
        rotateAni.removedOnCompletion   = NO;
        [gearLayer addAnimation:rotateAni forKey:nil];
        
        CABasicAnimation *moveAni       = [CABasicAnimation animation];
        moveAni.keyPath                 = @"position.x";
        moveAni.fromValue               = @(gearLayer.position.x);
        moveAni.toValue                 = @(self.width - 25);
        moveAni.duration                = moveDuration;
        moveAni.fillMode                = kCAFillModeForwards;
        moveAni.removedOnCompletion     = NO;
        moveAni.timingFunction          = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [gearLayer addAnimation:moveAni forKey:nil];
    }
    
    // kCAMediaTimingFunctionEaseIn
    {
        CALayer *missileLayer       = [CALayer layer];
        missileLayer.frame          = CGRectMake(0, 60, 60, 20);
        missileLayer.contents       = (__bridge id _Nullable)[UIImage imageNamed:@"missile"].CGImage;
        [self.layer addSublayer:missileLayer];
        
        CGFloat duration            = 1;
        
        CABasicAnimation *moveAni   = [CABasicAnimation animation];
        moveAni.keyPath             = @"position.x";
        moveAni.duration            = duration;
        moveAni.fromValue           = @(missileLayer.position.x);
        moveAni.toValue             = @(self.width - missileLayer.width / 2);
        moveAni.removedOnCompletion = NO;
        moveAni.fillMode            = kCAFillModeForwards;
        moveAni.timingFunction      = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        [missileLayer addAnimation:moveAni forKey:nil];
        
        CALayer *redFireLayer       = [CALayer layer];
        redFireLayer.contents       = (__bridge id _Nullable)[UIImage imageNamed:@"redFire"].CGImage;
        redFireLayer.frame          = CGRectMake(0, missileLayer.height/2, 0, 0);
        [missileLayer addSublayer:redFireLayer];
        
        CABasicAnimation *sizeAni   = [CABasicAnimation animation];
        sizeAni.keyPath             = @"bounds";
        sizeAni.fromValue           = @(CGRectMake(0, 0, 0, 0));
        sizeAni.toValue             = @(CGRectMake(0, 0, 45, 30));
        sizeAni.duration            = duration;
        sizeAni.removedOnCompletion = NO;
        sizeAni.fillMode            = kCAFillModeForwards;
        [redFireLayer addAnimation:sizeAni forKey:nil];
        
        CABasicAnimation *positionAni   = [CABasicAnimation animation];
        positionAni.keyPath             = @"position";
        positionAni.fromValue           = @(CGPointMake(0, missileLayer.height/2));
        positionAni.toValue             = @(CGPointMake(-22.5, missileLayer.height/2));
        positionAni.duration            = duration;
        positionAni.removedOnCompletion = NO;
        positionAni.fillMode            = kCAFillModeForwards;
        [redFireLayer addAnimation:positionAni forKey:nil];
    }
    
    // kCAMediaTimingFunctionEaseOut
    {
        CALayer *billiardsLayer     = [CALayer layer];
        billiardsLayer.frame        = CGRectMake(0, 90, 50, 50);
        billiardsLayer.contents     = (__bridge id _Nullable)[UIImage imageNamed:@"billiards"].CGImage;
        [self.layer addSublayer:billiardsLayer];
        
        float moveDuration          = 1.5;
        float moveLen               = self.width - billiardsLayer.width;
        float moveVelocity          = moveLen / moveDuration;
        float circumference         = billiardsLayer.width * 2 * M_PI;
        float rotateDuration        = circumference / moveVelocity;
        
        CABasicAnimation *rotateAni = [CABasicAnimation animation];
        rotateAni.keyPath           = @"transform.rotation.z";
        rotateAni.fromValue         = @(0);
        rotateAni.toValue           = @(M_PI * 2);
        rotateAni.duration          = rotateDuration;
        rotateAni.repeatDuration    = moveDuration;
        rotateAni.fillMode          = kCAFillModeForwards;
        rotateAni.removedOnCompletion = NO;
        [billiardsLayer addAnimation:rotateAni forKey:nil];
        
        CABasicAnimation *moveAni   = [CABasicAnimation animation];
        moveAni.keyPath             = @"position.x";
        moveAni.duration            = moveDuration;
        moveAni.fromValue           = @(billiardsLayer.position.x);
        moveAni.toValue             = @(self.width - billiardsLayer.width / 2);
        moveAni.removedOnCompletion = NO;
        moveAni.fillMode            = kCAFillModeForwards;
        moveAni.timingFunction      = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        [billiardsLayer addAnimation:moveAni forKey:nil];
    }
    
    // kCAMediaTimingFunctionEaseInEaseOut
    {
        CALayer *carLayer          = [CALayer layer];
        carLayer.frame             = CGRectMake(0, 150, 50, 50);
        carLayer.contents          = (__bridge id _Nullable)[UIImage imageNamed:@"car"].CGImage;
        [self.layer addSublayer:carLayer];
        
        CABasicAnimation *moveAni   = [CABasicAnimation animation];
        moveAni.keyPath             = @"position.x";
        moveAni.duration            = 2;
        moveAni.fromValue           = @(carLayer.position.x);
        moveAni.toValue             = @(self.width - 25);
        moveAni.removedOnCompletion = NO;
        moveAni.fillMode            = kCAFillModeForwards;
        moveAni.timingFunction      = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [carLayer addAnimation:moveAni forKey:nil];
    }
    
    // kCAMediaTimingFunctionDefault
    {
        CALayer *carLayer          = [CALayer layer];
        carLayer.frame             = CGRectMake(0, 210, 50, 50);
        carLayer.contents          = (__bridge id _Nullable)[UIImage imageNamed:@"car"].CGImage;
        [self.layer addSublayer:carLayer];
        
        CABasicAnimation *moveAni   = [CABasicAnimation animation];
        moveAni.keyPath             = @"position.x";
        moveAni.duration            = 2;
        moveAni.fromValue           = @(carLayer.position.x);
        moveAni.toValue             = @(self.width - 25);
        moveAni.removedOnCompletion = NO;
        moveAni.fillMode            = kCAFillModeForwards;
        moveAni.timingFunction      = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        [carLayer addAnimation:moveAni forKey:nil];
    }
}

#pragma mark 关键帧动画的动画速度
- (void)demo2 {
    UIButton *button        = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame            = CGRectMake((self.width - 150)/2, 10, 150, 50);
    button.backgroundColor  = [UIColor redColor];
    [button setTitle:@"点击开始动画" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    self.colorLayer1        = ({
        CALayer *colorLayer = [CALayer layer];
        colorLayer.frame    = CGRectMake((self.width - 300)/3, 100, 150, 150);
        colorLayer.backgroundColor = [UIColor redColor].CGColor;
        colorLayer;
    });
    [self.layer addSublayer:self.colorLayer1];
    
    self.colorLayer2        = ({
        CALayer *colorLayer = [CALayer layer];
        colorLayer.frame    = CGRectMake((self.width - 300)/3*2 + 150, 100, 150, 150);
        colorLayer.backgroundColor = [UIColor redColor].CGColor;
        colorLayer;
    });
    [self.layer addSublayer:self.colorLayer2];
}

#pragma mark 自定义缓冲函数
- (void)demo3 {
    
}

// ----------------------------------------------------------------------
#pragma mark - event response
// ----------------------------------------------------------------------

- (void)click:(UIButton *)button {
    /*
     CAKeyframeAnimation有一个NSArray类型的timingFunctions属性，我们可以用它来对每次动画的步骤指定不同的计时函数。但是指定函数的个数一定要等于keyframes数组的元素个数减一，因为它是描述每一帧之间动画速度的函数。
     */
    {
        CAKeyframeAnimation *ani    = [CAKeyframeAnimation animation];
        ani.keyPath                 = @"backgroundColor";
        ani.values                  = @[(__bridge id)[UIColor blueColor].CGColor,
                                        (__bridge id)[UIColor greenColor].CGColor,
                                        (__bridge id)[UIColor redColor].CGColor,
                                        (__bridge id)[UIColor blueColor].CGColor];
        ani.duration                = 5;
        [self.colorLayer1 addAnimation:ani forKey:nil];
    }
    
    {
        CAKeyframeAnimation *ani    = [CAKeyframeAnimation animation];
        ani.keyPath                 = @"backgroundColor";
        ani.values                  = @[(__bridge id)[UIColor blueColor].CGColor,
                                        (__bridge id)[UIColor greenColor].CGColor,
                                        (__bridge id)[UIColor redColor].CGColor,
                                        (__bridge id)[UIColor blueColor].CGColor];
        ani.timingFunctions         = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        ani.duration                = 5;
        [self.colorLayer2 addAnimation:ani forKey:nil];
    }
}

@end
