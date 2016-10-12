//
//  PaletteDemoHomeController.m
//  Demo
//
//  Created by zhuchaopeng on 16/10/10.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "PaletteDemoHomeController.h"
#import "QuartzCorePaletteViewController.h"

@interface PaletteDemoHomeController ()

@property (nonatomic, strong) UIButton *quartzCorePaletteButton;

@end

@implementation PaletteDemoHomeController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.quartzCorePaletteButton];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _quartzCorePaletteButton.frame = CGRectMake(0, 64, SCREENWIDTH, 50.0f);
}

#pragma mark - Action Handler
- (void)quartzCorePaletteButtonClicked {
    QuartzCorePaletteViewController *vc = [QuartzCorePaletteViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getter / setter
- (UIButton *)quartzCorePaletteButton {
    if (!_quartzCorePaletteButton) {
        _quartzCorePaletteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _quartzCorePaletteButton.backgroundColor = [UIColor orangeColor];
        [_quartzCorePaletteButton setTitle:@"QuartzCore Palette" forState:UIControlStateNormal];
        [_quartzCorePaletteButton addTarget:self action:@selector(quartzCorePaletteButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _quartzCorePaletteButton;
}

@end
