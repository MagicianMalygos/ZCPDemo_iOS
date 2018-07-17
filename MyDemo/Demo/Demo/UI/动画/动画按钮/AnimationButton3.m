//
//  AnimationButton3.m
//  Demo
//
//  Created by 朱超鹏 on 2018/7/10.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "AnimationButton3.h"

#define kAnimation          @"kAnimation"
#define kPauseAnimation     @"kPauseAnimation"
#define kPlayAnimation      @"kPlayAnimation"

#define BlueColor       [UIColor colorFromHexRGB:@"1e90ff"]
#define LightBlueColor  [UIColor colorFromHexRGB:@"87cefa"]
#define RedColor        [UIColor colorFromHex:0xccee5c42]

@interface AnimationButton3 () <CAAnimationDelegate> {
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
    /// 圆弧半径
    CGFloat _arcRadius;
}

/// 左线layer
@property (nonatomic, strong) CAShapeLayer *leftLineLayer;
/// 右线layer
@property (nonatomic, strong) CAShapeLayer *rightLineLayer;
/// 左线圆弧layer
@property (nonatomic, strong) CAShapeLayer *leftArcLayer;
/// 右线圆弧layer
@property (nonatomic, strong) CAShapeLayer *rightArcLayer;
/// 中心的三角layer
@property (nonatomic, strong) CALayer      *centerTriangleLayer;

/// 是否正在执行动画
@property (nonatomic, assign, getter=isAnimating) BOOL animating;
/// 播放状态
@property (nonatomic, assign, getter=isPlaying) BOOL playing;

@end

@implementation AnimationButton3

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.layer addSublayer:self.leftArcLayer];
        [self.layer addSublayer:self.rightArcLayer];
        [self.layer addSublayer:self.leftLineLayer];
        [self.layer addSublayer:self.rightLineLayer];
        [self.layer addSublayer:self.centerTriangleLayer];
        
        // 初始化状态
        self.playing = YES;
        
        // 初始化参数和layer
        [self update];
        
        // 添加点击事件
        [self addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview == nil) {
        [self clearAllAnimation];
    }
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
    _lineWidth  = 8;
    _lineLength = self.height * 0.4;
    _arcRadius  = _lineLength / sqrt(3);
    _lineGap    = _arcRadius;
    _lineLeft   = (self.width - _lineGap) / 2;
    _lineTop    = (self.height - _lineLength) / 2;
}

/**
 更新path
 */
- (void)updatePath {
    self.leftLineLayer.path         = [self leftLineLayerPath].CGPath;
    self.rightLineLayer.path        = [self rightLineLayerPath].CGPath;
    self.leftArcLayer.path          = [self leftArcLineLayerPath].CGPath;
    self.rightArcLayer.path         = [self rightArcLineLayerPath].CGPath;
}

/**
 更新layer
 */
- (void)updateLayer {
    self.leftLineLayer.fillColor        = nil;
    self.leftLineLayer.strokeColor      = BlueColor.CGColor;
    self.leftLineLayer.lineWidth        = _lineWidth;
    self.leftLineLayer.lineCap          = kCALineCapRound;
    self.leftLineLayer.lineJoin         = kCALineJoinRound;
    self.leftLineLayer.frame            = self.layer.bounds;
    
    self.rightLineLayer.fillColor       = nil;
    self.rightLineLayer.strokeColor     = BlueColor.CGColor;
    self.rightLineLayer.lineWidth       = _lineWidth;
    self.rightLineLayer.lineCap         = kCALineCapRound;
    self.rightLineLayer.lineJoin        = kCALineJoinRound;
    self.rightLineLayer.frame           = self.layer.bounds;
    
    self.leftArcLayer.fillColor         = nil;
    self.leftArcLayer.strokeColor       = LightBlueColor.CGColor;
    self.leftArcLayer.lineWidth         = _lineWidth;
    self.leftArcLayer.lineCap           = kCALineCapRound;
    self.leftArcLayer.lineJoin          = kCALineJoinRound;
    self.leftArcLayer.frame             = self.layer.bounds;
    self.leftArcLayer.strokeEnd         = 0;
    
    self.rightArcLayer.fillColor        = nil;
    self.rightArcLayer.strokeColor      = LightBlueColor.CGColor;
    self.rightArcLayer.lineWidth        = _lineWidth;
    self.rightArcLayer.lineCap          = kCALineCapRound;
    self.rightArcLayer.lineJoin         = kCALineJoinRound;
    self.rightArcLayer.frame            = self.layer.bounds;
    self.rightArcLayer.strokeEnd        = 0;
    
    [self configureCenterTriangleLayer];
    self.centerTriangleLayer.opacity    = 0;
}

#pragma mark - private

- (UIBezierPath *)leftLineLayerPath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(_lineLeft, _lineTop + _lineLength)];
    [path addLineToPoint:CGPointMake(_lineLeft, _lineTop)];
    return path;
}

- (UIBezierPath *)rightLineLayerPath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(_lineLeft + _lineGap, _lineTop)];
    [path addLineToPoint:CGPointMake(_lineLeft + _lineGap, _lineTop + _lineLength)];
    return path;
}

- (UIBezierPath *)leftArcLineLayerPath {
    CGPoint center      = CGPointMake(self.layer.width/2, self.layer.height/2);
    CGFloat startAngle  = M_PI/2 + M_PI / 6;
    CGFloat endAngle    = -M_PI /3;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(_lineLeft, _lineTop + _lineLength)];
    [path addArcWithCenter:center radius:_arcRadius startAngle:startAngle endAngle:endAngle clockwise:NO];
    return path;
}

- (UIBezierPath *)rightArcLineLayerPath {
    CGPoint center      = CGPointMake(self.layer.width/2, self.layer.height/2);
    CGFloat startAngle  = -M_PI /3;
    CGFloat endAngle    = M_PI/2 + M_PI / 6;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(_lineLeft + _lineGap, _lineTop)];
    [path addArcWithCenter:center radius:_arcRadius startAngle:startAngle endAngle:endAngle clockwise:NO];
    return path;
}

- (void)configureCenterTriangleLayer {
    [self.centerTriangleLayer removeAllSublayers];
    self.centerTriangleLayer.frame = self.layer.bounds;
    
    // 三角形中心到端点距离与圆半径的比值
    CGFloat ratio           = 0.6;
    // 三角形中线以中心点分割的长部分
    CGFloat centerLineLong  = _arcRadius * ratio;
    // 三角形中线以中心点分割的短部分
    CGFloat centerLineShort = _arcRadius * ratio/2;
    // 三角形边长的一半
    CGFloat triangleLength_2 = centerLineShort * sqrt(3);
    
    CGPoint centerPoint = CGPointMake(self.layer.width / 2, self.layer.height / 2);
    CGPoint startPoint1 = CGPointMake(centerPoint.x - triangleLength_2, centerPoint.y - centerLineShort);
    CGPoint startPoint2 = CGPointMake(centerPoint.x + triangleLength_2, centerPoint.y - centerLineShort);
    CGPoint endPoint    = CGPointMake(centerPoint.x, centerPoint.y + centerLineLong);
    
    {
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.anchorPoint   = CGPointZero;
        layer.position      = CGPointZero;
        layer.frame         = self.centerTriangleLayer.bounds;
        layer.fillColor     = nil;
        layer.strokeColor   = RedColor.CGColor;
        layer.lineWidth     = _lineWidth;
        layer.lineCap       = kCALineCapRound;
        layer.lineJoin      = kCALineJoinRound;
        
        UIBezierPath *path  = [UIBezierPath bezierPath];
        [path moveToPoint:startPoint1];
        [path addLineToPoint:endPoint];
        layer.path          = path.CGPath;
        [self.centerTriangleLayer addSublayer:layer];
    }
    {
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.anchorPoint   = CGPointZero;
        layer.position      = CGPointZero;
        layer.frame         = self.centerTriangleLayer.bounds;
        layer.fillColor     = nil;
        layer.strokeColor   = RedColor.CGColor;
        layer.lineWidth     = _lineWidth;
        layer.lineCap       = kCALineCapRound;
        layer.lineJoin      = kCALineJoinRound;
        
        UIBezierPath *path  = [UIBezierPath bezierPath];
        [path moveToPoint:startPoint2];
        [path addLineToPoint:endPoint];
        layer.path          = path.CGPath;
        [self.centerTriangleLayer addSublayer:layer];
    }
}

#pragma mark - animation

- (void)startAnimation {
    if (self.animating) {
        return;
    }
    // 更新动画执行状态
    self.animating = YES;
    
    // 开始动画
    if (self.isPlaying) {
        [self startPauseAnimation];
    } else {
        [self startPlayAnimation];
    }
    
    // 更新播放状态
    self.playing = !self.isPlaying;
}

- (void)startPauseAnimation {
    CGFloat lineShorteningDuration  = 0.3;
    CGFloat rotationStartTime       = lineShorteningDuration/2;
    CGFloat rotationDuration        = 0.3;
    CGFloat showArcDuration         = rotationStartTime + rotationDuration;
    CGFloat showTriangleStartTime   = rotationStartTime + 0.1;
    CGFloat showTriangleDuration    = rotationDuration;
    
    /// 线缩短
    {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.duration          = lineShorteningDuration;
        animation.fromValue         = @(1);
        animation.toValue           = @(0.01);
        animation.fillMode          = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        [self.leftLineLayer addAnimation:animation forKey:nil];
        [self.rightLineLayer addAnimation:animation forKey:nil];
    }
    
    /// 显示圆弧
    {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.duration          = showArcDuration;
        animation.fromValue         = @(0);
        animation.toValue           = @(1);
        animation.fillMode          = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        [self.leftArcLayer addAnimation:animation forKey:nil];
        [self.rightArcLayer addAnimation:animation forKey:nil];
    }
    
    /// 旋转动画
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(rotationStartTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            animation.duration          = rotationDuration;
            animation.fromValue         = @(0);
            animation.toValue           = @(-M_PI_2);
            animation.fillMode          = kCAFillModeForwards;
            animation.removedOnCompletion = NO;
            [self.layer addAnimation:animation forKey:nil];
        });
    }
    
    /// 显示中心三角
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(showTriangleStartTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
            animation.duration          = showTriangleDuration;
            animation.fromValue         = @(0);
            animation.toValue           = @(1);
            animation.fillMode          = kCAFillModeForwards;
            animation.removedOnCompletion = NO;
            animation.delegate          = self;
            [animation setValue:kPauseAnimation forKey:kAnimation];
            [self.centerTriangleLayer addAnimation:animation forKey:nil];
        });
    }
}

- (void)startPlayAnimation {
    CGFloat hideTriangleDuration    = 0.3;
    CGFloat rotationStartTime       = 0.1;
    CGFloat rotationDuration        = hideTriangleDuration;
    CGFloat hideArcStartTime        = rotationStartTime;
    CGFloat lineGrowthDuration      = 0.3;
    CGFloat lineGrowthStartTime     = rotationStartTime + rotationDuration - lineGrowthDuration/2;
    CGFloat hideArcDuration         = rotationDuration + lineGrowthDuration/2;
    
    /// 隐藏中心三角
    {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animation.duration          = hideTriangleDuration;
        animation.fromValue         = @(1);
        animation.toValue           = @(0);
        animation.fillMode          = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        [self.centerTriangleLayer addAnimation:animation forKey:nil];
    }
    
    /// 旋转动画
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(rotationStartTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            animation.duration          = rotationDuration;
            animation.fromValue         = @(-M_PI_2);
            animation.toValue           = @(0);
            animation.fillMode          = kCAFillModeForwards;
            animation.removedOnCompletion = NO;
            [self.layer addAnimation:animation forKey:nil];
        });
    }
    
    /// 隐藏圆弧
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(hideArcStartTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            animation.duration          = hideArcDuration;
            animation.fromValue         = @(1);
            animation.toValue           = @(0);
            animation.fillMode          = kCAFillModeForwards;
            animation.removedOnCompletion = NO;
            [self.leftArcLayer addAnimation:animation forKey:nil];
            [self.rightArcLayer addAnimation:animation forKey:nil];
        });
    }
    
    /// 线增长
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(lineGrowthStartTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            animation.duration          = lineGrowthDuration;
            animation.fromValue         = @(0.01);
            animation.toValue           = @(1);
            animation.fillMode          = kCAFillModeForwards;
            animation.removedOnCompletion = NO;
            animation.delegate          = self;
            [animation setValue:kPlayAnimation forKey:kAnimation];
            [self.leftLineLayer addAnimation:animation forKey:nil];
            animation.delegate          = nil;
            [self.rightLineLayer addAnimation:animation forKey:nil];
        });
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (!flag) {
        // 如果动画被终止则不回调
        return;
    }
    
    NSString *key = [anim valueForKey:kAnimation];
    if ([key isEqualToString:kPauseAnimation]) {
        
    } else if ([key isEqualToString:kPlayAnimation]) {
        [self clearAllAnimation];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(animationButtonDidStopAnimation:state:)]) {
        [self.delegate animationButtonDidStopAnimation:self state:self.playing];
    }
    
    self.animating = NO;
}

- (void)clearAllAnimation {
    [self.layer removeAllAnimations];
    [self.leftLineLayer removeAllAnimations];
    [self.rightLineLayer removeAllAnimations];
    [self.leftArcLayer removeAllAnimations];
    [self.rightArcLayer removeAllAnimations];
    [self.centerTriangleLayer removeAllAnimations];
}

#pragma mark - event response

- (void)click {
    [self startAnimation];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(animationButtonDidClick:)]) {
        [self.delegate animationButtonDidClick:self];
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

#pragma mark - getters

- (CAShapeLayer *)leftLineLayer {
    if (!_leftLineLayer) {
        _leftLineLayer = [CAShapeLayer layer];
        _leftLineLayer.anchorPoint  = CGPointZero;
        _leftLineLayer.position     = CGPointZero;
    }
    return _leftLineLayer;
}

- (CAShapeLayer *)rightLineLayer {
    if (!_rightLineLayer) {
        _rightLineLayer = [CAShapeLayer layer];
        _rightLineLayer.anchorPoint  = CGPointZero;
        _rightLineLayer.position     = CGPointZero;
    }
    return _rightLineLayer;
}

- (CAShapeLayer *)leftArcLayer {
    if (!_leftArcLayer) {
        _leftArcLayer = [CAShapeLayer layer];
        _leftArcLayer.anchorPoint  = CGPointZero;
        _leftArcLayer.position     = CGPointZero;
    }
    return _leftArcLayer;
}

- (CAShapeLayer *)rightArcLayer {
    if (!_rightArcLayer) {
        _rightArcLayer              = [CAShapeLayer layer];
        _rightArcLayer.anchorPoint  = CGPointZero;
        _rightArcLayer.position     = CGPointZero;
    }
    return _rightArcLayer;
}

- (CALayer *)centerTriangleLayer {
    if (!_centerTriangleLayer) {
        _centerTriangleLayer = [CALayer layer];
        _centerTriangleLayer.anchorPoint  = CGPointZero;
        _centerTriangleLayer.position     = CGPointZero;
    }
    return _centerTriangleLayer;
}

@end
