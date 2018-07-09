//
//  AnimationButton2.m
//  Demo
//
//  Created by 朱超鹏 on 2018/7/6.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "AnimationButton2.h"

@interface AnimationButton2 () {
    
    // 配置参数
    CGFloat _lineWidth;
    CGFloat _lineLength;
    
    // 计算参数
    CGFloat _lineGap;
    CGFloat _lineLeft;
    CGFloat _lineTop;
}


@property (nonatomic, strong) CAShapeLayer *leftLineLayer;
@property (nonatomic, strong) CAShapeLayer *rightLineLayer;

@end

@implementation AnimationButton2

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.layer addSublayer:self.leftLineLayer];
        [self.layer addSublayer:self.rightLineLayer];
        
        // 初始化参数和layer
        [self update];
        
        // 添加点击事件
        [self addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark - update

- (void)update {
    // 更新配置参数
    [self updateConfigurableParameters];
    
    // 更新path
    self.leftLineLayer.path         = [self leftLinePath].CGPath;
    self.rightLineLayer.path        = [self rightLinePath].CGPath;
    
    self.leftLineLayer.fillColor    = nil;
    self.leftLineLayer.strokeColor  = [UIColor blackColor].CGColor;
    self.leftLineLayer.lineWidth    = _lineWidth;
    self.leftLineLayer.lineCap      = kCALineCapRound;
    
    self.rightLineLayer.fillColor    = nil;
    self.rightLineLayer.strokeColor  = [UIColor blackColor].CGColor;
    self.rightLineLayer.lineWidth    = _lineWidth;
    self.rightLineLayer.lineCap      = kCALineCapRound;
}

- (void)updateConfigurableParameters {
    _lineWidth  = 5;
    _lineLength = self.height * 0.4;
    _lineGap    = _lineLength / sqrt(3);
    _lineLeft   = (self.width - _lineGap) / 2;
    _lineTop    = (self.height - _lineLength) / 2;
}

#pragma mark - private

- (UIBezierPath *)leftLinePath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(_lineLeft, _lineTop)];
    [path addLineToPoint:CGPointMake(_lineLeft, _lineTop + _lineLength)];
    return path;
}

- (UIBezierPath *)rightLinePath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(_lineLeft + _lineGap, _lineTop)];
    [path addLineToPoint:CGPointMake(_lineLeft + _lineGap, _lineTop + _lineLength)];
    return path;
}

#pragma mark - animation

- (void)startAnimation {
    
    CGFloat decrement = 0.4*self.height - _lineTop;
    
    // top ~ top+l
    // top - d/2 ~ top - d/2 + l-d
    
    {
        // 左线缩放动画
        UIBezierPath *leftLinePath = [UIBezierPath bezierPath];
        [leftLinePath moveToPoint:CGPointMake(_lineLeft, _lineTop + decrement)];
        [leftLinePath addLineToPoint:CGPointMake(_lineLeft, _lineTop + _lineLength)];
        self.leftLineLayer.path = leftLinePath.CGPath;
        
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        scaleAnimation.duration = 0.2;
        scaleAnimation.fillMode = kCAFillModeForwards;
        scaleAnimation.removedOnCompletion = NO;
        scaleAnimation.beginTime = 0;
        // 左线移动动画
        CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        moveAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, -decrement / 2, 0)];
        moveAnimation.duration = 0.2;
        moveAnimation.fillMode = kCAFillModeForwards;
        moveAnimation.removedOnCompletion = NO;
        moveAnimation.beginTime = 0.2f;
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.animations = @[scaleAnimation, moveAnimation];
        group.fillMode = kCAFillModeForwards;
        group.removedOnCompletion = NO;
        group.duration = 0.4;
        [self.leftLineLayer addAnimation:group forKey:nil];
    }
    
    {
        // 右线移动动画
        CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        moveAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, -decrement / 2, 0)];
        moveAnimation.duration = 2;
        moveAnimation.fillMode = kCAFillModeForwards;
        moveAnimation.removedOnCompletion = NO;
        moveAnimation.beginTime = 0;
        
        // 右线缩放动画
        UIBezierPath *rightLinePath = [UIBezierPath bezierPath];
        [rightLinePath moveToPoint:CGPointMake(_lineLeft + _lineGap, _lineTop + decrement)];
        [rightLinePath addLineToPoint:CGPointMake(_lineLeft + _lineGap, _lineTop + _lineLength)];
        self.rightLineLayer.path = rightLinePath.CGPath;
        
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        scaleAnimation.duration = 2;
        scaleAnimation.fillMode = kCAFillModeForwards;
        scaleAnimation.removedOnCompletion = NO;
        scaleAnimation.beginTime = 2;
        
        CAAnimationGroup *group2 = [CAAnimationGroup animation];
        group2.animations = @[moveAnimation, scaleAnimation];
        group2.fillMode = kCAFillModeForwards;
        group2.removedOnCompletion = NO;
        group2.duration = 4;
        [self.rightLineLayer addAnimation:group2 forKey:nil];
    }
}

#pragma mark - event response

- (void)click {
    [self startAnimation];
}

#pragma mark - setters

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
}

#pragma mark - getters

- (CAShapeLayer *)leftLineLayer {
    if (!_leftLineLayer) {
        _leftLineLayer = [CAShapeLayer layer];
    }
    return _leftLineLayer;
}

- (CAShapeLayer *)rightLineLayer {
    if (!_rightLineLayer) {
        _rightLineLayer = [CAShapeLayer layer];
    }
    return _rightLineLayer;
}

@end
