//
//  CASection11Demo.m
//  Demo
//
//  Created by 朱超鹏 on 2018/8/27.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "CASection11Demo.h"

/// 间隔多少帧执行一次
static NSInteger FrameInterval;
/// 执行一次的时间
static CGFloat OneExecuteTime;

@interface CASection11Demo ()

@property (nonatomic, strong) NSTimer       *timer1;
@property (nonatomic, strong) CADisplayLink *timer2;
@property (nonatomic, strong) CADisplayLink *timer3;

@property (nonatomic, strong) UIView *moveView1;
@property (nonatomic, strong) UIView *moveView2;
@property (nonatomic, strong) UIView *moveView3;

@property (nonatomic, assign) CGFloat fromValue;
@property (nonatomic, assign) CGFloat toValue;
@property (nonatomic, assign) NSTimeInterval duration;

@property (nonatomic, assign) NSTimeInterval timeOffset1;
@property (nonatomic, assign) NSTimeInterval timeOffset2;
@property (nonatomic, assign) NSTimeInterval timeOffset3;
@property (nonatomic, assign) NSTimeInterval lastStep;

@end

@implementation CASection11Demo

// ----------------------------------------------------------------------
#pragma mark - demo
// ----------------------------------------------------------------------

#pragma mark 定时帧
- (void)demo1 {
    UIButton *button        = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame            = CGRectMake(0, 0, 150, 50);
    button.center           = CGPointMake(self.width / 2, 35);
    button.backgroundColor  = [UIColor redColor];
    [button setTitle:@"点击开始动画" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    self.moveView1 = ({
        UIView *view            = [[UIView alloc] init];
        view.frame              = CGRectMake(0, 70, 100, 100);
        view.backgroundColor    = [UIColor redColor];
        view;
    });
    [self addSubview:self.moveView1];
    
    self.moveView2 = ({
        UIView *view            = [[UIView alloc] init];
        view.frame              = CGRectMake(0, 180, 100, 100);
        view.backgroundColor    = [UIColor redColor];
        view;
    });
    [self addSubview:self.moveView2];
    
    self.moveView3 = ({
        UIView *view            = [[UIView alloc] init];
        view.frame              = CGRectMake(0, 290, 100, 100);
        view.backgroundColor    = [UIColor redColor];
        view;
    });
    [self addSubview:self.moveView3];
}

#pragma mark <help method>

- (void)click {
    FrameInterval       = 1;
    OneExecuteTime      = 1.0 / (60 / FrameInterval);
    
    self.fromValue      = 50;
    self.toValue        = self.width - 50;
    self.duration       = 2.0f;
    self.timeOffset1    = 0.0f;
    self.timeOffset2    = 0.0f;
    self.timeOffset3    = 0.0f;
    
    [self clearTimer];
    
    // 1 timer
    // 使用定时器。上个任务完成之后就开启执行，如果上个任务执行过久，则下一个任务会延迟很久。
    self.timer1 = [NSTimer scheduledTimerWithTimeInterval:OneExecuteTime target:self selector:@selector(fire1) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer1 forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] addTimer:self.timer1 forMode:UITrackingRunLoopMode];
    
    // 2 displayLink
    // 使用系统屏幕刷新定时器，屏幕每次刷新之前都会执行一次。如果丢失帧，就会直接忽略，然后下一次更新时接着运行。
    self.timer2 = [CADisplayLink displayLinkWithTarget:self selector:@selector(fire2)];
    self.timer2.frameInterval = FrameInterval;
    [self.timer2 addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.timer2 addToRunLoop:[NSRunLoop currentRunLoop] forMode:UITrackingRunLoopMode];
    
    // 3 计算帧持续时间
    // 手动测量每一帧的持续时间
    self.lastStep = CACurrentMediaTime();
    self.timer3 = [CADisplayLink displayLinkWithTarget:self selector:@selector(fire3)];
    self.timer3.frameInterval = FrameInterval;
    [self.timer3 addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.timer3 addToRunLoop:[NSRunLoop currentRunLoop] forMode:UITrackingRunLoopMode];
}

- (void)fire1 {
    // 模拟一个耗时的操作
    for (int i = 0; i < 100000; i++) {
        NSMutableArray *arr = [NSMutableArray array];
        [arr addObject:@"1"];
        [arr removeObject:@"1"];
    }
    
    self.timeOffset1        = MIN(self.timeOffset1 + OneExecuteTime, self.duration);
    CGFloat value           = (self.toValue - self.fromValue)/self.duration * self.timeOffset1 + self.fromValue;
    self.moveView1.centerX  = value;
    
    if (self.timeOffset1 == self.duration &&
        self.timeOffset2 == self.duration &&
        self.timeOffset3 == self.duration) {
        [self clearTimer];
    }
}

- (void)fire2 {
    static int cout;
    NSLog(@"%d", cout++);
    
    self.timeOffset2        = MIN(self.timeOffset2 + OneExecuteTime, self.duration);
    CGFloat value           = (self.toValue - self.fromValue)/self.duration * self.timeOffset2 + self.fromValue;
    self.moveView2.centerX  = value;
    
    if (self.timeOffset1 == self.duration &&
        self.timeOffset2 == self.duration &&
        self.timeOffset3 == self.duration) {
        [self clearTimer];
    }
}

- (void)fire3 {
    CFTimeInterval thisStep = CACurrentMediaTime();
    CFTimeInterval stepDuration = thisStep - self.lastStep;
    self.lastStep           = thisStep;
    self.timeOffset3        = MIN(self.timeOffset3 + stepDuration, self.duration);
    CGFloat value           = (self.toValue - self.fromValue)/self.duration * self.timeOffset3 + self.fromValue;
    self.moveView3.centerX  = value;
    
    if (self.timeOffset1 == self.duration &&
        self.timeOffset2 == self.duration &&
        self.timeOffset3 == self.duration) {
        [self clearTimer];
    }
}

- (void)clearTimer {
    if (_timer1) {
        [_timer1 invalidate];
        _timer1 = nil;
    }
    if (_timer2) {
        [_timer2 removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [_timer2 removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:UITrackingRunLoopMode];
        [_timer2 invalidate];
        _timer2 = nil;
    }
    if (_timer3) {
        [_timer3 removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [_timer3 removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:UITrackingRunLoopMode];
        [_timer3 invalidate];
        _timer3 = nil;
    }
}

// ----------------------------------------------------------------------
#pragma mark - life cycle
// ----------------------------------------------------------------------

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview == nil) {
        [self clearTimer];
    }
}

@end
