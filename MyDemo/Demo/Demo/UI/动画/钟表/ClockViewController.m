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

@interface ClockViewController ()

@property (nonatomic, strong) FoldClockView *foldClock;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.foldClock = [[FoldClockView alloc] init];
//    self.foldClock.date = [NSDate date];
//    [self.view addSubview:self.foldClock];
//
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    
    FoldClockLabel *clockLabel = [[FoldClockLabel alloc] init];
    clockLabel.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:clockLabel];
    
    [clockLabel updateTime:1 nextTime:2];
}

- (void)updateTime {
    self.foldClock.date = [NSDate date];
}

@end
