//
//  DashedDemoHomeController.m
//  Demo
//
//  Created by 朱超鹏(外包) on 17/1/11.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "DashedDemoHomeController.h"
#import "DashedSettingView.h"
#import "DashedView.h"
#import "DashedCell.h"
#import "DashedModel.h"

@interface DashedDemoHomeController () <DashedSettingViewDelegate>

/// 虚线参数设置视图
@property (nonatomic, strong) DashedSettingView *settingView;
/// 虚线参数
@property (nonatomic, strong) DashedModel *dashedModel;

/// 定时器
@property (nonatomic, strong) CADisplayLink *displayLink;
/// 移动增量
@property (nonatomic, assign) CGFloat moveIncrement;

@end

@implementation DashedDemoHomeController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.settingView];
    [self update];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.settingView.frame  = CGRectMake(0, 0, self.view.width, 170);
    self.tableView.frame    = CGRectMake(0, 170, self.view.width, self.view.height - 170);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.isMovingFromParentViewController) {
        _displayLink.paused = YES;
        [_displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        [_displayLink invalidate];
        _displayLink = nil;
    }
}

#pragma mark - DashedSettingViewDelegate

- (void)clickGoButton:(UIButton *)button {
    [self update];
}

- (void)clickMoveButton:(UIButton *)button {
    if (button.tag == 0) {
        button.tag              = 1;
        self.moveIncrement      = 1;
        self.displayLink.paused = NO;
        [button setTitle:@"Move" forState:UIControlStateNormal];
    } else if (button.tag == 1) {
        button.tag              = 2;
        self.moveIncrement      = -1;
        self.displayLink.paused = NO;
        [button setTitle:@"Pause" forState:UIControlStateNormal];
    } else if (button.tag == 2) {
        button.tag              = 0;
        self.displayLink.paused = YES;
        [button setTitle:@"Move" forState:UIControlStateNormal];
    }
}

#pragma mark <help method>

- (void)updateDashedModel {
    NSString *phaseS            = self.settingView.phaseTextField.text;
    NSString *lengthsS          = self.settingView.lengthsTextField.text;
    NSString *countS            = self.settingView.countTextField.text;
    
    CGFloat phaseV              = [phaseS floatValue];
    CGFloat countV              = [countS floatValue];
    
    NSArray *lengthSArr         = [lengthsS componentsSeparatedByString:@","];
    NSMutableArray *lengthsV    = [NSMutableArray array];
    
    for (int i = 0; i < lengthSArr.count; i++) {
        CGFloat length = [lengthSArr[i] floatValue];
        [lengthsV addObject:@(length)];
    }
    
    self.dashedModel.phaseV     = phaseV;
    self.dashedModel.lengthsV   = lengthsV;
    self.dashedModel.countV     = countV;
}

- (void)update {
    [self updateDashedModel];
    [self constructData];
    [self.tableView reloadData];
}

#pragma mark - CADisplayLink Response

- (void)move {
    NSString *phaseS    = self.settingView.phaseTextField.text;
    CGFloat phaseV      = [phaseS floatValue] + self.moveIncrement;
    self.settingView.phaseTextField.text = [@(phaseV) stringValue];
    [self update];
}

#pragma mark - tableview

- (void)constructData {
    [self.tableViewAdaptor.items removeAllObjects];
    
    for (int i = 0; i < 2; i++) {
        DashedCellItem *item    = [[DashedCellItem alloc] init];
        item.model              = self.dashedModel.copy;
        item.model.type         = i + 1;
        [self.tableViewAdaptor.items addObject:item];
    }
}

#pragma mark - getter / setter

- (DashedSettingView *)settingView {
    if (_settingView == nil) {
        _settingView = [[[NSBundle mainBundle] loadNibNamed:@"DashedSettingView" owner:self options:nil] lastObject];
        _settingView.delegate = self;
    }
    return _settingView;
}

- (DashedModel *)dashedModel {
    if (!_dashedModel) {
        _dashedModel            = [[DashedModel alloc] init];
        _dashedModel.lineWidth  = 5;
        _dashedModel.lineColor  = [UIColor colorFromHexRGB:@"ff7f50"];
    }
    return _dashedModel;
}

- (CADisplayLink *)displayLink {
    if (!_displayLink) {
        _displayLink        = [CADisplayLink displayLinkWithTarget:self selector:@selector(move)];
        _displayLink.paused = YES;
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _displayLink;
}

@end
