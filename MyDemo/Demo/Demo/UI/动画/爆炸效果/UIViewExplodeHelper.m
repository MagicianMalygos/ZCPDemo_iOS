//
//  UIViewExplodeHelper.m
//  Demo
//
//  Created by 朱超鹏 on 2018/6/25.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "UIViewExplodeHelper.h"
#import "UIImage+ExplodeHelpMethod.h"
#import "UIView+Explode.h"

#define kAnimationTag                   @"kAnimationTag"
#define kShakeAnimationTag              @"kShakeAnimationTag"
#define kScaleAndOpacityAnimationTag    @"kScaleAndOpacityAnimationTag"
#define kParticleAnimationTag           @"kParticleAnimationTag"

#define ShakeAnimationDuration          0.5
#define ShakeNumber                     10
#define ScaleAndOpacityAnimationDuration 0.1
#define ParticleAnimationDuration       (0.5 + RANDOMF(0, 0.5))

@interface UIViewExplodeHelper () <CAAnimationDelegate>

@property (nonatomic, strong) NSMutableArray *particleArray;
@property (nonatomic, strong) UIImage *snapshot;
@property (nonatomic, assign) CGSize originViewSize;

@end

@implementation UIViewExplodeHelper

#pragma mark - public

- (void)explode {
    if (self.explodeState != UIViewExplodeStateInitial ||
        self.view.superview == nil) {
        return;
    }
    self.explodeState = UIViewExplodeStateExploding;
    
    [self setup];
    [self startViewShakeAnimation];
}

- (void)recover {
    for (CALayer *particleLayer in self.particleArray) {
        [particleLayer removeAllAnimations];
    }
    [self removeAllParticle];
    [self.view.layer removeAllAnimations];
    self.explodeState = UIViewExplodeStateInitial;
}

#pragma mark - private

- (void)setup {
    // 生成快照
    self.snapshot           = [self makeSnapshotWithScaleSize:CGSizeMake(45, 45)];
    self.originViewSize     = self.view.frame.size;
    
    // 生成粒子
    [self removeAllParticle];
    NSInteger particleLineNumber            = 15; // 行数
    NSInteger particleNumberOfOneLine       = 15; // 一行数量
    for (int i = 0; i < particleLineNumber; i++) {
        for (int j = 0; j < particleNumberOfOneLine; j++) {
            @autoreleasepool {
                CGFloat side                    = MIN(self.view.width, self.view.height) / particleNumberOfOneLine;
                UIColor *pixelColor             = [self.snapshot getPixelColorWithLocation:CGPointMake(i*2, j*2)];
                CALayer *particleLayer          = [CALayer layer];
                particleLayer.cornerRadius      = side / 2;
                particleLayer.frame             = CGRectMake(0, 0, side, side);
                particleLayer.center            = self.view.layer.center;
                particleLayer.backgroundColor   = pixelColor.CGColor;
                particleLayer.opacity           = 0;
                [self.particleArray addObject:particleLayer];
            }
        }
    }
}

- (void)startViewShakeAnimation {
    // 震动
    CAKeyframeAnimation *shakeXAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    CAKeyframeAnimation *shakeYAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    shakeXAnimation.duration = ShakeAnimationDuration;
    shakeYAnimation.duration = ShakeAnimationDuration;
    NSMutableArray *shakeXAnimationValues = [NSMutableArray array];
    NSMutableArray *shakeYAnimationValues = [NSMutableArray array];
    for (int i = 0; i < ShakeNumber; i++) {
        [shakeXAnimationValues addObject:[self makeRandomShakeValue:self.view.layer.position.x]];
        [shakeYAnimationValues addObject:[self makeRandomShakeValue:self.view.layer.position.y]];
    }
    shakeXAnimation.values = shakeXAnimationValues;
    shakeYAnimation.values = shakeYAnimationValues;
    
    CAAnimationGroup *shakeGroup    = [CAAnimationGroup animation];
    shakeGroup.animations           = @[shakeXAnimation, shakeYAnimation];
    shakeGroup.duration             = ShakeAnimationDuration;
    shakeGroup.delegate             = self;
    [shakeGroup setValue:kShakeAnimationTag forKey:kAnimationTag];
    [self.view.layer addAnimation:shakeGroup forKey:nil];
}

- (void)startViewScaleAndOpacityAnimation {
    // 缩放
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.toValue      = @(0.01);
    scaleAnimation.duration     = ScaleAndOpacityAnimationDuration;
    // 透明
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue  = @(1);
    opacityAnimation.toValue    = @(0);
    opacityAnimation.duration   = ScaleAndOpacityAnimationDuration;
    
    CAAnimationGroup *scaleAndOpacityGroup      = [CAAnimationGroup animation];
    scaleAndOpacityGroup.animations             = @[scaleAnimation, opacityAnimation];
    scaleAndOpacityGroup.duration               = ScaleAndOpacityAnimationDuration;
    scaleAndOpacityGroup.fillMode               = kCAFillModeForwards;
    scaleAndOpacityGroup.removedOnCompletion    = NO;
    scaleAndOpacityGroup.delegate               = self;
    [scaleAndOpacityGroup setValue:kScaleAndOpacityAnimationTag forKey:kAnimationTag];
    
    [self.view.layer addAnimation:scaleAndOpacityGroup forKey:nil];
}

- (void)startParticleAnimation {
    // 粒子爆炸
    int flag = 0;
    for (CALayer *particleLayer in self.particleArray) {
        [self.view.layer.superlayer addSublayer:particleLayer];
        particleLayer.opacity   = 1;
        
        CAKeyframeAnimation *moveAnimation  = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        moveAnimation.path                  = [self makeRandomParticlePath:particleLayer].CGPath;
        moveAnimation.removedOnCompletion   = false;
        moveAnimation.fillMode              = kCAFillModeForwards;
        moveAnimation.timingFunction        = [self makeParticleMoveAnimationTimingFunction];
        moveAnimation.duration              = ParticleAnimationDuration;
        
        CABasicAnimation *scaleAnimation    = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.toValue              = @(RANDOMF(0.8, 1));
        scaleAnimation.duration             = moveAnimation.duration;
        scaleAnimation.removedOnCompletion  = NO;
        scaleAnimation.fillMode             = kCAFillModeForwards;
        
        CABasicAnimation *opacityAnimation  = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.fromValue          = @(1);
        opacityAnimation.toValue            = @(0);
        opacityAnimation.duration           = moveAnimation.duration;
        opacityAnimation.removedOnCompletion = NO;
        opacityAnimation.fillMode           = kCAFillModeForwards;
        opacityAnimation.timingFunction     = [CAMediaTimingFunction functionWithControlPoints:0.38 :0.033333 :0.963 :0.26];
        
        CAAnimationGroup *particleAnimationGroup    = [CAAnimationGroup animation];
        particleAnimationGroup.animations           = @[moveAnimation, scaleAnimation, opacityAnimation];
        particleAnimationGroup.duration             = 1;
        
        if (flag == 0) {
            particleAnimationGroup.delegate = self;
            [particleAnimationGroup setValue:kParticleAnimationTag forKey:kAnimationTag];
            flag = 1;
        }
        [particleLayer addAnimation:particleAnimationGroup forKey:nil];
    }
}

- (void)removeAllParticle {
    if (self.particleArray.count > 0) {
        for (CALayer *layer in self.particleArray) {
            [layer removeFromSuperlayer];
        }
        [self.particleArray removeAllObjects];
    }
}

#pragma mark - tool

- (NSNumber *)makeRandomShakeValue:(CGFloat)p {
    CGFloat offset = 10;
    CGFloat random = RANDOM(-100, 100) / 100.0;
    return @(p + offset * random);
}

- (UIImage *)makeSnapshotWithScaleSize:(CGSize)scaleSize {
    UIGraphicsBeginImageContext(self.view.layer.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(scaleSize);
    [image drawInRect:CGRectMake(0, 0, scaleSize.width, scaleSize.height)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIBezierPath *)makeRandomParticlePath:(CALayer *)layer {
    
    CGPoint startPoint      = CGPointZero;
    CGPoint endPoint        = CGPointZero;
    CGPoint controlPoint    = CGPointZero;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:layer.position];
    startPoint = layer.position;
    
    if (self.explodeEffect == UIViewExplodeEffectGravity) {
        //重力爆炸轨迹
        
        // x: x-vw ~ x+vw
        // y: y+0.25*vh ~ y+vh
        CGFloat endPointX = RANDOMF(layer.position.x - self.originViewSize.width, layer.position.x + self.originViewSize.width);
        CGFloat endPointY = RANDOMF(layer.position.y + 0.25 * self.originViewSize.height, layer.position.y + self.originViewSize.height);
        endPoint = CGPointMake(endPointX, endPointY);
    
        CGFloat controlPointX = layer.position.x + (endPointX - layer.position.x) / 2;
        CGFloat controlPointY = layer.position.y - RANDOMF(0.2 * self.originViewSize.height, self.originViewSize.height);
        controlPoint = CGPointMake(controlPointX, controlPointY);
        [path addQuadCurveToPoint:endPoint controlPoint:controlPoint];
        
    } else if (self.explodeEffect == UIViewExplodeEffectShockWave) {
        // 冲击波爆炸轨迹
        
        // x: x-vw ~ x+vw
        // y: y-vw ~ y+vw
        CGFloat r = self.originViewSize.width;
        CGFloat endPointX = RANDOMF(startPoint.x - r, startPoint.x + r);
        CGFloat endPointY = RANDOMF(startPoint.y - r, startPoint.y + r);
        endPoint = CGPointMake(endPointX, endPointY);
        [path addLineToPoint:endPoint];
    }
    return path;
}

- (CAMediaTimingFunction *)makeParticleMoveAnimationTimingFunction {
    CAMediaTimingFunction *timingFunction = nil;
    if (self.explodeEffect == UIViewExplodeEffectGravity) {
        [CAMediaTimingFunction functionWithControlPoints:0.24 :0.35 :0.4 :0.15];
    } else if (self.explodeEffect == UIViewExplodeEffectShockWave) {
        [CAMediaTimingFunction functionWithControlPoints:0.4 :0.35 :0.24 :0.15];
    }
    return timingFunction;
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.explodeState != UIViewExplodeStateExploding) {
        return;
    }
    NSString *key = [anim valueForKey:kAnimationTag];
    
    if ([key isEqualToString:kShakeAnimationTag]) {
        [self startViewScaleAndOpacityAnimation];
    } else if ([key isEqualToString:kScaleAndOpacityAnimationTag]) {
        [self startParticleAnimation];
    } else if ([key isEqualToString:kParticleAnimationTag]) {
        [self removeAllParticle];
        self.explodeState = UIViewExplodeStateExploded;
        
        // 爆炸结束回调
        if (self.view.explodeDelegate && [self.view.explodeDelegate respondsToSelector:@selector(didFinishExplode:)]) {
            [self.view.explodeDelegate didFinishExplode:self.view];
        }
    }
}

#pragma mark - getters & setters

- (NSMutableArray *)particleArray {
    if (!_particleArray) {
        _particleArray = [NSMutableArray array];
    }
    return _particleArray;
}

@end
