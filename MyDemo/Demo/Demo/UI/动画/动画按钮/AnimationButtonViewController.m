//
//  AnimationButtonViewController.m
//  Demo
//
//  Created by 朱超鹏 on 2018/7/3.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "AnimationButtonViewController.h"
#import "AnimationButton1.h"

@interface AnimationButtonViewController ()

@property (nonatomic, strong) AnimationButton1 *button;

@end

@implementation AnimationButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.button = [[AnimationButton1 alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    [self.view addSubview:self.button];
    
    [self.button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}

- (void)click {
    [self.button go];
}

@end
