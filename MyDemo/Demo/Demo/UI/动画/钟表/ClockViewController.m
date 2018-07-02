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
    
    self.clockLabel                 = [[FoldClockLabel alloc] initWithTime:@"0"];
    self.clockItemView              = [[FoldClockItemView alloc] init];
    self.foldClock                  = [[FoldClockView alloc] init];
    
    [self.view addSubview:self.clockLabel];
    [self.view addSubview:self.clockItemView];
    [self.view addSubview:self.foldClock];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.clockLabel.frame       = CGRectMake(10, 50, 120, 100);
    self.clockItemView.frame    = CGRectMake(self.view.width - 130, 50, 120, 100);
    self.foldClock.frame        = CGRectMake(10, 200, self.view.width - 20, 150);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
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
