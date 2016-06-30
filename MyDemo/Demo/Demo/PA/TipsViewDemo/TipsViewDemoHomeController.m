//
//  TipsViewDemoHomeController.m
//  Demo
//
//  Created by apple on 16/6/2.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "TipsViewDemoHomeController.h"
#import "TipsView.h"

@interface TipsViewDemoHomeController ()

@property (nonatomic, strong) UIView *toolView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) TipsView *tipsView;

@end

@implementation TipsViewDemoHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setupSubView];
}
- (void)setupSubView {
    _toolView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, SCREENWIDTH, 500)];
    _toolView.backgroundColor = [UIColor colorWithHexString:@"97cbff"];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(250, 200, 20, 20);
    _button.backgroundColor = [UIColor brownColor];
    [_toolView addSubview:_button];
    [self.view addSubview:_toolView];
    
    // 坐标系转换
    CGRect frame = [self.view convertRect:self.button.frame fromView:self.toolView];
    _tipsView = [[TipsView alloc] initWithFrame:self.view.bounds circleFrame:frame];
    [self.view addSubview:_tipsView];
}

@end
