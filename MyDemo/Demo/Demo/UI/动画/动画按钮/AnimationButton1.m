//
//  AnimationButton1.m
//  Demo
//
//  Created by 朱超鹏 on 2018/7/3.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "AnimationButton1.h"
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

#define kAnimation                  @"kAnimation"
#define kOpenAnimation              @"kOpenAnimation"
#define kCloseAnimation             @"kCloseAnimation"
#define kOpenTransformAnimation     @"kOpenTransformAnimation"
#define kCloseTransformAnimation    @"kCloseTransformAnimation"

@interface AnimationButton1 ()<CAAnimationDelegate> {
    // 配置参数
    /// 线宽
    CGFloat _lineWidth;
    /// 线长
    CGFloat _lineLength;
    /// 线之间的间隙
    CGFloat _lineGap;
    /// 线的左边距
    CGFloat _lineLeft;
    /// 线的上边距
    CGFloat _lineTop;
    
    // 顶线和底线的计算参数
    /// 顶线和底线交叉时的水平偏移量
    CGFloat _offset;
    /// 顶线和底线交叉时的夹角弧度
    CGFloat _angle;
    
    // 中线的计算参数
    /// 直线部分与整个middlePath线长的比值
    CGFloat _lineRatio;
    /// 打开动画结束时起始绘制位置对应的线长与整个middlePath线长的比值
    CGFloat _strokeStartRatio;
}

/// 顶部线layer
@property (nonatomic, strong) CAShapeLayer *topLayer;
/// 中间线layer
@property (nonatomic, strong) CAShapeLayer *middleLayer;
/// 底部线layer
@property (nonatomic, strong) CAShapeLayer *bottomLayer;

/// 按钮打开状态
@property (nonatomic, assign, getter=isOpen) BOOL open;

@end

@implementation AnimationButton1

@synthesize lineColor = _lineColor;

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.layer addSublayer:self.topLayer];
        [self.layer addSublayer:self.middleLayer];
        [self.layer addSublayer:self.bottomLayer];
        
        // 初始化锚点（因为默认为(0.5, 0.5)，改成(0, 0)方便计算）
        self.topLayer.anchorPoint       = CGPointZero;
        self.middleLayer.anchorPoint    = CGPointZero;
        self.bottomLayer.anchorPoint    = CGPointZero;
        
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
    _lineWidth      = 5;
    _lineLength     = self.width * 0.4;
    _lineGap        = 15;
    _lineLeft       = (self.width - _lineLength)/2;
    _lineTop        = (self.height - _lineGap * 2) / 2;
    
    if (_lineLength < 2*_lineGap) {
        NSAssert(YES, @"参数配置有误，上下线构不会交叉");
    }
    
    CGFloat l       = _lineLength;
    CGFloat h       = _lineGap * 2;
    CGFloat sin0    = h / l;
    _offset         = (l - sqrt(l*l - h*h)) / 2;
    _angle          = asin(sin0);
}

- (void)updatePath {
    self.topLayer.path      = [self topLayerPath].CGPath;
    self.middleLayer.path   = [self middleLayerPath].CGPath;
    self.bottomLayer.path   = [self bottomLayerPath].CGPath;
}

- (void)updateLayer {
    NSArray *layerArr = @[self.topLayer, self.middleLayer, self.bottomLayer];
    for (int i = 0; i < 3; i++) {
        CAShapeLayer *layer = layerArr[i];
        layer.fillColor     = nil;
        layer.strokeColor   = [UIColor blackColor].CGColor;
        layer.lineCap       = kCALineCapRound;
        layer.lineWidth     = _lineWidth;
        layer.bounds        = self.bounds;
    }
    
    // 设置中线初始的起始绘制位置和结束绘制位置（是一个比例值，范围为0~1）
    self.middleLayer.strokeStart = 0.0;
    self.middleLayer.strokeEnd = _lineRatio;
    
    // 将顶线和底线的锚点和位置设置为线的右端点，以便于旋转时是以右端点为中心进行旋转
    CGPoint topLineRightPoint       = CGPointMake(_lineLeft + _lineLength, _lineTop);
    CGPoint bottomLineRightPoint    = CGPointMake(_lineLeft + _lineLength, _lineTop + (_lineGap)*2);
    self.topLayer.anchorPoint       = CGPointMake(topLineRightPoint.x / self.topLayer.width, topLineRightPoint.y / self.topLayer.height);
    self.bottomLayer.anchorPoint    = CGPointMake(bottomLineRightPoint.x / self.bottomLayer.width, bottomLineRightPoint.y / self.topLayer.height);
    self.topLayer.position          = topLineRightPoint;
    self.bottomLayer.position       = bottomLineRightPoint;
}

#pragma mark - private

- (UIBezierPath *)topLayerPath {
    UIBezierPath *path  = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(_lineLeft, _lineTop)];
    [path addLineToPoint:CGPointMake(_lineLeft + _lineLength, _lineTop)];
    return path;
}

- (UIBezierPath *)bottomLayerPath {
    UIBezierPath *path  = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(_lineLeft, _lineTop + _lineGap * 2)];
    [path addLineToPoint:CGPointMake(_lineLeft + _lineLength, _lineTop + _lineGap * 2)];
    return path;
}

- (UIBezierPath *)middleLayerPath {
    UIBezierPath *path  = [UIBezierPath bezierPath];
    
    // 1.绘制直线
    CGPoint lineStartPoint  = CGPointMake(_lineLeft, _lineTop + _lineGap);
    CGPoint lineEndPoint    = CGPointMake(_lineLeft + _lineLength, _lineTop + _lineGap);
    [path moveToPoint:lineStartPoint];
    [path addLineToPoint:lineEndPoint];
    
    // 绘制圆弧需要的各种参数
    // 线长
    CGFloat l       = _lineLength;
    // 拐角圆的半径
    CGFloat cr      = l / 4;
    // 大圆的半径
    CGFloat r       = cr + sqrt(l*l/4 + cr*cr);
    // 拐角圆与大圆相切的点和大圆圆心的连线与水平线的夹角，正切值
    CGFloat tan0    = 2*cr / l;
    // 拐角圆的半径
    CGFloat atan0   = atan(tan0);
    // 直线中心点
    CGPoint lineCenterPoint = CGPointMake((lineEndPoint.x + lineStartPoint.x)/2, (lineEndPoint.y + lineStartPoint.y)/2);
    
    // 2.绘制拐角圆
    CGPoint cornerCenter = CGPointMake(lineCenterPoint.x + l / 2, lineCenterPoint.y - cr);
    [path addArcWithCenter:cornerCenter radius:cr startAngle:M_PI_2 endAngle:-atan0 clockwise:NO];
    
    // 3.绘制大圆
    CGPoint center      = lineCenterPoint;
    CGFloat startAngle  = -atan0;
    CGFloat endAngle    = -M_PI_2-atan0 - M_PI*2;
    [path addArcWithCenter:center radius:r startAngle:startAngle endAngle:endAngle clockwise:NO];
    
    // 相关参数初始化
    // 弧长 = 弧度 x 半径
    CGFloat cornerLength    = (M_PI_2 + atan0) * cr;
    CGFloat circleLength    = (M_PI_2 + M_PI*2) * r;
    CGFloat totalLength     = _lineLength + cornerLength + circleLength;
    _lineRatio              = _lineLength / totalLength;
    _strokeStartRatio       = (_lineLength + cornerLength + M_PI_2*r) / totalLength;
    
    return path;
}

#pragma mark - event response

- (void)click {
    [self startAnimation];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(animationButtonDidClick:)]) {
        [self.delegate animationButtonDidClick:self];
    }
}

#pragma mark - animation

- (void)startAnimation {
    // 执行中线的动画
    [self startMiddleLayerAnimation];
    
    // 执行顶线和底线的动画
    [self startTopAndBottomLayerAnimation];
    
    // 更新状态
    self.open = !self.open;
}

- (void)startMiddleLayerAnimation {
    CABasicAnimation *strokeStartAnimation  = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    CABasicAnimation *strokeEndAnimation    = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    
    strokeStartAnimation.duration           = 1.0;
    strokeStartAnimation.fillMode           = kCAFillModeForwards;
    strokeStartAnimation.removedOnCompletion = NO;
    
    strokeEndAnimation.duration             = 1.2;
    strokeEndAnimation.fillMode             = kCAFillModeForwards;
    strokeEndAnimation.removedOnCompletion  = NO;
    strokeEndAnimation.delegate             = self;
    
    if (!self.isOpen) {
        strokeStartAnimation.fromValue          = @(self.middleLayer.presentationLayer.strokeStart);
        strokeStartAnimation.toValue            = @(_strokeStartRatio);
        strokeStartAnimation.timingFunction     = [CAMediaTimingFunction functionWithControlPoints:0.25 :-0.4 :0.5 :1];
        
        strokeEndAnimation.fromValue            = @(self.middleLayer.presentationLayer.strokeEnd);
        strokeEndAnimation.toValue              = @(1.0f);
        strokeEndAnimation.timingFunction       = [CAMediaTimingFunction functionWithControlPoints:0.25 :-0.4 :0.5 :1];
    } else {
        strokeStartAnimation.fromValue          = @(self.middleLayer.presentationLayer.strokeStart);
        strokeStartAnimation.toValue            = @(0.0);
        strokeStartAnimation.timingFunction     = [CAMediaTimingFunction functionWithControlPoints:0.25 :0 :0.5 :1.2];
        
        strokeEndAnimation.fromValue            = @(self.middleLayer.presentationLayer.strokeEnd);
        strokeEndAnimation.toValue              = @(_lineRatio);
        strokeEndAnimation.timingFunction       = [CAMediaTimingFunction functionWithControlPoints:0.25 :0.3 :0.5 :1];
    }
    
    [self.middleLayer removeAllAnimations];
    self.middleLayer.strokeStart    = [strokeStartAnimation.fromValue floatValue];
    self.middleLayer.strokeEnd      = [strokeEndAnimation.fromValue floatValue];
    [self.middleLayer addAnimation:strokeStartAnimation forKey:@"strokeStart"];
    [self.middleLayer addAnimation:strokeEndAnimation forKey:@"strokeEnd"];
}

- (void)startTopAndBottomLayerAnimation {
    CABasicAnimation *topTransformAnimation     = [CABasicAnimation animationWithKeyPath:@"transform"];
    CABasicAnimation *bottomTransformAnimation  = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    topTransformAnimation.duration              = 1.0;
    topTransformAnimation.fillMode              = kCAFillModeForwards;
    topTransformAnimation.removedOnCompletion   = NO;
    
    bottomTransformAnimation.duration           = 1.0;
    bottomTransformAnimation.fillMode           = kCAFillModeForwards;
    bottomTransformAnimation.removedOnCompletion = NO;
    
    if (!self.isOpen) {
        CATransform3D transform                 = CATransform3DMakeTranslation(-_offset, 0, 0);
        CATransform3D topTransform              = CATransform3DRotate(transform, -_angle, 0, 0, 1);
        CATransform3D bottomTransform           = CATransform3DRotate(transform, _angle, 0, 0, 1);
        
        topTransformAnimation.fromValue         = [NSValue valueWithCATransform3D:self.topLayer.presentationLayer.transform];
        topTransformAnimation.toValue           = [NSValue valueWithCATransform3D:topTransform];
        topTransformAnimation.beginTime         = CACurrentMediaTime() + 0.25;
        topTransformAnimation.timingFunction    = [CAMediaTimingFunction functionWithControlPoints:0.5 :-0.8 :0.5 :1.2];
        
        bottomTransformAnimation.fromValue      = [NSValue valueWithCATransform3D:self.bottomLayer.presentationLayer.transform];
        bottomTransformAnimation.toValue        = [NSValue valueWithCATransform3D:bottomTransform];
        bottomTransformAnimation.beginTime      = CACurrentMediaTime() + 0.25;
        bottomTransformAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5 :-0.8 :0.5 :1.2];
        
    } else {
        topTransformAnimation.fromValue         = [NSValue valueWithCATransform3D:self.topLayer.presentationLayer.transform];
        topTransformAnimation.toValue           = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        topTransformAnimation.beginTime         = CACurrentMediaTime() + 0.05;
        topTransformAnimation.timingFunction    = [CAMediaTimingFunction functionWithControlPoints:0.5 :-0.8 :0.5 :1.2];
        
        bottomTransformAnimation.fromValue      = [NSValue valueWithCATransform3D:self.bottomLayer.presentationLayer.transform];
        bottomTransformAnimation.toValue        = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        bottomTransformAnimation.beginTime      = CACurrentMediaTime() + 0.05;
        bottomTransformAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5 :-0.8 :0.5 :1.2];
    }
    
    [self.topLayer removeAllAnimations];
    [self.bottomLayer removeAllAnimations];
    self.topLayer.transform     = [topTransformAnimation.fromValue CATransform3DValue];
    self.bottomLayer.transform  = [bottomTransformAnimation.fromValue CATransform3DValue];
    [self.topLayer addAnimation:topTransformAnimation forKey:topTransformAnimation.keyPath];
    [self.bottomLayer addAnimation:bottomTransformAnimation forKey:bottomTransformAnimation.keyPath];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (!flag) {
        // 如果动画被终止则不回调
        return;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(animationButtonDidStopAnimation:state:)]) {
        [self.delegate animationButtonDidStopAnimation:self state:self.isOpen];
    }
}

- (void)clearAllAnimation {
    [self.topLayer removeAllAnimations];
    [self.middleLayer removeAllAnimations];
    [self.bottomLayer removeAllAnimations];
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
    self.topLayer.strokeColor       = lineColor.CGColor;
    self.middleLayer.strokeColor    = lineColor.CGColor;
    self.bottomLayer.strokeColor    = lineColor.CGColor;
}

#pragma mark - getters

- (UIColor *)lineColor {
    if (!_lineColor) {
        // 缺省值
        _lineColor = [UIColor blackColor];
    }
    return _lineColor;
}

- (CAShapeLayer *)topLayer {
    if (!_topLayer) {
        _topLayer           = [CAShapeLayer layer];
    }
    return _topLayer;
}

- (CAShapeLayer *)middleLayer {
    if (!_middleLayer) {
        _middleLayer        = [CAShapeLayer layer];
    }
    return _middleLayer;
}

- (CAShapeLayer *)bottomLayer {
    if (!_bottomLayer) {
        _bottomLayer        = [CAShapeLayer layer];
    }
    return _bottomLayer;
}

@end
