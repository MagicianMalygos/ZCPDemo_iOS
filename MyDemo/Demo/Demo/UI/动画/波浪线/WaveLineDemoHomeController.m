//
//  WaveLineDemoHomeController.m
//  Demo
//
//  Created by 朱超鹏 on 2017/11/22.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "WaveLineDemoHomeController.h"

@interface WaveLineDemoHomeController ()

/// 定时器
@property (nonatomic, strong) CADisplayLink *displayLink;
/// 相位
@property (nonatomic, assign) CGFloat q;

/// 波浪线1
@property (nonatomic, strong) CAShapeLayer *waveLayer1;
/// 波浪线1
@property (nonatomic, strong) CAShapeLayer *waveLayer2;

/// 波浪线3
@property (nonatomic, strong) CAShapeLayer *waveLayer3_1;
/// 波浪线3
@property (nonatomic, strong) CAShapeLayer *waveLayer3_2;
/// 波浪线3
@property (nonatomic, strong) CAShapeLayer *waveLayer3_3;

@end

@implementation WaveLineDemoHomeController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view.layer addSublayer:self.waveLayer1];
    [self.view.layer addSublayer:self.waveLayer2];
    [self.view.layer addSublayer:self.waveLayer3_1];
    [self.view.layer addSublayer:self.waveLayer3_2];
    [self.view.layer addSublayer:self.waveLayer3_3];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 开启定时器
    self.displayLink.paused = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 关闭定时器
    self.displayLink.paused = YES;
    
    if (self.isMovingFromParentViewController) {
        [_displayLink invalidate];
        _displayLink = nil;
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // 设置frame
    self.waveLayer1.frame   = CGRectMake(0, 0, self.view.width, 100);
    self.waveLayer2.frame   = CGRectMake(0, 100, self.view.width, 100);
    self.waveLayer3_1.frame = CGRectMake(0, 200, self.view.width, 100);
    self.waveLayer3_2.frame = CGRectMake(0, 200, self.view.width, 100);
    self.waveLayer3_3.frame = CGRectMake(0, 200, self.view.width, 100);
}

#pragma mark - draw wave

/**
 绘制波浪线1
 */
- (void)drawWaveLine1 {
    // y = Asin（ωx+φ）+ k
    CGFloat A = 20.0;   // 振幅
    CGFloat w = 1/40.0; // 周期
    CGFloat q = self.q; // 相位
    CGFloat k = 50;     // 竖直方向偏移
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, self.waveLayer1.height / 2.0);
    
    for (int i = 0; i <= self.waveLayer1.width; i++) {
        CGFloat y = A * sin(w * i + q) + k;
        CGPathAddLineToPoint(path, NULL, i, y);
    }
    
    self.waveLayer1.path = path;
    CGPathRelease(path);
}


/**
 绘制波浪线2
 */
- (void)drawWaveLine2 {
    // y = Asin（ωx+φ）+ k
    CGFloat A = 20.0;   // 振幅
    CGFloat w = 1/40.0; // 周期
    CGFloat q = self.q; // 相位
    CGFloat k = 50;     // 竖直方向偏移
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, self.waveLayer2.height / 2.0)];
    
    for (int i = 0; i <= self.waveLayer2.width; i++) {
        CGFloat y = A * sin(w * i + q) + k;
        [path addLineToPoint:CGPointMake(i, y)];
    }
    
    [path addLineToPoint:CGPointMake(self.waveLayer2.width, self.waveLayer2.height)];
    [path addLineToPoint:CGPointMake(0, self.waveLayer2.height)];
    [path closePath];
    
    self.waveLayer2.path = path.CGPath;
}

/**
 绘制波浪线3
 */
- (void)drawWaveLine3 {
    {
        // y = Asin（ωx+φ）+ k
        CGFloat A = 20.0;       // 振幅
        CGFloat w = 1/40.0;     // 周期
        CGFloat q = self.q + 1; // 相位
        CGFloat k = 50;         // 竖直方向偏移
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, self.waveLayer2.height / 2.0)];
        
        for (int i = 0; i <= self.waveLayer2.width; i++) {
            CGFloat y = A * sin(w * i + q) + k;
            [path addLineToPoint:CGPointMake(i, y)];
        }
        
        [path addLineToPoint:CGPointMake(self.waveLayer2.width, self.waveLayer2.height)];
        [path addLineToPoint:CGPointMake(0, self.waveLayer2.height)];
        [path closePath];
        
        self.waveLayer3_1.path = path.CGPath;
    }
    
    {
        // y = Asin（ωx+φ）+ k
        CGFloat A = 20.0;       // 振幅
        CGFloat w = 1/50.0;     // 周期
        CGFloat q = self.q + 3; // 相位
        CGFloat k = 50;         // 竖直方向偏移
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, self.waveLayer2.height / 2.0)];
        
        for (int i = 0; i <= self.waveLayer2.width; i++) {
            CGFloat y = A * sin(w * i + q) + k;
            [path addLineToPoint:CGPointMake(i, y)];
        }
        
        [path addLineToPoint:CGPointMake(self.waveLayer2.width, self.waveLayer2.height)];
        [path addLineToPoint:CGPointMake(0, self.waveLayer2.height)];
        [path closePath];
        
        self.waveLayer3_2.path = path.CGPath;
    }
    
    {
        // y = Asin（ωx+φ）+ k
        CGFloat A = 20.0;       // 振幅
        CGFloat w = 1/60.0;     // 周期
        CGFloat q = self.q + 5; // 相位
        CGFloat k = 50;         // 竖直方向偏移
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, self.waveLayer2.height / 2.0)];
        
        for (int i = 0; i <= self.waveLayer2.width; i++) {
            CGFloat y = A * sin(w * i + q) + k;
            [path addLineToPoint:CGPointMake(i, y)];
        }
        
        [path addLineToPoint:CGPointMake(self.waveLayer2.width, self.waveLayer2.height)];
        [path addLineToPoint:CGPointMake(0, self.waveLayer2.height)];
        [path closePath];
        
        self.waveLayer3_3.path = path.CGPath;
    }
}

#pragma mark - event response

- (void)updateWaveLine {
    self.q += 0.01;
    [self drawWaveLine1];
    [self drawWaveLine2];
    [self drawWaveLine3];
}

#pragma mark - getters and setters

- (CADisplayLink *)displayLink {
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateWaveLine)];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _displayLink;
}

- (CAShapeLayer *)waveLayer1 {
    if (!_waveLayer1) {
        _waveLayer1 = [CAShapeLayer layer];
        _waveLayer1.fillColor = nil;
        _waveLayer1.lineWidth = 2.0f;
        _waveLayer1.strokeColor = [UIColor colorFromHexRGB:@"bfefff"].CGColor;
        _waveLayer1.borderWidth = 1.0;
        _waveLayer1.borderColor = [UIColor greenColor].CGColor;
    }
    return _waveLayer1;
}

- (CAShapeLayer *)waveLayer2 {
    if (!_waveLayer2) {
        _waveLayer2 = [CAShapeLayer layer];
        _waveLayer2.fillColor = [UIColor colorFromHexRGB:@"bfefff"].CGColor;
        _waveLayer2.lineWidth = 1.0;
        _waveLayer2.strokeColor = [UIColor colorFromHexRGB:@"bfefff"].CGColor;
        _waveLayer2.borderWidth = 1.0;
        _waveLayer2.borderColor = [UIColor greenColor].CGColor;
    }
    return _waveLayer2;
}

- (CAShapeLayer *)waveLayer3_1 {
    if (!_waveLayer3_1) {
        _waveLayer3_1 = [CAShapeLayer layer];
        _waveLayer3_1.fillColor = [UIColor colorFromHex:0xccbfefff].CGColor;
        _waveLayer3_1.lineWidth = 1.0;
        _waveLayer3_1.strokeColor = [UIColor colorFromHex:0xccbfefff].CGColor;
        _waveLayer3_1.borderWidth = 1.0;
        _waveLayer3_1.borderColor = [UIColor greenColor].CGColor;
    }
    return _waveLayer3_1;
}

- (CAShapeLayer *)waveLayer3_2 {
    if (!_waveLayer3_2) {
        _waveLayer3_2 = [CAShapeLayer layer];
        _waveLayer3_2.fillColor = [UIColor colorFromHex:0xcc87ceff].CGColor;
        _waveLayer3_2.lineWidth = 1.0;
        _waveLayer3_2.strokeColor = [UIColor colorFromHex:0xcc87ceff].CGColor;
        _waveLayer3_2.borderWidth = 1.0;
        _waveLayer3_2.borderColor = [UIColor greenColor].CGColor;
    }
    return _waveLayer3_2;
}

- (CAShapeLayer *)waveLayer3_3 {
    if (!_waveLayer3_3) {
        _waveLayer3_3 = [CAShapeLayer layer];
        _waveLayer3_3.fillColor = [UIColor colorFromHex:0xcc6495ed].CGColor;
        _waveLayer3_3.lineWidth = 1.0;
        _waveLayer3_3.strokeColor = [UIColor colorFromHex:0xcc6495ed].CGColor;
        _waveLayer3_3.borderWidth = 1.0;
        _waveLayer3_3.borderColor = [UIColor greenColor].CGColor;
    }
    return _waveLayer3_3;
}

@end
