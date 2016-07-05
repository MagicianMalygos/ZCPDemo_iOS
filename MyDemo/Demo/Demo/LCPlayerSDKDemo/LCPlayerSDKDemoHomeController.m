//
//  LCPlayerSDKDemoHomeController.m
//  Demo
//
//  Created by ZhuChaopeng on 16/7/4.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "LCPlayerSDKDemoHomeController.h"
#import "LCVodViewController+UI.h"

@implementation LCPlayerSDKDemoHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 50);
    [button setTitle:@"点击播放视频" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)buttonClick:(UIButton *)button {
    LCVodViewController_UI *vc = [LCVodViewController_UI new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
