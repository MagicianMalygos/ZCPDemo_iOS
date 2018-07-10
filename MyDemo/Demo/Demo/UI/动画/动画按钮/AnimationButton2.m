//
//  AnimationButton2.m
//  Demo
//
//  Created by 朱超鹏 on 2018/7/6.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "AnimationButton2.h"

#define kAnimation                  @"kAnimation"
#define kLineAnimation              @"kLineAnimation"
#define kTriangleAnimation          @"kTriangleAnimation"
#define kInverseLineAnimation       @"kInverseLineAnimation"
#define kInverseTriangleAnimation   @"kInverseTriangleAnimation"

@interface AnimationButton2 () <CAAnimationDelegate> {
    
    // 配置参数
    /// 线宽
    CGFloat _lineWidth;
    /// 线长
    CGFloat _lineLength;
    
    // 计算参数
    /// 竖线的间距
    CGFloat _lineGap;
    /// 竖线的左边距
    CGFloat _lineLeft;
    /// 竖线的顶边距
    CGFloat _lineTop;
    /// 竖线的缩放量
    CGFloat _zoom;
    /// 竖线的缩放值
    CGFloat _zoomValue;
    /// 竖线缩放后的顶边距
    CGFloat _zoomLineTop;
}

@property (nonatomic, strong) CAShapeLayer *leftLineLayer;
@property (nonatomic, strong) CAShapeLayer *rightLineLayer;
@property (nonatomic, strong) CAShapeLayer *triangleLayer;
@property (nonatomic, strong) CAShapeLayer *arcLayer;

@property (nonatomic, assign, getter=isAnimating) BOOL animating;
@property (nonatomic, assign, getter=isPlaying) BOOL playing;

@end

@implementation AnimationButton2

@synthesize lineColor = _lineColor;

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.layer addSublayer:self.leftLineLayer];
        [self.layer addSublayer:self.rightLineLayer];
        [self.layer addSublayer:self.triangleLayer];
        [self.layer addSublayer:self.arcLayer];
        
        self.playing = YES;
        
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
    [self updatePath];
    
    // 设置layer
    [self updateLayer];
}

/**
 更新配置参数
 */
- (void)updateConfigurableParameters {
    _lineWidth      = 6;
    _lineLength     = self.height * 0.4;
    _lineGap        = _lineLength / sqrt(3);
    _lineLeft       = (self.width - _lineGap) / 2;
    _lineTop        = (self.height - _lineLength) / 2;
    _zoom           = 0.3;
    _zoomValue      = _zoom * _lineLength;
    _zoomLineTop    = _lineTop + _zoomValue / 2;
}

/**
 更新path
 */
- (void)updatePath {
    self.leftLineLayer.path     = [self leftLinePath].CGPath;
    self.rightLineLayer.path    = [self rightLinePath].CGPath;
    self.triangleLayer.path     = [self trianglePath].CGPath;
    self.arcLayer.path          = [self arcPath].CGPath;
}

/**
 更新layer
 */
- (void)updateLayer {
    self.leftLineLayer.fillColor    = nil;
    self.leftLineLayer.strokeColor  = self.lineColor.CGColor;
    self.leftLineLayer.lineWidth    = _lineWidth;
    self.leftLineLayer.lineCap      = kCALineCapRound;
    self.leftLineLayer.lineJoin     = kCALineJoinRound;
    
    self.rightLineLayer.fillColor   = nil;
    self.rightLineLayer.strokeColor = self.lineColor.CGColor;
    self.rightLineLayer.lineWidth   = _lineWidth;
    self.rightLineLayer.lineCap     = kCALineCapRound;
    self.rightLineLayer.lineJoin    = kCALineJoinRound;
    
    self.triangleLayer.fillColor    = nil;
    self.triangleLayer.strokeColor  = self.lineColor.CGColor;
    self.triangleLayer.lineWidth    = _lineWidth;
    self.triangleLayer.lineCap      = kCALineCapRound;
    self.triangleLayer.lineJoin     = kCALineJoinRound;
    self.triangleLayer.strokeEnd    = 0;
    
    self.arcLayer.fillColor         = nil;
    self.arcLayer.strokeColor       = self.lineColor.CGColor;
    self.arcLayer.lineWidth         = _lineWidth;
    self.arcLayer.lineCap           = kCALineCapRound;
    self.arcLayer.lineJoin          = kCALineJoinRound;
    self.arcLayer.strokeEnd         = 0;
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

- (UIBezierPath *)trianglePath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(_lineLeft, _zoomLineTop)];
    [path addLineToPoint:CGPointMake(_lineLeft, _lineTop)];
    [path addLineToPoint:CGPointMake(_lineLeft + sqrt(3)/2*_lineLength, _lineTop + _lineLength / 2)];
    [path addLineToPoint:CGPointMake(_lineLeft, _lineTop + _lineLength)];
    [path addLineToPoint:CGPointMake(_lineLeft, _zoomLineTop)];
    return path;
}

- (UIBezierPath *)arcPath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint center = CGPointMake(_lineLeft + _lineGap/2, _lineTop + _lineLength - _zoomValue / 2);
    [path moveToPoint:CGPointMake(_lineLeft + _lineGap, _lineTop + _lineLength - _zoomValue / 2)];
    [path addArcWithCenter:center radius:_lineGap/2 startAngle:0 endAngle:M_PI clockwise:YES];
    return path;
}

#pragma mark - animation

- (void)startAnimation {
    if (self.animating) {
        return;
    }
    self.animating = YES;
    
    if (self.isPlaying) {
        [self startLineAnimation];
    } else {
        [self startInverseTriangleAnimation];
    }
    
    self.playing = !self.isPlaying;
}

- (void)startLineAnimation {
    CGFloat duration = 0.1;
    
    {
        // 左线缩短动画
        CABasicAnimation *shortenAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        shortenAnimation.beginTime = 0;
        shortenAnimation.duration = duration;
        shortenAnimation.fillMode = kCAFillModeForwards;
        shortenAnimation.removedOnCompletion = NO;
        shortenAnimation.fromValue = @(0);
        shortenAnimation.toValue = @(_zoom);
        
        // 左线移动动画
        CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        moveAnimation.beginTime = duration;
        moveAnimation.duration = duration;
        moveAnimation.fillMode = kCAFillModeForwards;
        moveAnimation.removedOnCompletion = NO;
        moveAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, -_zoomValue / 2, 0)];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.animations = @[shortenAnimation, moveAnimation];
        group.fillMode = kCAFillModeForwards;
        group.removedOnCompletion = NO;
        group.duration = duration + duration;
        [group setValue:kLineAnimation forKey:kAnimation];
        group.delegate = self;
        
        [self.leftLineLayer addAnimation:group forKey:nil];
    }
    
    {
        // 右线移动动画
        CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        moveAnimation.beginTime = 0;
        moveAnimation.duration = duration;
        moveAnimation.fillMode = kCAFillModeForwards;
        moveAnimation.removedOnCompletion = NO;
        moveAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, -_zoomValue / 2, 0)];
        
        // 右线缩短动画
        CABasicAnimation *shortenAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        shortenAnimation.beginTime = duration;
        shortenAnimation.duration = duration;
        shortenAnimation.fillMode = kCAFillModeForwards;
        shortenAnimation.removedOnCompletion = NO;
        shortenAnimation.toValue = @(_zoom);
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.animations = @[moveAnimation, shortenAnimation];
        group.fillMode = kCAFillModeForwards;
        group.removedOnCompletion = NO;
        group.duration = duration + duration;
        [self.rightLineLayer addAnimation:group forKey:nil];
    }
}

- (void)startTriangleAnimation {
    CGFloat duration = 0.15;
    CGFloat triangleDuration = duration * 3 + 0.1;
    
    // 三角动画
    CABasicAnimation *triangleAnimation     = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    triangleAnimation.duration              = triangleDuration;
    triangleAnimation.toValue               = @(1);
    triangleAnimation.fillMode              = kCAFillModeForwards;
    triangleAnimation.removedOnCompletion   = NO;
    triangleAnimation.delegate              = self;
    [triangleAnimation setValue:kTriangleAnimation forKey:kAnimation];
    [self.triangleLayer addAnimation:triangleAnimation forKey:nil];
    
    // 右线缩短动画
    CABasicAnimation *shortenAnimation      = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    shortenAnimation.duration               = duration;
    shortenAnimation.toValue                = @(1.001); /*如果为1 动画执行后会留下一个点*/
    shortenAnimation.fillMode               = kCAFillModeForwards;
    shortenAnimation.removedOnCompletion    = NO;
    [self.rightLineLayer addAnimation:shortenAnimation forKey:nil];
    
    // 圆弧线动画
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.duration     = duration;
    strokeEndAnimation.fromValue    = @(0);
    strokeEndAnimation.toValue      = @(1);
    strokeEndAnimation.fillMode     = kCAFillModeForwards;
    strokeEndAnimation.removedOnCompletion = NO;
    [self.arcLayer addAnimation:strokeEndAnimation forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        strokeStartAnimation.duration   = duration;
        strokeStartAnimation.fromValue  = @(0);
        strokeStartAnimation.toValue    = @(1);
        strokeStartAnimation.fillMode   = kCAFillModeForwards;
        strokeStartAnimation.removedOnCompletion = NO;
        [self.arcLayer addAnimation:strokeStartAnimation forKey:nil];
    });
    
    // 左线缩短动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration*2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CABasicAnimation *shortenAnimation      = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        shortenAnimation.duration               = duration;
        shortenAnimation.toValue                = @(0);
        shortenAnimation.fillMode               = kCAFillModeForwards;
        shortenAnimation.removedOnCompletion    = NO;
        [self.leftLineLayer addAnimation:shortenAnimation forKey:nil];
    });
}

- (void)startInverseTriangleAnimation {
    CGFloat duration = 0.15;
    CGFloat triangleDuration = duration * 3 - 0.1;
    
    // 三角动画
    CABasicAnimation *triangleAnimation     = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    triangleAnimation.duration              = triangleDuration;
    triangleAnimation.toValue               = @(-0.01);
    triangleAnimation.fillMode              = kCAFillModeForwards;
    triangleAnimation.removedOnCompletion   = NO;
    [self.triangleLayer addAnimation:triangleAnimation forKey:nil];
    
    // 左线伸长动画
    CABasicAnimation *stretchAnimation      = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    stretchAnimation.duration               = duration;
    stretchAnimation.toValue                = @(1);
    stretchAnimation.fillMode               = kCAFillModeForwards;
    stretchAnimation.removedOnCompletion    = NO;
    [self.leftLineLayer addAnimation:stretchAnimation forKey:nil];
    
    // 圆弧动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        strokeStartAnimation.duration   = duration;
        strokeStartAnimation.fromValue  = @(1);
        strokeStartAnimation.toValue    = @(0);
        strokeStartAnimation.fillMode   = kCAFillModeForwards;
        strokeStartAnimation.removedOnCompletion = NO;
        [self.arcLayer addAnimation:strokeStartAnimation forKey:nil];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration*2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        strokeEndAnimation.duration     = duration;
        strokeEndAnimation.fromValue    = @(1);
        strokeEndAnimation.toValue      = @(0);
        strokeEndAnimation.fillMode     = kCAFillModeForwards;
        strokeEndAnimation.removedOnCompletion = NO;
        [self.arcLayer addAnimation:strokeEndAnimation forKey:nil];
        
        // 右线伸长动画
        CABasicAnimation *stretchAnimation      = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        stretchAnimation.duration               = duration;
        stretchAnimation.toValue                = @(self->_zoom);
        stretchAnimation.fillMode               = kCAFillModeForwards;
        stretchAnimation.removedOnCompletion    = NO;
        stretchAnimation.delegate               = self;
        [stretchAnimation setValue:kInverseTriangleAnimation forKey:kAnimation];
        [self.rightLineLayer addAnimation:stretchAnimation forKey:nil];
    });
}

- (void)startInverseLineAnimation {
    CGFloat duration = 0.1;
    
    {
        // 左线移动动画
        CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        moveAnimation.beginTime = 0;
        moveAnimation.duration = duration;
        moveAnimation.fillMode = kCAFillModeForwards;
        moveAnimation.removedOnCompletion = NO;
        moveAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        
        // 左线伸长动画
        CABasicAnimation *stretchAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        stretchAnimation.beginTime = duration;
        stretchAnimation.duration = duration;
        stretchAnimation.fillMode = kCAFillModeForwards;
        stretchAnimation.removedOnCompletion = NO;
        stretchAnimation.fromValue = @(_zoom);
        stretchAnimation.toValue = @(0);
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.animations = @[moveAnimation, stretchAnimation];
        group.fillMode = kCAFillModeForwards;
        group.removedOnCompletion = NO;
        group.duration = duration + duration;
        [group setValue:kInverseLineAnimation forKey:kAnimation];
        group.delegate = self;
        
        [self.leftLineLayer addAnimation:group forKey:nil];
    }
    
    {
        // 右线伸长动画
        CABasicAnimation *stretchAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        stretchAnimation.beginTime = 0;
        stretchAnimation.duration = duration;
        stretchAnimation.fillMode = kCAFillModeForwards;
        stretchAnimation.removedOnCompletion = NO;
        stretchAnimation.fromValue = @(_zoom);
        stretchAnimation.toValue = @(0);
        
        // 右线移动动画
        CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        moveAnimation.beginTime = duration;
        moveAnimation.duration = duration;
        moveAnimation.fillMode = kCAFillModeForwards;
        moveAnimation.removedOnCompletion = NO;
        moveAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.animations = @[stretchAnimation, moveAnimation];
        group.fillMode = kCAFillModeForwards;
        group.removedOnCompletion = NO;
        group.duration = duration + duration;
        [self.rightLineLayer addAnimation:group forKey:nil];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSString *key = [anim valueForKey:kAnimation];
    
    if ([key isEqualToString:kLineAnimation]) {
        [self startTriangleAnimation];
    } else if ([key isEqualToString:kTriangleAnimation]) {
        self.animating = NO;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(animationButtonDidStopAnimation:playing:)]) {
            [self.delegate animationButtonDidStopAnimation:self playing:self.isPlaying];
        }
    } else if ([key isEqualToString:kInverseTriangleAnimation]) {
        [self startInverseLineAnimation];
    } else if ([key isEqualToString:kInverseLineAnimation]) {
        self.animating = NO;
        [self.leftLineLayer removeAllAnimations];
        [self.rightLineLayer removeAllAnimations];
        [self.triangleLayer removeAllAnimations];
        [self.arcLayer removeAllAnimations];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(animationButtonDidStopAnimation:playing:)]) {
            [self.delegate animationButtonDidStopAnimation:self playing:self.isPlaying];
        }
    }
}

#pragma mark - event response

- (void)click {
    [self startAnimation];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(animationButton2DidClick:)]) {
        [self.delegate animationButton2DidClick:self];
    }
}

#pragma mark - setters

- (void)setFrame:(CGRect)frame {
    CGSize originSize = self.frame.size;
    [super setFrame:frame];
    if (!CGSizeEqualToSize(originSize, frame.size)) {
        [self update];
    }
}

- (void)setLineColor:(UIColor *)lineColor {
    // 如果颜色相等，则不重复设置
    if (CGColorEqualToColor(_lineColor.CGColor, lineColor.CGColor)) {
        return;
    }
    _lineColor = lineColor;
    // 缺省值
    if (_lineColor == nil) {
        _lineColor = [UIColor blackColor];
    }
    self.leftLineLayer.strokeColor  = lineColor.CGColor;
    self.rightLineLayer.strokeColor = lineColor.CGColor;
    self.triangleLayer.strokeColor  = lineColor.CGColor;
    self.arcLayer.strokeColor       = lineColor.CGColor;
}

#pragma mark - getters

- (UIColor *)lineColor {
    if (!_lineColor) {
        // 缺省值
        _lineColor = [UIColor blackColor];
    }
    return _lineColor;
}

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

- (CAShapeLayer *)triangleLayer {
    if (!_triangleLayer) {
        _triangleLayer = [CAShapeLayer layer];
    }
    return _triangleLayer;
}

- (CAShapeLayer *)arcLayer {
    if (!_arcLayer) {
        _arcLayer = [CAShapeLayer layer];
    }
    return _arcLayer;
}

@end
