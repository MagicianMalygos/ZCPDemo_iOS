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

#import "IOS12ICON.h"

@interface AnimationButtonViewController () <AnimationButtonDelegate>

/// 汉堡包按钮
@property (nonatomic, strong) AnimationButton1 *button1;
/// 爱奇艺播放按钮
@property (nonatomic, strong) AnimationButton2 *button2;
/// 优酷播放按钮
@property (nonatomic, strong) AnimationButton3 *button3;

// iOS12贴纸
@property (nonatomic, strong) IOS12ICONAnimationButton1 *ios12iconButton1;
@property (nonatomic, strong) IOS12ICONAnimationButton2 *ios12iconButton2;
@property (nonatomic, strong) IOS12ICONAnimationButton1 *ios12iconButton3;

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
    self.button3.delegate = self;
    [self.view addSubview:self.button3];
    
    self.ios12iconButton1 = [[IOS12ICONAnimationButton1 alloc] init];
    [self.view addSubview:self.ios12iconButton1];
    self.ios12iconButton2 = [[IOS12ICONAnimationButton2 alloc] init];
    self.ios12iconButton2.time = 10;
    [self.view addSubview:self.ios12iconButton2];
    self.ios12iconButton3 = [[IOS12ICONAnimationButton1 alloc] init];
    [self.view addSubview:self.ios12iconButton3];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    NSMutableArray *arr = [NSMutableArray array];
    
    if (self.button1) [arr addObject:self.button1];
    if (self.button2) [arr addObject:self.button2];
    if (self.button3) [arr addObject:self.button3];
    if (self.ios12iconButton1) [arr addObject:self.ios12iconButton1];
    if (self.ios12iconButton2) [arr addObject:self.ios12iconButton2];
    if (self.ios12iconButton3) [arr addObject:self.ios12iconButton3];
    
    for (int i = 0; i < arr.count; i++) {
        UIView *view    = arr[i];
        CGFloat width   = self.view.width / 3;
        CGFloat height  = 100;
        view.frame = CGRectMake(i%3 * width, i/3 * height, width, height);
    }
}

#pragma mark - AnimationButtonDelegate

- (void)animationButtonDidClick:(UIView *)button {
    if (button == self.button1) {
        NSLog(@"点击了汉堡包按钮");
        self.button1.lineColor = RANDOM_COLOR;
    } else if (button == self.button2) {
        NSLog(@"点击了爱奇艺播放按钮");
    } else if (button == self.button3) {
        NSLog(@"点击了优酷播放按钮");
    }
}

- (void)animationButtonDidStopAnimation:(UIView *)button state:(BOOL)state {
    if (button == self.button1) {
        if (state) {
            NSLog(@"汉堡包按钮动画结束，当前处于打开状态");
        } else {
            NSLog(@"汉堡包按钮动画结束，当前处于关闭状态");
        }
    } else if (button == self.button2) {
        if (state) {
            NSLog(@"爱奇艺播放按钮动画结束，当前处于播放状态");
        } else {
            NSLog(@"爱奇艺播放按钮动画结束，当前处于暂停状态");
        }
    } else if (button == self.button3) {
        if (state) {
            NSLog(@"优酷播放按钮动画结束，当前处于播放状态");
        } else {
            NSLog(@"优酷播放按钮动画结束，当前处于暂停状态");
        }
    }
}

@end
