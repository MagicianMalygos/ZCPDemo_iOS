//
//  ViewController.m
//  UnitTestDemo
//
//  Created by apple on 16/4/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+Category.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(0, 100, 100, 40);
    self.button.layer.borderWidth = 0.5;
    self.button.layer.borderColor = [UIColor redColor].CGColor;
    self.button.backgroundColor = [UIColor cyanColor];
//    self.button.imageView.contentMode = UIViewContentModeScaleAspectFill;
//    [self.button setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
//    [self.button setTitle:@"ZCP" forState:UIControlStateNormal];
//    [self.button verticalImageAndTitle:1];

    // 图片的大小不能大于button的大小
    [self.button setImage:[UIImage imageNamed:@"2"] withTitle:@"ZCPasdfadfa" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.button];
}

- (void)buttonClicked {
    [self.button setTitle:@"AAAAasdfasd" forState:UIControlStateNormal];
}

@end
