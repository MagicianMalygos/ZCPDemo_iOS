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
    // 可配参数
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
    
    // top line and bottom line
    
    
    
    // middle path
    /// 直线占整个middlePath线长的比例
    CGFloat _lineRatio;
    /// 最终的绘制起始点的位置对应的线长，占整个middlePath线长的比例
    CGFloat _startToValue;
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

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor greenColor];
        
        // 参数配置
        _lineWidth  = 5;
        _lineLength = 40;
        _lineGap    = 8;
        _lineLeft   = (100 - _lineLength)/2;
        _lineTop    = (100 - _lineWidth * 3 - _lineGap * 2) / 2;
        
        if (_lineLength < 2*_lineWidth + 2*_lineGap) {
            NSAssert(YES, @"参数配置有误，上下线构不会交叉");
        }
        
        // 初始化锚点（因为默认为(0.5, 0.5)，改成(0, 0)方便计算）
        self.topLayer.anchorPoint       = CGPointZero;
        self.middleLayer.anchorPoint    = CGPointZero;
        self.bottomLayer.anchorPoint    = CGPointZero;
        
        // 设置path
        self.topLayer.path      = [self topLayerPath].CGPath;
        self.middleLayer.path   = [self middleLayerPath].CGPath;
        self.bottomLayer.path   = [self bottomLayerPath].CGPath;
        
        // 设置layer的属性
        NSArray *layerArr = @[self.topLayer, self.middleLayer, self.bottomLayer];
        for (int i = 0; i < 3; i++) {
            CAShapeLayer *layer = layerArr[i];
            layer.fillColor     = nil;
            layer.strokeColor   = [UIColor blackColor].CGColor;
            layer.lineWidth     = _lineWidth;
            layer.lineCap       = kCALineCapRound;
            layer.bounds        = self.bounds;
            [self.layer addSublayer:layer];
        }
        
        // 设置中线的起始绘制位置和结束绘制位置（是一个比例值，范围为0~1）
        self.middleLayer.strokeStart = 0.0;
        self.middleLayer.strokeEnd = _lineRatio;
        
        // 设置anchorPoint便于旋转
        self.topLayer.anchorPoint = CGPointMake((_lineLeft + _lineLength)/self.topLayer.width, _lineTop / self.topLayer.height);
        self.topLayer.position = CGPointMake(_lineLeft + _lineLength, _lineTop);
        self.bottomLayer.anchorPoint = CGPointMake((_lineLeft + _lineLength)/self.bottomLayer.width, (_lineTop + (_lineGap + _lineWidth)*2) / self.topLayer.height);
        self.bottomLayer.position = CGPointMake(_lineLeft + _lineLength, _lineTop + (_lineGap + _lineWidth)*2);
    }
    return self;
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
    [path moveToPoint:CGPointMake(_lineLeft, _lineTop + (_lineGap + _lineWidth)*2)];
    [path addLineToPoint:CGPointMake(_lineLeft + _lineLength, _lineTop + (_lineGap + _lineWidth)*2)];
    return path;
}

- (UIBezierPath *)middleLayerPath {
    UIBezierPath *path  = [UIBezierPath bezierPath];
    
    // 1.绘制直线
    CGPoint lineStartPoint  = CGPointMake(_lineLeft, _lineTop + (_lineGap + _lineWidth));
    CGPoint lineEndPoint    = CGPointMake(_lineLeft + _lineLength, _lineTop + (_lineGap + _lineWidth));
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
    _lineRatio      = _lineLength / totalLength;
    _startToValue   = (_lineLength + cornerLength + M_PI_2*r) / totalLength;
    
    return path;
}

#pragma mark - public

- (void)go {
    if (!self.isOpen) {
        
        CABasicAnimation *strokeStartAnimation  = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        strokeStartAnimation.fromValue          = @(self.middleLayer.presentationLayer.strokeStart);
        strokeStartAnimation.toValue            = @(_startToValue);
        strokeStartAnimation.duration           = 1.0;
        strokeStartAnimation.fillMode           = kCAFillModeForwards;
        strokeStartAnimation.removedOnCompletion = NO;
        strokeStartAnimation.timingFunction     = [CAMediaTimingFunction functionWithControlPoints:0.25 :-0.4 :0.5 :1];
        
        CABasicAnimation *strokeEndAnimation    = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        strokeEndAnimation.fromValue            = @(self.middleLayer.presentationLayer.strokeEnd);
        strokeEndAnimation.toValue              = @(1.0f);
        strokeEndAnimation.duration             = 1.2;
        strokeEndAnimation.fillMode             = kCAFillModeForwards;
        strokeEndAnimation.removedOnCompletion  = NO;
        strokeEndAnimation.timingFunction       = [CAMediaTimingFunction functionWithControlPoints:0.25 :-0.4 :0.5 :1];
        
        [self.middleLayer removeAllAnimations];
        self.middleLayer.strokeStart = [strokeStartAnimation.fromValue floatValue];
        self.middleLayer.strokeEnd = [strokeEndAnimation.fromValue floatValue];
        [self.middleLayer addAnimation:strokeStartAnimation forKey:@"strokeStart"];
        [self.middleLayer addAnimation:strokeEndAnimation forKey:@"strokeEnd"];
    } else {
        
        CABasicAnimation *strokeStartAnimation  = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        strokeStartAnimation.fromValue          = @(self.middleLayer.presentationLayer.strokeStart);
        strokeStartAnimation.toValue            = @(0.0);
        strokeStartAnimation.duration           = 1.0;
        strokeStartAnimation.fillMode           = kCAFillModeForwards;
        strokeStartAnimation.removedOnCompletion = NO;
        strokeStartAnimation.timingFunction     = [CAMediaTimingFunction functionWithControlPoints:0.25 :0 :0.5 :1.2];
        
        CABasicAnimation *strokeEndAnimation    = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        strokeEndAnimation.fromValue            = @(self.middleLayer.presentationLayer.strokeEnd);
        strokeEndAnimation.toValue              = @(_lineRatio);
        strokeEndAnimation.duration             = 1.2;
        strokeEndAnimation.fillMode             = kCAFillModeForwards;
        strokeEndAnimation.removedOnCompletion  = NO;
        strokeEndAnimation.timingFunction       = [CAMediaTimingFunction functionWithControlPoints:0.25 :0.3 :0.5 :1];
        
        [self.middleLayer removeAllAnimations];
        self.middleLayer.strokeStart = [strokeStartAnimation.fromValue floatValue];
        self.middleLayer.strokeEnd = [strokeEndAnimation.fromValue floatValue];
        [self.middleLayer addAnimation:strokeStartAnimation forKey:@"strokeStart"];
        [self.middleLayer addAnimation:strokeEndAnimation forKey:@"strokeEnd"];
    }
    
    
    CGFloat l = _lineLength;
    CGFloat h = (_lineWidth * 2 + _lineGap * 2);
    CGFloat offset = (l - sqrt(l*l - h*h)) / 2;
    CGFloat sin0 = h / l;
    CGFloat asin0 = asin(sin0);
    
    if (!self.isOpen) {
        CATransform3D transform                 = CATransform3DMakeTranslation(-offset, 0, 0);
        
        CABasicAnimation *topTransformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        topTransformAnimation.duration          = 1.0;
        topTransformAnimation.beginTime         = CACurrentMediaTime() + 0.25;
        topTransformAnimation.fromValue         = [NSValue valueWithCATransform3D:self.topLayer.presentationLayer.transform];
        topTransformAnimation.toValue           = [NSValue valueWithCATransform3D:CATransform3DRotate(transform, -asin0, 0, 0, 1)];
        topTransformAnimation.timingFunction    = [CAMediaTimingFunction functionWithControlPoints:0.5 :-0.8 :0.5 :1.2];
        topTransformAnimation.fillMode          = kCAFillModeForwards;
        topTransformAnimation.removedOnCompletion = NO;
        
        
        CABasicAnimation *bottomTransformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        bottomTransformAnimation.duration       = 1.0;
        bottomTransformAnimation.beginTime      = CACurrentMediaTime() + 0.25;
        bottomTransformAnimation.fromValue      = [NSValue valueWithCATransform3D:self.bottomLayer.presentationLayer.transform];
        bottomTransformAnimation.toValue        = [NSValue valueWithCATransform3D:CATransform3DRotate(transform, asin0, 0, 0, 1)];
        bottomTransformAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5 :-0.8 :0.5 :1.2];
        bottomTransformAnimation.fillMode          = kCAFillModeForwards;
        bottomTransformAnimation.removedOnCompletion = NO;
        
        [self.topLayer removeAllAnimations];
        [self.bottomLayer removeAllAnimations];
        self.topLayer.transform = [topTransformAnimation.fromValue CATransform3DValue];
        self.bottomLayer.transform = [bottomTransformAnimation.fromValue CATransform3DValue];
        [self.topLayer addAnimation:topTransformAnimation forKey:topTransformAnimation.keyPath];
        [self.bottomLayer addAnimation:bottomTransformAnimation forKey:bottomTransformAnimation.keyPath];
    } else {
        CABasicAnimation *topTransformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        topTransformAnimation.duration          = 1.0;
        topTransformAnimation.beginTime         = CACurrentMediaTime() + 0.05;
        topTransformAnimation.fromValue         = [NSValue valueWithCATransform3D:self.topLayer.presentationLayer.transform];
        topTransformAnimation.toValue           = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        topTransformAnimation.timingFunction    = [CAMediaTimingFunction functionWithControlPoints:0.5 :-0.8 :0.5 :1.2];
        topTransformAnimation.fillMode          = kCAFillModeForwards;
        topTransformAnimation.removedOnCompletion = NO;
        
        
        CABasicAnimation *bottomTransformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        bottomTransformAnimation.duration       = 1.0;
        bottomTransformAnimation.beginTime      = CACurrentMediaTime() + 0.05;
        bottomTransformAnimation.fromValue      = [NSValue valueWithCATransform3D:self.bottomLayer.presentationLayer.transform];
        bottomTransformAnimation.toValue        = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        bottomTransformAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5 :-0.8 :0.5 :1.2];
        bottomTransformAnimation.fillMode          = kCAFillModeForwards;
        bottomTransformAnimation.removedOnCompletion = NO;
        
        [self.topLayer removeAllAnimations];
        [self.bottomLayer removeAllAnimations];
        self.topLayer.transform = [topTransformAnimation.fromValue CATransform3DValue];
        self.bottomLayer.transform = [bottomTransformAnimation.fromValue CATransform3DValue];
        [self.topLayer addAnimation:topTransformAnimation forKey:topTransformAnimation.keyPath];
        [self.bottomLayer addAnimation:bottomTransformAnimation forKey:bottomTransformAnimation.keyPath];
    }
    
    self.open = !self.open;
}

#pragma mark - getters and setters

- (CAShapeLayer *)topLayer {
    if (!_topLayer) {
        _topLayer = [CAShapeLayer layer];
    }
    return _topLayer;
}

- (CAShapeLayer *)middleLayer {
    if (!_middleLayer) {
        _middleLayer = [CAShapeLayer layer];
    }
    return _middleLayer;
}

- (CAShapeLayer *)bottomLayer {
    if (!_bottomLayer) {
        _bottomLayer = [CAShapeLayer layer];
    }
    return _bottomLayer;
}

@end
