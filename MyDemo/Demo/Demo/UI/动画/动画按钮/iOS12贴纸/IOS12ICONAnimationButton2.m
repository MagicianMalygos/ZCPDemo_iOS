//
//  IOS12ICONAnimationButton2.m
//  Demo
//
//  Created by 朱超鹏 on 2018/7/20.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "IOS12ICONAnimationButton2.h"

#define kAnimation                  @"kAnimation"
#define kAnimationEnd               @"kAnimationEnd"
#define kAnimationEndLineScaleAdd   @"kAnimationEnd_LineScaleAdd"

@interface IOS12ICONAnimationButton2 () <CAAnimationDelegate> {
    // 计算属性
    CGFloat _lineWidth;
}

/// 背景色layer
@property (nonatomic, strong) CALayer *backgroundLayer;
/// 圆形进度条layer
@property (nonatomic, strong) CAShapeLayer *arcProgressBarLayer;
/// 倒计时数字背景色layer
@property (nonatomic, strong) CALayer *numberBackgroundLayer;
/// 倒计时数字
@property (nonatomic, strong) UILabel *numberLabel;

/// 是否正在执行动画
@property (nonatomic, assign, getter=isAnimating) BOOL animating;

/// 当前时间
@property (nonatomic, assign) NSInteger currTime;

@end

@implementation IOS12ICONAnimationButton2

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.layer addSublayer:self.backgroundLayer];
        [self.layer addSublayer:self.numberBackgroundLayer];
        [self.layer addSublayer:self.arcProgressBarLayer];
        [self addSubview:self.numberLabel];
        
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
    // 更新frame
    [self updateFrame];
    
    // 更新控件属性
    [self updateUI];
}

- (void)updateFrame {
    _lineWidth = self.height / 10;
    
    CGPoint center = CGPointMake(self.width / 2, self.height / 2);
    
    self.backgroundLayer.bounds         = CGRectMake(0, 0, self.height, self.height);
    self.backgroundLayer.position       = center;
    self.backgroundLayer.cornerRadius   = self.backgroundLayer.height / 2;
    
    self.arcProgressBarLayer.bounds = CGRectMake(0, 0, self.height, self.height);
    self.arcProgressBarLayer.position = center;
    self.arcProgressBarLayer.cornerRadius = self.arcProgressBarLayer.height / 2;
    
    self.numberLabel.frame              = CGRectMake(0, 0, self.height * 4 / 5, self.height * 4 / 5);
    self.numberLabel.center             = center;
    self.numberBackgroundLayer.bounds   = self.numberLabel.bounds;
    self.numberBackgroundLayer.position = center;
    self.numberBackgroundLayer.cornerRadius = self.numberBackgroundLayer.height / 2;
}

- (void)updateUI {
    // update path
    CGFloat lineWidth   = self.height / 10;
    CGPoint center      = CGPointMake(self.arcProgressBarLayer.width / 2, self.arcProgressBarLayer.height / 2);
    CGFloat radius      = (self.arcProgressBarLayer.height - lineWidth) / 2;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(center.x, lineWidth / 2)];
    [path addArcWithCenter:center radius:radius startAngle:-M_PI_2 endAngle:3*M_PI_2 clockwise:YES];
    self.arcProgressBarLayer.path       = path.CGPath;
    self.arcProgressBarLayer.lineWidth  = lineWidth;
    
    // updata label
    self.numberLabel.font = [UIFont systemFontOfSize:self.numberLabel.height / 2];
    self.numberLabel.text = [@(self.time) stringValue];
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

- (void)startAnimation {
    if (self.isAnimating) {
        return;
    }
    self.animating = YES;
    
    // 1 sec = 0.5 move + 0.2 scale+ + 0.2 scale- + 0.1 rest
    @weakify(self);
    [self openTimerWithTimeBlock:^{
        // 开始执行每一秒的切换动画
        @strongify(self);
        [self startMoveAnimation];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self startLineWidthAddAnimation];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.numberLabel.text = [@(self.currTime) stringValue];
            [self startLineWidthSubAnimation];
        });
    } endBlock:^{
        [self startEndAnimation];
    }];
}

/// 开始进度条移动动画
- (void)startMoveAnimation {
    CGFloat toValue = 1.0 / self.time * (self.currTime - 1);
    
    // move
    CABasicAnimation *strokeEndAnimation    = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.duration             = 0.5f;
    strokeEndAnimation.toValue              = @(toValue);
    strokeEndAnimation.fillMode             = kCAFillModeForwards;
    strokeEndAnimation.removedOnCompletion  = NO;
    [self addAnimation:strokeEndAnimation forLayer:self.arcProgressBarLayer];
}

/// 开始进度条线条增大动画
- (void)startLineWidthAddAnimation {
    CGFloat lineWidthIncrement = 8;
    
    // lineWidth++
    CABasicAnimation *lineWidthAddAnimation = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    lineWidthAddAnimation.duration          = 0.2f;
    lineWidthAddAnimation.toValue           = @(_lineWidth + lineWidthIncrement);
    lineWidthAddAnimation.fillMode          = kCAFillModeForwards;
    lineWidthAddAnimation.removedOnCompletion = NO;
    [self addAnimation:lineWidthAddAnimation forLayer:self.arcProgressBarLayer];
    
    // numberBackgroundScale--
    CABasicAnimation *scaleSubAnimation     = [CABasicAnimation animationWithKeyPath:@"bounds.size"];
    scaleSubAnimation.duration              = 0.2f;
    scaleSubAnimation.toValue               = @(CGSizeMake(self.height * 4 / 5 - lineWidthIncrement/2, self.height * 4 / 5 - lineWidthIncrement/2));
    scaleSubAnimation.fillMode              = kCAFillModeForwards;
    scaleSubAnimation.removedOnCompletion   = NO;
    [self addAnimation:scaleSubAnimation forLayer:self.numberBackgroundLayer];
    
    // numberScale--
    CABasicAnimation *numberScaleAnimation  = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    numberScaleAnimation.duration           = 0.2f;
    numberScaleAnimation.toValue            = @(0);
    numberScaleAnimation.fillMode           = kCAFillModeForwards;
    numberScaleAnimation.removedOnCompletion = NO;
    [self addAnimation:numberScaleAnimation forLayer:self.numberLabel.layer];
}

/// 开始进度条线条恢复动画
- (void)startLineWidthSubAnimation {
    // lineWidth--
    CABasicAnimation *lineWidthSubAnimation = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    lineWidthSubAnimation.duration          = 0.2f;
    lineWidthSubAnimation.toValue           = @(_lineWidth);
    lineWidthSubAnimation.fillMode          = kCAFillModeForwards;
    lineWidthSubAnimation.removedOnCompletion = NO;
    [self addAnimation:lineWidthSubAnimation forLayer:self.arcProgressBarLayer];
    
    // numberBackgroundScale++
    CABasicAnimation *scaleAddAnimation     = [CABasicAnimation animationWithKeyPath:@"bounds.size"];
    scaleAddAnimation.duration              = 0.2f;
    scaleAddAnimation.toValue               = @(CGSizeMake(self.height * 4 / 5, self.height * 4 / 5));
    scaleAddAnimation.fillMode              = kCAFillModeForwards;
    scaleAddAnimation.removedOnCompletion   = NO;
    [self addAnimation:scaleAddAnimation forLayer:self.numberBackgroundLayer];
    
    // numberScale++
    CABasicAnimation *numberScaleAnimation  = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    numberScaleAnimation.duration           = 0.2f;
    numberScaleAnimation.toValue            = @(1);
    numberScaleAnimation.fillMode           = kCAFillModeForwards;
    numberScaleAnimation.removedOnCompletion = NO;
    [self addAnimation:numberScaleAnimation forLayer:self.numberLabel.layer];
}

/// 最终的结束动画
- (void)startEndAnimation {
    CGFloat lineWidthIncrement = 10;
    
    // move
    CABasicAnimation *strokeEndAnimation    = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.duration             = 0.8f;
    strokeEndAnimation.toValue              = @(1);
    strokeEndAnimation.fillMode             = kCAFillModeForwards;
    strokeEndAnimation.removedOnCompletion  = NO;
    strokeEndAnimation.delegate             = self;
    [strokeEndAnimation setValue:kAnimationEnd forKey:kAnimation];
    [self addAnimation:strokeEndAnimation forLayer:self.arcProgressBarLayer];
    
    // lineWidth++
    CABasicAnimation *lineWidthAddAnimation = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    lineWidthAddAnimation.duration          = 0.1f;
    lineWidthAddAnimation.toValue           = @(_lineWidth + lineWidthIncrement);
    lineWidthAddAnimation.fillMode          = kCAFillModeForwards;
    lineWidthAddAnimation.removedOnCompletion = NO;
    [self addAnimation:lineWidthAddAnimation forLayer:self.arcProgressBarLayer];
    
    // numberBackgroundScale--
    CABasicAnimation *scaleSubAnimation     = [CABasicAnimation animationWithKeyPath:@"bounds.size"];
    scaleSubAnimation.duration              = 0.1f;
    scaleSubAnimation.toValue               = @(CGSizeMake(self.height * 4 / 5 - lineWidthIncrement/2, self.height * 4 / 5 - lineWidthIncrement/2));
    scaleSubAnimation.fillMode              = kCAFillModeForwards;
    scaleSubAnimation.removedOnCompletion   = NO;
    [self addAnimation:scaleSubAnimation forLayer:self.numberBackgroundLayer];
    
    // numberScale--
    CABasicAnimation *numberScaleAddAnimation   = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    numberScaleAddAnimation.duration            = 0.2f;
    numberScaleAddAnimation.toValue             = @(0);
    numberScaleAddAnimation.fillMode            = kCAFillModeForwards;
    numberScaleAddAnimation.removedOnCompletion = NO;
    numberScaleAddAnimation.delegate            = self;
    [numberScaleAddAnimation setValue:kAnimationEndLineScaleAdd forKey:kAnimation];
    [self addAnimation:numberScaleAddAnimation forLayer:self.numberLabel.layer];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // numberScale--
        CABasicAnimation *numberScaleSubAnimation   = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        numberScaleSubAnimation.duration            = 0.2f;
        numberScaleSubAnimation.toValue             = @(1);
        numberScaleSubAnimation.fillMode            = kCAFillModeForwards;
        numberScaleSubAnimation.removedOnCompletion = NO;
        [self addAnimation:numberScaleSubAnimation forLayer:self.numberLabel.layer];
    });
}

- (void)stopAnimation {
    if (self.isAnimating) {
        [self clearAllAnimation];
        self.animating = NO;
        self.numberLabel.text = [@(self.time) stringValue];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (!flag) {
        [self clearAllAnimation];
        self.animating = NO;
        return;
    }
    NSString *key = [anim valueForKey:kAnimation];
    if ([key isEqualToString:kAnimationEnd]) {
        [self clearAllAnimation];
        self.animating = NO;
    } else if ([key isEqualToString:kAnimationEndLineScaleAdd]) {
        self.numberLabel.text = [@(self.time) stringValue];
    }
}

- (void)clearAllAnimation {
    [self.numberBackgroundLayer removeAllAnimations];
    [self.numberLabel.layer removeAllAnimations];
    [self.arcProgressBarLayer removeAllAnimations];
}

#pragma mark <help method>

- (void)openTimerWithTimeBlock:(void(^)(void))timeBlock endBlock:(void(^)(void))endBlock {
    self.currTime = self.time;
    
    // 定时器，会先立马执行一次，然后再每隔一秒重复一次
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    __block dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(source, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(source, ^{
        if (!self.animating) {
            // 如果动画结束，则提前结束定时器
            dispatch_source_cancel(source);
            source = nil;
        }else if (self.currTime <= 0) {
            // 如果时间耗尽，则执行最终的结束动画
            dispatch_source_cancel(source);
            source = nil;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (endBlock) {
                    endBlock();
                }
            });
        } else {
            // 执行每一秒的切换动画
            dispatch_async(dispatch_get_main_queue(), ^{
                // 因为首次是立马执行的，所以先减一，以便于切换到正确的数字
                if (timeBlock) {
                    timeBlock();
                }
                self.currTime --;
            });
        }
    });
    
    dispatch_resume(source);
}

- (void)addAnimation:(CAAnimation *)animation forLayer:(CALayer *)layer {
    if (!self.animating) {
        return;
    }
    [layer addAnimation:animation forKey:nil];
}

#pragma mark - setters

- (void)setFrame:(CGRect)frame {
    CGSize originSize = self.frame.size;
    [super setFrame:frame];
    if (!CGSizeEqualToSize(originSize, frame.size)) {
        [self update];
    }
}

/// 设置倒计时时间
- (void)setTime:(NSInteger)time {
    if (time < 0 || self.animating) {
        return;
    }
    _time = time;
    self.numberLabel.text = [@(self.time) stringValue];
}

#pragma mark - getters

- (CALayer *)backgroundLayer {
    if (!_backgroundLayer) {
        _backgroundLayer                    = [CALayer layer];
        _backgroundLayer.backgroundColor    = [UIColor colorFromHexRGB:@"808000"].CGColor;
        self.backgroundLayer.masksToBounds  = YES;
    }
    return _backgroundLayer;
}

- (CALayer *)numberBackgroundLayer {
    if (!_numberBackgroundLayer) {
        _numberBackgroundLayer                  = [CALayer layer];
        _numberBackgroundLayer.backgroundColor  = [UIColor colorFromHexRGB:@"556b2f"].CGColor;
        _numberBackgroundLayer.masksToBounds    = YES;
    }
    return _numberBackgroundLayer;
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel                        = [[UILabel alloc] init];
        _numberLabel.backgroundColor        = [UIColor clearColor];
        _numberLabel.textAlignment          = NSTextAlignmentCenter;
        _numberLabel.textColor              = [UIColor whiteColor];
    }
    return _numberLabel;
}

- (CAShapeLayer *)arcProgressBarLayer {
    if (!_arcProgressBarLayer) {
        _arcProgressBarLayer                = [CAShapeLayer layer];
        _arcProgressBarLayer.fillColor      = nil;
        _arcProgressBarLayer.strokeColor    = [UIColor colorFromHexRGB:@"adff2f"].CGColor;
        _arcProgressBarLayer.lineCap        = kCALineCapRound;
        _arcProgressBarLayer.lineJoin       = kCALineJoinRound;
        _arcProgressBarLayer.masksToBounds  = YES;
    }
    return _arcProgressBarLayer;
}

@end
