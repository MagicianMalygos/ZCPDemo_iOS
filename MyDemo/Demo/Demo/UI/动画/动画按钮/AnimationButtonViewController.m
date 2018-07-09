//
//  AnimationButtonViewController.m
//  Demo
//
//  Created by 朱超鹏 on 2018/7/3.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "AnimationButtonViewController.h"
#import "AnimationButton1.h"
#import "AnimationButton2.h"

@interface AnimationButtonViewController () <AnimationButton1Delegate>

/// 汉堡包按钮
@property (nonatomic, strong) AnimationButton1 *button1;
@property (nonatomic, strong) AnimationButton2 *button2;

@end

@implementation AnimationButtonViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.button1 = [[AnimationButton1 alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.button1.delegate = self;
    [self.view addSubview:self.button1];
    
    self.button2 = [[AnimationButton2 alloc] initWithFrame:CGRectMake(100, 0, 100, 100)];
    self.button2.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.button2];
}

#pragma mark - AnimationButton1Delegate

- (void)animationButtonDidClick:(AnimationButton1 *)button {
    NSLog(@"点击了汉堡包按钮");
    self.button1.lineColor = RANDOM_COLOR;
}

- (void)animationButtonDidStopAnimation:(AnimationButton1 *)button finished:(BOOL)flag {
    if (flag) {
        NSLog(@"汉堡包按钮动画结束");
    } else {
        NSLog(@"汉堡包按钮动画中断");
    }
}

@end
