//
//  IOS12ICONAnimationButton1.m
//  Demo
//
//  Created by 朱超鹏 on 2018/7/19.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "IOS12ICONAnimationButton1.h"

#define kAnimation          @"kAnimation"
#define kAnimationStep1     @"kAnimationStep1"
#define kAnimationStep2     @"kAnimationStep2"

@interface IOS12ICONAnimationButton1 () <CAAnimationDelegate> {
    // 配置参数
    /// 线宽
    CGFloat _lineWidth;
    /// 线之间的间隙
    CGFloat _lineGap;
    
    // 计算参数
    CGPoint _arcCenter;
    /// 外圆半径
    CGFloat _radiusForOutsideArc;
    /// 中圆半径
    CGFloat _radiusForMiddleArc;
    /// 内圆半径
    CGFloat _radiusForInsideArc;
    /// 外圆开始的绘制终点值
    CGFloat _strokeEndBeginValueForOutsideArc;
    /// 中圆开始的绘制终点值
    CGFloat _strokeEndBeginValueForMiddleArc;
    /// 内圆开始的绘制终点值
    CGFloat _strokeEndBeginValueForInsideArc;
}

/// 外圆
@property (nonatomic, strong) CAShapeLayer *outsideArcLayer;
/// 中圆
@property (nonatomic, strong) CAShapeLayer *middleArcLayer;
/// 内圆
@property (nonatomic, strong) CAShapeLayer *insideArcLayer;

/// 是否正在执行动画
@property (nonatomic, assign, getter=isAnimating) BOOL animating;

@end

@implementation IOS12ICONAnimationButton1

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.layer addSublayer:self.outsideArcLayer];
        [self.layer addSublayer:self.middleArcLayer];
        [self.layer addSublayer:self.insideArcLayer];
        
        // 初始化参数和layer
        [self update];
        
        // 添加点击事件
        [self addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    // 处理内存泄漏
    if (newSuperview == nil) {
        [self clearAllAnimation];
        self.animating = NO;
    }
}

#pragma mark - update

- (void)update {
    // 更新配置参数
    [self updateConfigurableParameters];
    
    // 设置path
    [self updatePath];
    
    // 设置layer的属性
    [self updateLayer];
}

- (void)updateConfigurableParameters {
    // 设定条件：线宽 = 4 * 线边缘间距，中心白圈的直径 = 线宽。得出线边缘间距为self.height / 2 / 16
    // 但是线间距(_lineGap)实际用于计算时用的是线的中心间距，二不是线的边缘间距，所以要加上线宽(_lineWidth)
    _lineWidth  = (self.height / 2 / 16) * 4;
    _lineGap    = (self.height / 2 / 16) + _lineWidth;
    
    _arcCenter              = CGPointMake(self.width / 2, self.height / 2);
    _radiusForOutsideArc    = self.height / 2 - _lineWidth / 2;
    _radiusForMiddleArc     = _radiusForOutsideArc - _lineGap;
    _radiusForInsideArc     = _radiusForMiddleArc - _lineGap;
    _strokeEndBeginValueForOutsideArc   = OnePixel/(2 * M_PI *_radiusForOutsideArc);
    _strokeEndBeginValueForMiddleArc    = OnePixel/(2 * M_PI *_radiusForMiddleArc);
    _strokeEndBeginValueForInsideArc    = OnePixel/(2 * M_PI *_radiusForInsideArc);
}

- (void)updatePath {
    self.outsideArcLayer.path   = [self outsideArcLayerPath].CGPath;
    self.middleArcLayer.path    = [self middleArcLayerPath].CGPath;
    self.insideArcLayer.path    = [self insideArcLayerPath].CGPath;
}

- (void)updateLayer {
    self.outsideArcLayer.frame      = self.bounds;
    self.outsideArcLayer.lineWidth  = _lineWidth;
    self.outsideArcLayer.strokeEnd  = _strokeEndBeginValueForOutsideArc;
    
    self.middleArcLayer.frame       = self.bounds;
    self.middleArcLayer.lineWidth   = _lineWidth;
    self.middleArcLayer.strokeEnd   = _strokeEndBeginValueForMiddleArc;
    
    self.insideArcLayer.frame       = self.bounds;
    self.insideArcLayer.lineWidth   = _lineWidth;
    self.insideArcLayer.strokeEnd   = _strokeEndBeginValueForInsideArc;
}

#pragma mark - path

- (UIBezierPath *)outsideArcLayerPath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(self.width / 2, _lineWidth / 2)];
    [path addArcWithCenter:_arcCenter radius:_radiusForOutsideArc startAngle:-M_PI_2 endAngle:-M_PI_2+2*M_PI clockwise:YES];
    return path;
}

- (UIBezierPath *)middleArcLayerPath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(self.width / 2, _lineWidth / 2 + _lineGap)];
    [path addArcWithCenter:_arcCenter radius:_radiusForMiddleArc startAngle:-M_PI_2 endAngle:-M_PI_2+2*M_PI clockwise:YES];
    return path;
}

- (UIBezierPath *)insideArcLayerPath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(self.width / 2, _lineWidth / 2 + 2 * _lineGap)];
    [path addArcWithCenter:_arcCenter radius:_radiusForInsideArc startAngle:-M_PI_2 endAngle:M_PI * 3/2 clockwise:YES];
    return path;
}

#pragma mark - event response

- (void)click {
    if (!self.animating) {
        [self startAnimation];
    } else {
        [self stopAnimation];
    }
}

#pragma mark - animation

/**
 开始动画
 */
- (void)startAnimation {
    if (self.isAnimating) {
        return;
    }
    self.animating = YES;
    [self startAnimationStep1];
}

/**
 停止动画
 */
- (void)stopAnimation {
    if (self.isAnimating) {
        [self clearAllAnimation];
        self.animating = NO;
    }
}

/**
 开始第一步动画
 */
- (void)startAnimationStep1 {
    CGFloat duration = 0.7;
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.7 :0 :0 :0.3];
    
    {
        CABasicAnimation *strokeEndAnimation = [self getStrokeEndAnimation:duration fromValue:self->_strokeEndBeginValueForOutsideArc toValue:1];
        CABasicAnimation *rotationAnimation = [self getRotationAnimation:duration timingFunction:timingFunction];
        CAAnimationGroup *group     = [self getAnimationGroup:duration];
        group.animations            = @[strokeEndAnimation, rotationAnimation];
        
        [self addAnimation:group forLayer:self.outsideArcLayer];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CABasicAnimation *strokeEndAnimation = [self getStrokeEndAnimation:duration fromValue:self->_strokeEndBeginValueForMiddleArc toValue:1];
        CABasicAnimation *rotationAnimation = [self getRotationAnimation:duration timingFunction:timingFunction];
        CAAnimationGroup *group     = [self getAnimationGroup:duration];
        group.animations            = @[strokeEndAnimation, rotationAnimation];
        
        [self addAnimation:group forLayer:self.middleArcLayer];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CABasicAnimation *strokeEndAnimation = [self getStrokeEndAnimation:duration fromValue:self->_strokeEndBeginValueForInsideArc toValue:1];
        CABasicAnimation *rotationAnimation = [self getRotationAnimation:duration timingFunction:timingFunction];
        CAAnimationGroup *group     = [self getAnimationGroup:duration];
        group.animations            = @[strokeEndAnimation, rotationAnimation];
        [group setValue:kAnimationStep1 forKey:kAnimation];
        group.delegate = self;
        
        [self addAnimation:group forLayer:self.insideArcLayer];
    });
}

/**
 开始第二步动画
 */
- (void)startAnimationStep2 {
    CGFloat duration = 0.7;
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.7 :0 :0 :0.3];
    
    {
        CABasicAnimation *strokeStartAnimation = [self getStrokeStartAnimation:duration fromValue:0 toValue:1];
        CABasicAnimation *rotationAnimation = [self getRotationAnimation:duration timingFunction:timingFunction];
        CAAnimationGroup *group     = [self getAnimationGroup:duration];
        group.animations            = @[strokeStartAnimation, rotationAnimation];
        
        [self addAnimation:group forLayer:self.outsideArcLayer];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CABasicAnimation *strokeStartAnimation = [self getStrokeStartAnimation:duration fromValue:0 toValue:1];
        CABasicAnimation *rotationAnimation = [self getRotationAnimation:duration timingFunction:timingFunction];
        CAAnimationGroup *group     = [self getAnimationGroup:duration];
        group.animations            = @[strokeStartAnimation, rotationAnimation];
        
        [self addAnimation:group forLayer:self.middleArcLayer];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CABasicAnimation *strokeStartAnimation = [self getStrokeStartAnimation:duration fromValue:0 toValue:1];
        CABasicAnimation *rotationAnimation = [self getRotationAnimation:duration timingFunction:timingFunction];
        CAAnimationGroup *group     = [self getAnimationGroup:duration];
        group.animations            = @[strokeStartAnimation, rotationAnimation];
        [group setValue:kAnimationStep2 forKey:kAnimation];
        group.delegate = self;
        
        [self addAnimation:group forLayer:self.insideArcLayer];
    });
}

// 动画结束回调
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (!flag) {
        return;
    }
    
    NSString *key = [anim valueForKey:kAnimation];
    
    if ([key isEqualToString:kAnimationStep1]) {
        [self startAnimationStep2];
    } else if ([key isEqualToString:kAnimationStep2]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self clearAllAnimation];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self startAnimationStep1];
            });
        });
    }
}

/**
 清除所有动画
 */
- (void)clearAllAnimation {
    [self.outsideArcLayer removeAllAnimations];
    [self.middleArcLayer removeAllAnimations];
    [self.insideArcLayer removeAllAnimations];
}

#pragma mark <help method>

- (void)addAnimation:(CAAnimation *)animation forLayer:(CALayer *)layer {
    if (!self.animating) {
        return;
    }
    [layer addAnimation:animation forKey:nil];
}

- (CABasicAnimation *)getStrokeEndAnimation:(CGFloat)duration fromValue:(CGFloat)fromValue toValue:(CGFloat)toValue {
    CABasicAnimation *strokeEndAnimation    = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.duration             = duration;
    strokeEndAnimation.fromValue            = @(fromValue);
    strokeEndAnimation.toValue              = @(toValue);
    strokeEndAnimation.fillMode             = kCAFillModeForwards;
    strokeEndAnimation.removedOnCompletion  = NO;
    return strokeEndAnimation;
}

- (CABasicAnimation *)getStrokeStartAnimation:(CGFloat)duration fromValue:(CGFloat)fromValue toValue:(CGFloat)toValue {
    CABasicAnimation *strokeEndAnimation    = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeEndAnimation.duration             = duration;
    strokeEndAnimation.fromValue            = @(fromValue);
    strokeEndAnimation.toValue              = @(toValue);
    strokeEndAnimation.fillMode             = kCAFillModeForwards;
    strokeEndAnimation.removedOnCompletion  = NO;
    return strokeEndAnimation;
}

- (CABasicAnimation *)getRotationAnimation:(CGFloat)duration timingFunction:(id)timingFunction {
    CABasicAnimation *rotationAnimation     = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.duration              = duration;
    rotationAnimation.fromValue             = @(0);
    rotationAnimation.toValue               = @(2*M_PI);
    rotationAnimation.fillMode              = kCAFillModeForwards;
    rotationAnimation.removedOnCompletion   = NO;
    rotationAnimation.timingFunction        = timingFunction;
    return rotationAnimation;
}

- (CAAnimationGroup *)getAnimationGroup:(CGFloat)duration {
    CAAnimationGroup *group     = [CAAnimationGroup animation];
    group.duration              = duration;
    group.fillMode              = kCAFillModeForwards;
    group.removedOnCompletion   = NO;
    return group;
}

#pragma mark - setters

- (void)setFrame:(CGRect)frame {
    CGSize originSize = self.frame.size;
    [super setFrame:frame];
    if (!CGSizeEqualToSize(originSize, frame.size)) {
        [self update];
    }
}

#pragma mark - getters

- (CAShapeLayer *)outsideArcLayer {
    if (!_outsideArcLayer) {
        _outsideArcLayer                = [CAShapeLayer layer];
        _outsideArcLayer.fillColor      = nil;
        _outsideArcLayer.strokeColor    = [UIColor colorFromHexRGB:@"ff69b4"].CGColor;
        _outsideArcLayer.lineCap        = kCALineCapRound;
        _outsideArcLayer.lineJoin       = kCALineJoinRound;
    }
    return _outsideArcLayer;
}

- (CAShapeLayer *)middleArcLayer {
    if (!_middleArcLayer) {
        _middleArcLayer             = [CAShapeLayer layer];
        _middleArcLayer.fillColor   = nil;
        _middleArcLayer.strokeColor = [UIColor colorFromHexRGB:@"adff2f"].CGColor;
        _middleArcLayer.lineCap     = kCALineCapRound;
        _middleArcLayer.lineJoin    = kCALineJoinRound;
    }
    return _middleArcLayer;
}

- (CAShapeLayer *)insideArcLayer {
    if (!_insideArcLayer) {
        _insideArcLayer             = [CAShapeLayer layer];
        _insideArcLayer.fillColor   = nil;
        _insideArcLayer.strokeColor = [UIColor colorFromHexRGB:@"00bfff"].CGColor;
        _insideArcLayer.lineCap     = kCALineCapRound;
        _insideArcLayer.lineJoin    = kCALineJoinRound;
    }
    return _insideArcLayer;
}

@end
