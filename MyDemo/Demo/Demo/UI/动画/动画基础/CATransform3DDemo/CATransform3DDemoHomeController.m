//
//  CATransform3DDemoHomeController.m
//  Demo
//
//  Created by 朱超鹏(外包) on 17/2/21.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "CATransform3DDemoHomeController.h"
#import <QuartzCore/QuartzCore.h>

/*
 动画基类（基类）
 CAAnimation    :NSObject <NSSecureCoding, NSCopying, CAMediaTiming, CAAction>
    delegate            id <CAAnimationDelegate>    strong类型
    timingFunction      CAMediaTimingFunction*      动画节奏，默认为nil表示线性节奏
    removedOnCompletion BOOL                        YES当动画结束后移除动画，NO当动画结束后不移除。需要与kCAFillModeForwards组合使用，仅设置它为NO是不起作用的。
 
    timingFunction有以下几种：
        kCAMediaTimingFunctionLinear:           匀速
        kCAMediaTimingFunctionEaseIn:           慢进
        kCAMediaTimingFunctionEaseOut:          慢出
        kCAMediaTimingFunctionEaseInEaseOut:    慢进慢出
        kCAMediaTimingFunctionDefault:          默认
        functionWithControlPoints:c1x :c1y :c2x :c2y: (0,0)(1,1)为直线，(c1x, c1y)(c2x, c2y)为控制点，直线会向控制点拉伸然后组成一个曲线图形。x为时间均匀从0~1，构成的曲线不同，y走的快慢也不同。这就是如何用控制点来控制动画的执行快慢。https://zsisme.gitbooks.io/ios-/content/chapter10/custom-easing-functions.html
 
 
 
 CAMediaTiming
    beginTime           CFTimeInterval(double)      开始时间，如果想要设置为当前时间+2s，需要设置为CACurrentMediaTime() + 2，默认为0
    duration            CFTimeInterval(double)      持续时间，默认为0
    speed               float                       速度倍数（相对于父时间环境）
    timeOffset          CFTimeInterval(double)      动画执行的时间偏移量，默认为0
    repeatCount         float                       重复次数，不能和repeatDuration同时使用，可以为分数，默认为0
    repeatDuration      CFTimeInterval(double)      在指定时间内重复执行，不能和repeatCount同时使用，默认为0
    autoreverses        BOOL                        自动反转，动画执行结束后再反向执行，默认为NO
    fillMode            NSString*                   定义计时对象在其活动持续时间之外的行为，默认为removed
    有以下几个值：
        kCAFillModeForwards:    'forwards'              动画结束后保持状态。需要将removedOnCompletion设置为NO，仅设置该模式是不起作用的。
        kCAFillModeBackwards:   'backwards'             如果设置了beginTime，该模式的效果为：会先将对象设置到动画初始状态，然后等待beginTime之后再执行动画。未设置该模式的效果为：等待beginTime之后再瞬间将对象设置到动画初始状态，然后再执行动画。
        kCAFillModeBoth:        'both'                  forwards + backward的组合效果
        kCAFillModeRemoved:     'removed'               动画结束后移除
 

 动画回调，开始/结束
 CAAnimationDelegate
    当动画开始时
    - (void)animationDidStart:(CAAnimation *)anim;
    当动画执行完毕或动画被移除时，flag YES动画执行完毕 NO动画被移除
    - (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;
 
 
 属性动画，可设定参与动画的属性（抽象类）
 CAPropertyAnimation :CAAnimation
    创建参与动画的指定属性的动画对象
    + (instancetype)animationWithKeyPath:(nullable NSString *)path;
    keyPath             nil                         表述了执行动画的属性
    additive            BOOL                        多步动画执行时每一步的值是否是初始状态的相对值
    cumulative          BOOL                        动画在重复执行时属性是否以前一个动画的结束做累加
    valueFunction       CAValueFunction*            设置操作transform具体某条属性的参数，可以被keyPath替代，如kCAValueFunctionRotateX等价于transform.scale.x，默认为nil
 
 
 基础动画，可设定动画的执行起点值和终点值
 CABasicAnimation   :CAPropertyAnimation
    fromValue           id                          动画属性起始值
    toValue             id                          动画属性结束值
    byValue             id                          动画属性结束值
 
    设值有以下几种情况：
        fromValue & toValue:   fromValue ~ toValue
        fromValue & byValue:   fromValue ~ fromValue + byValue
        toValue & byValue:     toValue - byValue ~ toValue
        fromValue:             fromValue ~ currValue
        toValue:               currValue ~ toValue
        byValue:               currValue ~ currValue + byValue
 
 
 通用关键帧动画
 CAKeyframeAnimation    :CAPropertyAnimation
    values              NSArray*                    关键帧值数组，每个值表示属性的一个状态，当additive为YES时每个值都是动画执行前当前状态的相对值
    keyTimes            NSArray<NSNumber *>*        动画执行的节奏，表示在某个时间比例到达某个value值，每个值都与values中的值对应，数组中的每个值是[0, 1]的浮点value。计算方法：在keyTimes[i] * duration这个时间点运动到对应的value状态
    timingFunctions     NSArray<CAMediaTimingFunction *>*   执行每一步动画的节奏，数量比values.cout小1
    path                CGPathRef                   关键帧路径，优先级比values大
    calculationMode     NSString*                   动画计算模式，默认为kCAAnimationLinear
 
    动画计算模式calculationMode有以下几种：
        kCAAnimationLinear:     关键帧为坐标点的时候，关键帧之间直接直线相连进行插值计算
        kCAAnimationDiscrete:   离散的,也就是没有补间动画（每个两个关键帧之间系统形成的动画成为补间动画）
        kCAAnimationPaced:      平均。keyTimes、timeFunctions失效
        kCAAnimationCubic:      对关键帧为坐标点的关键帧进行圆滑曲线相连后插值计算，对于曲线的形状还可以通过tensionValues,continuityValues,biasValues来进行调整自定义。keyTimes、timeFunctions失效
        kCAAnimationCubicPaced: 在kCAAnimationCubic的基础上使得动画运行变得均匀，就是系统时间内运动的距离相同。keyTimes、timeFunctions失效
 
    tensionValues       NSArray<NSNumber *>*        动画的张力
    continuityValues    NSArray<NSNumber *>*        动画的连续性值
    biasValues          NSArray<NSNumber *>*        动画的偏斜率
 
    rotationMode        NSString*                   动画沿路径旋转方式
    动画沿路径旋转方式rotationMode有以下几种：
        kCAAnimationRotateAuto:         自动旋转
        kCAAnimationRotateAutoReverse:  自动翻转
 
 质量弹簧动画
 CASpringAnimation  :CABasicAnimation
    mass                CGFloat                     弹簧悬挂重物的质量，影响惯性，必须大于0，默认为1
    stiffness           CGFloat                     弹簧的刚性系数，值越大回弹越快，必须大于0，默认为100
    damping             CGFloat                     弹簧的阻尼，值越大回弹幅度越小，必须大于等于0，默认为10
    initialVelocity     CGFloat                     初始速度，默认为0
    settlingDuration    CFTimeInterval              持续时间的预估值，readonly
 
 过渡动画
 CATransition   :CAAnimation
    type                NSString*                   过渡类型，包括：fade、moveIn、push、reveal，默认为fade
    subtype             NSString*                   过渡的子类型，包括：`fromLeft', `fromRight', `fromTop'、`fromBottom'
    startProgress       float                       开始进度，如果设置为0.3动画将从0.3部分开始，范围为[0, 1]，默认为0
    endProgress         float                       结束进度，如果设置为0.6动画执行到0.6部分以后结束，一定要大于或等于startProgress，范围为[0, 1]，默认为1
 
 动画组
 CAAnimationGroup   :CAAnimation
    animations          NSArray<CAAnimation *>*     动画数组
 
 ps：
     1.
     lifetime    生命期
     plus/minus  加/减
 
 */


@interface CATransform3DDemoHomeController () <CAAnimationDelegate>

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *animationView;

@end

@implementation CATransform3DDemoHomeController

@synthesize infoArr = _infoArr;

// ----------------------------------------------------------------------
#pragma mark - life cycle
// ----------------------------------------------------------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.layer.borderWidth = 1;
    self.tableView.layer.borderColor = [UIColor redColor].CGColor;
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.animationView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame        = CGRectMake(0, 0, self.view.width, 200);
    self.contentView.frame      = CGRectMake(0, self.tableView.bottom, self.view.width, self.view.height - self.tableView.height);
    self.animationView.frame    = CGRectMake(self.view.centerX - 25, 0, 50, 50);
}

#pragma mark - override

- (NSMutableArray *)infoArr {
    if (_infoArr == nil) {
        _infoArr = @[@{@"title": @"Move", @"method": [NSValue valueWithPointer:@selector(testMove)]},
                     @{@"title": @"Spring", @"method": [NSValue valueWithPointer:@selector(testSpring)]},
                     @{@"title": @"Path", @"method": [NSValue valueWithPointer:@selector(testPath)]}
                     ].mutableCopy;
    }
    return _infoArr;
}

- (void)constructData {
    [super constructData];
    for (ZCPSectionCellItem *item in self.tableViewAdaptor.items) {
        item.sectionTitleFont       = [UIFont systemFontOfSize:15.0f];
        item.cellHeight             = @(40.0f);
    }
}

// ----------------------------------------------------------------------
#pragma mark - ZCPListTableViewAdaptorDelegate
// ----------------------------------------------------------------------

- (void)tableView:(UITableView *)tableView didSelectObject:(id<ZCPTableViewCellItemBasicProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath {
    SEL sel                             = [self.infoArr[indexPath.row][@"method"] pointerValue];
    NSMethodSignature *methodSignature  = [self methodSignatureForSelector:sel];
    NSInvocation *invocation            = [NSInvocation invocationWithMethodSignature:methodSignature];
    invocation.target                   = self;
    invocation.selector                 = sel;
    [invocation invoke];
}


#pragma mark - event response

- (void)testMove {
    CGFloat W = self.contentView.width;
    CGFloat H = self.contentView.height;
    
    CAKeyframeAnimation *animation  = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.values                = @[@(CGPointMake(0, 0)),
                                        @(CGPointMake(W, 0)),
                                        @(CGPointMake(W, H)),
                                        @(CGPointMake(0, H)),
                                        @(CGPointMake(0, 0))];
    animation.keyTimes              = @[@0, @0.25, @0.5, @0.75, @1];
    animation.timingFunctions       = @[[CAMediaTimingFunction functionWithControlPoints:1 :0 :1 :1],
                                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    animation.duration              = 12;
    [self.animationView.layer addAnimation:animation forKey:nil];
}

- (void)testSpring {
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"position.y"];
    animation.mass              = 5;
    animation.stiffness         = 150;
    animation.damping           = 5;
    animation.initialVelocity   = 0;
    animation.duration          = animation.settlingDuration;
    animation.fromValue         = @(self.animationView.layer.position.y);
    animation.toValue           = @(self.animationView.layer.position.y + 100);
    animation.fillMode          = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.delegate          = self;
    [self.animationView.layer addAnimation:animation forKey:nil];
}

- (void)testPath {
    CGFloat W = self.contentView.width;
    CGFloat W_2 = W / 2;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addArcWithCenter:CGPointMake(W_2, 0) radius:W_2 startAngle:M_PI endAngle:0 clockwise:NO];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.duration = 2;
    [self.animationView.layer addAnimation:animation forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.animationView.layer removeAllAnimations];
}

// ----------------------------------------------------------------------
#pragma mark - getters and setters
// ----------------------------------------------------------------------

- (UIImageView *)animationView {
    if (!_animationView) {
        _animationView          = [[UIImageView alloc] init];
        _animationView.image    = [UIImage imageNamed:@"taiji"];
    }
    return _animationView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.layer.borderColor = [UIColor greenColor].CGColor;
        _contentView.layer.borderWidth = 1;
    }
    return _contentView;
}

@end
