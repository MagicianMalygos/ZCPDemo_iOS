//
//  WaveLineDemoHomeController.m
//  Demo
//
//  Created by 朱超鹏 on 2017/11/22.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "WaveLineDemoHomeController.h"

@interface WaveLineDemoHomeController ()

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CGFloat q;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation WaveLineDemoHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.displayLink.paused = NO;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self drawWaveLine];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)drawWaveLine {
    
    // remove
    [self.shapeLayer removeFromSuperlayer];
    
    // y = Asin（ωx+φ）+ C
    CGFloat A = 20.0;   // 振幅
    CGFloat w = 1/40.0; // 周期
    CGFloat q = self.q; // 相位
    CGFloat C = 50;     // 竖直方向偏移
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, self.view.height / 2.0);
    
    for (int i = 0; i <= self.view.width; i++) {
        CGFloat y = A * sin(w * i + q) + C;
        CGPathAddLineToPoint(path, NULL, i, y);
    }
    CGPathAddLineToPoint(path, NULL, self.view.width, self.view.height);
    CGPathAddLineToPoint(path, NULL, 0, self.view.height);
    CGPathCloseSubpath(path);
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor colorWithRed:255 green:0 blue:0 alpha:0.3].CGColor;
    shapeLayer.lineWidth = 2.0f;
    shapeLayer.strokeColor = [UIColor blueColor].CGColor;
    shapeLayer.path = path;
    shapeLayer.frame = self.view.bounds;
    shapeLayer.borderColor = [UIColor greenColor].CGColor;
    shapeLayer.borderWidth = 1.0;
    self.shapeLayer = shapeLayer;
    [self.view.layer addSublayer:shapeLayer];
    
    CGPathRelease(path);
}

#pragma mark - event response

- (void)changeWave {
    self.q += 0.01;
    [self drawWaveLine];
}

#pragma mark - getters and setters

- (CADisplayLink *)displayLink {
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeWave)];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _displayLink;
}

@end
