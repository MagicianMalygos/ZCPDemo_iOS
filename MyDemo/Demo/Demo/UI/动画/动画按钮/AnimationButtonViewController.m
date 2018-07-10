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
#import "AnimationButton3.h"

@interface AnimationButtonViewController () <AnimationButton1Delegate, AnimationButton2Delegate>

/// 汉堡包按钮
@property (nonatomic, strong) AnimationButton1 *button1;
@property (nonatomic, strong) AnimationButton2 *button2;
@property (nonatomic, strong) AnimationButton3 *button3;

@end

@implementation AnimationButtonViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.button1 = [[AnimationButton1 alloc] init];
    self.button1.delegate = self;
    [self.view addSubview:self.button1];
    
    self.button2 = [[AnimationButton2 alloc] init];
    self.button2.lineColor = [UIColor colorFromHexRGB:@"23cd23"];
    self.button2.delegate = self;
    [self.view addSubview:self.button2];
    
    self.button3 = [[AnimationButton3 alloc] init];
    [self.view addSubview:self.button3];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    NSArray *arr = @[self.button1, self.button2, self.button3];
    for (int i = 0; i < arr.count; i++) {
        UIView *view    = arr[i];
        CGFloat width   = self.view.width / 3;
        CGFloat height  = 100;
        view.frame = CGRectMake(i%3 * width, i/3 * height, width, height);
    }
}

#pragma mark - AnimationButton1Delegate

- (void)animationButton1DidClick:(AnimationButton1 *)button {
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

#pragma mark - AnimationButton2Delegate

- (void)animationButton2DidClick:(AnimationButton2 *)button {
    NSLog(@"点击了爱奇艺按钮");
}

- (void)animationButtonDidStopAnimation:(AnimationButton2 *)button playing:(BOOL)isPlaying {
    if (isPlaying) {
        NSLog(@"动画结束，当前处于播放状态");
    } else {
        NSLog(@"动画结束，当前处于暂停状态");
    }
}

@end
