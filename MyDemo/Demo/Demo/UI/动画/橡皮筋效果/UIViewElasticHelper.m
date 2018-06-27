//
//  UIViewElasticHelper.m
//  Demo
//
//  Created by 朱超鹏 on 2018/6/27.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "UIViewElasticHelper.h"

/**
 视图的状态

 - UIViewElasticStateInitial:   初始状态
 - UIViewElasticStateStretch:   拉伸状态
 - UIViewElasticStateFreeMove:  自由移动状态
 */
typedef NS_ENUM(NSInteger, UIViewElasticState) {
    UIViewElasticStateInitial  = 0,
    UIViewElasticStateStretch  = 1,
    UIViewElasticStateFreeMove = 2,
};

@interface UIViewElasticHelper ()

@property (nonatomic, strong) UIView *elasticView;

/// 需要施加橡皮筋效果的view的父视图
@property (nonatomic, weak) UIView *superview;

/// 橡皮筋layer
@property (nonatomic, strong) CAShapeLayer *elasticLayer;

/// 当前view的状态
@property (nonatomic, assign) UIViewElasticState state;

/// 拉伸时暂存的原始位置
@property (nonatomic, assign) CGPoint originPoint;
/// 拉伸的起始点
@property (nonatomic, assign) CGPoint beganPoint;

@end

@implementation UIViewElasticHelper

#pragma mark - life cycle

- (instancetype)init {
    if (self = [super init]) {
        self.elasticColor = [UIColor redColor];
    }
    return self;
}

#pragma mark - public

- (void)setView:(UIView *)view {
    _view       = view;
    _superview  = view.superview;
    
    // maximumStretchDistance默认为5倍的圆周长
    if (self.maximumStretchDistance == 0) {
        _maximumStretchDistance = view.width * 5;
    }
    // lifeArea默认为superview的bounds
    if (_superview && CGRectEqualToRect(self.lifeArea, CGRectZero)) {
        _lifeArea = _superview.bounds;
    }
    
    // 打开橡皮筋效果
    self.view.userInteractionEnabled = YES;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
}

#pragma mark - pan

- (void)pan:(UIPanGestureRecognizer *)panGesture {
    CGPoint point = [panGesture locationInView:self.superview];
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan: {
            self.state          = UIViewElasticStateStretch;
            self.originPoint    = self.view.origin;
            self.beganPoint     = CGPointMake(self.view.origin.x + self.view.width / 2, self.view.origin.y + self.view.height / 2);
        }
            break;
        case UIGestureRecognizerStateChanged: {
            // view的位置跟随手指移动
            self.view.origin    = CGPointMake(point.x - self.view.width / 2, point.y - self.view.height / 2);
            
            // 判断是否超出拉伸距离
            CGFloat distance    = CGPointGetDistanceToPoint(point, self.beganPoint);
            if (distance < self.maximumStretchDistance && self.state == UIViewElasticStateStretch) {
                [self updatePathWithBeganPoint:self.beganPoint changedPoint:point];
            } else {
                self.state = UIViewElasticStateFreeMove;
                [self.elasticLayer removeFromSuperlayer];
            }
        }
            break;
        case UIGestureRecognizerStateEnded: {
            self.state = UIViewElasticStateInitial;
            [self.elasticLayer removeFromSuperlayer];
            
            if (CGRectContainsPoint(self.lifeArea, point)) {
                // 回到初始位置
                self.view.origin = self.originPoint;
            } else {
                // 超出生命区域移除视图
                [self.view removeFromSuperview];
            }
        }
        default:
            break;
    }
}

- (void)updatePathWithBeganPoint:(CGPoint)beganPoint changedPoint:(CGPoint)changedPoint {
    // 圆
    CGPoint cc1 = beganPoint;
    CGPoint cc2 = changedPoint;
    CGFloat r = self.view.height / 2; // 初始半径
    CGFloat r1 = 0;
    CGFloat r2 = 0;
    // 圆半径与拉伸距离的线性关系为：过点(0, r)和(maxdis, 1.0/4 * r)的直线
    // y = (-3.0/4 * r / maxdis) * x + r
    CGFloat distance = CGPointGetDistanceToPoint(beganPoint, changedPoint);
    r1 = (-3.0/4*r/self.maximumStretchDistance) * distance + r;
    r2 = (-3.0/4*r/self.maximumStretchDistance) * distance + r;
    
    // 三角形 三角形由“圆心线”、“圆1与x轴的垂直线”、“圆2与y轴的垂直线”组成，θ角为圆心线和圆2与y轴的垂直线的夹角
    CGFloat a = fabs(cc2.x - cc1.x);
    CGFloat b = fabs(cc2.y - cc1.y);
    CGFloat c = sqrt(a * a + b * b);
    CGFloat sin0 = b / c;
    CGFloat cos0 = a / c;
    
    // 三角形θ角在圆中的弧度值
    CGFloat radian = asin(sin0);
    CGFloat angle = 0;
    
    // 贝塞尔曲线的起点、终点、控制点
    CGPoint p1 = CGPointZero;
    CGPoint p2 = CGPointZero;
    CGPoint p3 = CGPointZero;
    CGPoint p4 = CGPointZero;
    CGPoint controlPoint1 = CGPointZero;
    CGPoint controlPoint2 = CGPointZero;
    
    // 计算起点、终点
    {
        // 四个象限下的四种情况
        if (cc1.x >= cc2.x && cc1.y < cc2.y) {
            p1 = CGPointMake(cc1.x + r1 * sin0, cc1.y + r1 * cos0);
            p2 = CGPointMake(cc1.x - r1 * sin0, cc1.y - r1 * cos0);
            p3 = CGPointMake(cc2.x + r2 * sin0, cc2.y + r2 * cos0);
            p4 = CGPointMake(cc2.x - r2 * sin0, cc2.y - r2 * cos0);
            angle = M_PI_2 - radian;
        } else if (cc1.x > cc2.x && cc1.y >= cc2.y) {
            p1 = CGPointMake(cc1.x - r1 * sin0, cc1.y + r1 * cos0);
            p2 = CGPointMake(cc1.x + r1 * sin0, cc1.y - r1 * cos0);
            p3 = CGPointMake(cc2.x - r2 * sin0, cc2.y + r2 * cos0);
            p4 = CGPointMake(cc2.x + r2 * sin0, cc2.y - r2 * cos0);
            angle = M_PI_2 + radian;
        } else if (cc1.x <= cc2.x && cc1.y > cc2.y) {
            p1 = CGPointMake(cc1.x - r1 * sin0, cc1.y - r1 * cos0);
            p2 = CGPointMake(cc1.x + r1 * sin0, cc1.y + r1 * cos0);
            p3 = CGPointMake(cc2.x - r2 * sin0, cc2.y - r2 * cos0);
            p4 = CGPointMake(cc2.x + r2 * sin0, cc2.y + r2 * cos0);
            angle = -M_PI_2 - radian;
        } else if (cc1.x < cc2.x && cc1.y <= cc2.y) {
            p1 = CGPointMake(cc1.x + r1 * sin0, cc1.y - r1 * cos0);
            p2 = CGPointMake(cc1.x - r1 * sin0, cc1.y + r1 * cos0);
            p3 = CGPointMake(cc2.x + r2 * sin0, cc2.y - r2 * cos0);
            p4 = CGPointMake(cc2.x - r2 * sin0, cc2.y + r2 * cos0);
            angle = -M_PI_2 + radian;
        }
    }
    
    // 计算控制点 （控制点取值范围：c13~cp，c24~cp）
    {
        // 圆心线中点
        CGPoint cp = CGPointMake((cc2.x + cc1.x) / 2, (cc2.y + cc1.y) / 2);
        // p1 p3 中点 c13
        CGPoint c13 = CGPointMake((p3.x + p1.x) / 2, (p3.y + p1.y) / 2);
        // p2 p4 中点 c24
        CGPoint c24 = CGPointMake((p4.x + p2.x) / 2, (p4.y + p2.y) / 2);
        
        // 圆心线和c13的线 l13
        if (c13.x == cp.x) {
            // l13斜率不存在的情况
            
            // y的取值范围与拉伸距离的线性关系为：过点(0, c13.y)和(maxdis, cp.y)的直线
            // x : 定值c13.x
            // y : c13.y ~ cp.y
            // d : 0 ~ maxdis
            // y = ((cp.y - c13.y) / maxD) * x + c13.y
            controlPoint1.x = c13.x;
            controlPoint1.y = (((cp.y - c13.y) / self.maximumStretchDistance) * distance + c13.y);
        } else {
            // l13斜率存在的情况
            CGFloat k13 = (c13.y - cp.y) / (c13.x - cp.x);
            CGFloat b13 = (c13.x * cp.y - cp.x * c13.y) / (c13.x - cp.x);
            // l13 : y = k13 * x + b13
            
            // x的取值与拉伸距离的线性关系为：过点(0, c13.x)和(maxdis, cp.x)的直线
            // x : c13.x ~ cp.x
            // d : 0 ~ maxdis
            // y = ((cp.x - c13.x) / maxD) * x + c13.x
            controlPoint1.x = (((cp.x - c13.x) / self.maximumStretchDistance) * distance + c13.x);
            controlPoint1.y = (k13 * controlPoint1.x + b13);
        }
        
        // 圆心线和c24的线 l24（计算同上）
        if (c24.x == cp.x) {
            // l24斜率不存在的情况
            controlPoint2.x = c24.x;
            controlPoint2.y = (((cp.y - c24.y) / self.maximumStretchDistance) * distance + c24.y);
        } else {
            // l24斜率存在的情况
            CGFloat k24 = (c24.y - cp.y) / (c24.x - cp.x);
            CGFloat b24 = (c24.x * cp.y - cp.x * c24.y) / (c24.x - cp.x);
            controlPoint2.x = (((cp.x - c24.x) / self.maximumStretchDistance) * distance + c24.x);
            controlPoint2.y = (k24 * controlPoint2.x + b24);
        }
    }
    
    // 画曲线和圆弧
    // 弧度：http://upload-images.jianshu.io/upload_images/1361069-9396924d2f620514?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint startPoint      = p1;
    CGPoint endPoint        = p3;
    
    // 移动到起点位置
    [path moveToPoint:startPoint];
    
    // 画曲线1和圆弧1
    [path addQuadCurveToPoint:endPoint controlPoint:controlPoint1];
    [path addArcWithCenter:cc2 radius:r2 startAngle:angle endAngle:(angle + M_PI) clockwise:YES];
    
    // 曲线2和圆弧2
    endPoint = p2;
    [path addQuadCurveToPoint:endPoint controlPoint:controlPoint2];
    [path addArcWithCenter:cc1 radius:r1 startAngle:(angle + M_PI) endAngle:angle clockwise:YES];
    
    [path closePath];
    
    // 设置layer
    layer.path          = path.CGPath;
    layer.fillColor     = self.elasticColor.CGColor;
    layer.strokeColor   = self.elasticColor.CGColor;
    
    // update layer
    [self.elasticLayer removeFromSuperlayer];
    self.elasticLayer = layer;
    [self.superview.layer insertSublayer:self.elasticLayer below:self.view.layer];
}

@end
