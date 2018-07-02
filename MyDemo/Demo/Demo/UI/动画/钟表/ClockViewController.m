//
//  ClockViewController.m
//  Demo
//
//  Created by 朱超鹏 on 2018/6/28.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "ClockViewController.h"
#import "FoldClockView.h"
#import "FoldClockLabel.h"
#import "FoldClockItemView.h"

@interface ClockViewController ()

@property (nonatomic, strong) FoldClockView *foldClock;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) FoldClockLabel *clockLabel;
@property (nonatomic, strong) FoldClockItemView *clockItemView;
@property (nonatomic, assign) int currTime;

@end

@implementation ClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    
    // FIXME: label右边都有一个黑线
    // FIXME: 所有font和text属性的梳理
    self.clockLabel = [[FoldClockLabel alloc] initWithTime:0];
    self.clockLabel.backgroundColor = [UIColor grayColor];
    self.clockLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.clockLabel];
    
    self.clockItemView = [[FoldClockItemView alloc] init];
    self.clockItemView.backgroundColor = [UIColor grayColor];
    self.clockItemView.textColor = [UIColor whiteColor];
    [self.view addSubview:self.clockItemView];
    
    // FIXME: 初始状态下，不显示0
    self.foldClock = [[FoldClockView alloc] init];
    self.foldClock.date = [NSDate date];
    [self.view addSubview:self.foldClock];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.clockLabel.frame       = CGRectMake(10, 50, 150, 100);
    self.clockItemView.frame    = CGRectMake(10, 200, 150, 100);
    self.foldClock.frame        = CGRectMake(10, 350, self.view.width - 20, 150);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.isMovingFromParentViewController) {
        if (_timer != nil) {
            [_timer invalidate];
            _timer = nil;
        }
    }
}

- (void)updateTime {
    self.currTime += 1;
    if (self.currTime > 99) {
        self.currTime = 0;
    }
    [self.clockLabel updateTime:[@(self.currTime) stringValue]];
    
    [self.clockItemView updateTime:self.currTime];
    
    self.foldClock.date = [NSDate date];
}

@end
