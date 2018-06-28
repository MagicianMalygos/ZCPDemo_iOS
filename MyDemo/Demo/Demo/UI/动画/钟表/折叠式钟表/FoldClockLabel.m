//
//  FoldClockLabel.m
//  Demo
//
//  Created by 朱超鹏 on 2018/6/28.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "FoldClockLabel.h"

@interface FoldClockLabel ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *nextLabel;
@property (nonatomic, strong) UILabel *foldLabel;

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CGFloat currTime;

@end

@implementation FoldClockLabel

#pragma mark - life cycle

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.timeLabel];
        [self addSubview:self.nextLabel];
        [self addSubview:self.foldLabel];
        
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTime)];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bgView.frame = self.bounds;
    self.timeLabel.frame = self.bounds;
    self.nextLabel.frame = self.bounds;
    self.foldLabel.frame = self.bounds;
}

#pragma mark - public

- (void)updateTime:(NSInteger)time nextTime:(NSInteger)nextTime {
    self.timeLabel.text = [NSString stringWithFormat:@"%zd",time];
    self.foldLabel.text = [NSString stringWithFormat:@"%zd",time];
    self.nextLabel.text = [NSString stringWithFormat:@"%zd",nextTime];
    self.nextLabel.layer.transform = CATransform3DMakeRotation(M_PI * 0.01, -1, 0, 0);
    self.nextLabel.hidden = YES;
    self.currTime = 0;
    [self start];
}

#pragma mark - private

- (void)configureLabel:(UILabel *)label {
    // 可配值
    label.font = [UIFont boldSystemFontOfSize:80.0f];
    label.textColor = [UIColor blackColor];
    
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor whiteColor];
}

#pragma mark - time

- (void)start {
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stop {
    [self.displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)updateTime {
    int maxTime = 4;
    self.currTime += 2.0/60.0;
    
    // (0, 0) (2 M_PI_2) (4 M_PI)
    // y = π/4 * x
    
    // x轴反转 从 0~M_PI
    CATransform3D transform = CATransform3DIdentity;
    CGFloat angle = M_PI_4 * self.currTime;
    angle = (self.currTime >= maxTime) > M_PI ? M_PI:angle;
    transform = CATransform3DRotate(transform, M_PI_4 * self.currTime, -1, 0, 0);
    
    if (angle > M_PI * 0.01) {
        self.nextLabel.hidden = NO;
    }
    
    // 如果x >= 2 则在y轴上反转M_PI一次
    if (self.currTime >= 2) {
        transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
        transform = CATransform3DRotate(transform, M_PI, 0, 0, 1);
        self.foldLabel.text = self.nextLabel.text;
    }
    
    self.foldLabel.layer.transform = transform;
    
    // 如果x >= 4 则结束反转
    if (self.currTime >= maxTime) {
        self.timeLabel.text = self.nextLabel.text;
        [self stop];
    }
}

#pragma mark - getters and setters

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        [self configureLabel:_timeLabel];
    }
    return _timeLabel;
}

- (UILabel *)foldLabel {
    if (!_foldLabel) {
        _foldLabel = [[UILabel alloc] init];
        [self configureLabel:_foldLabel];
    }
    return _foldLabel;
}

- (UILabel *)nextLabel {
    if (!_nextLabel) {
        _nextLabel = [[UILabel alloc] init];
        [self configureLabel:_nextLabel];
    }
    return _nextLabel;
}

@end
