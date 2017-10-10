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

#define SettingViewHeight 170

@interface DashedDemoHomeController () {
    CGRect  dashedViewFrame;
}

@property (nonatomic, strong) DashedModel       *dashedModel;
@property (nonatomic, strong) DashedSettingView *settingView;

@end

@implementation DashedDemoHomeController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dashedModel.dashedViewFrame = CGRectMake(15, 25, self.view.frame.size.width - 30, 50);
    [self.view addSubview:self.settingView];
    [self.settingView.go addTarget:self action:@selector(reRender) forControlEvents:UIControlEventTouchUpInside];
    
    [self reRender];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, SettingViewHeight, SCREENWIDTH, SCREENHEIGHT - 64 - SettingViewHeight);
}

#pragma mark - event response

- (void)reRender {
    NSString *phaseS    = self.settingView.phase.text;
    NSString *lengthsS  = self.settingView.lengths.text;
    NSString *countS    = self.settingView.count.text;
    
    float phaseV = [phaseS floatValue];
    float countV = [countS floatValue];
    CGFloat *lengthsV = self.dashedModel->lengthsV;
    
    NSString *lengthsP = @"";
    NSArray *lengthSArr = [lengthsS componentsSeparatedByString:@","];
    for (int i = 0; i < lengthSArr.count; i++) {
        lengthsV[i] = [lengthSArr[i] floatValue];
        lengthsP = [lengthsP stringByAppendingString:[NSString stringWithFormat:@"%f", lengthsV[i]]];
        if (i != lengthSArr.count - 1) {
            lengthsP = [lengthsP stringByAppendingString:@", "];
        } else {
            lengthsV[i + 1] = EOF;
        }
    }
    
    self.dashedModel.phaseV     = phaseV;
    self.dashedModel.countV     = countV;
    
    ZCPLog(@"phase: %f, count: %f, lengths: %@", phaseV, countV, lengthsP);
    
    [self.tableView reloadData];
}

#pragma mark - tableview

- (void)constructData {
    [self.tableViewAdaptor.items removeAllObjects];
    for (int i = 0; i < 3; i++) {
        SEL drawDashedMethod    = NSSelectorFromString([NSString stringWithFormat:@"drawDashed%i:", i + 1]);
        DashedCellItem *item    = [[DashedCellItem alloc] init];
        item.cellHeight         = @(100.0f);
        item.drawDashedMethod   = [NSValue valueWithPointer:drawDashedMethod];
        [self.tableViewAdaptor.items addObject:item];
    }
}

- (void)tableView:(UITableView *)tableView didSetObject:(DashedCellItem *)object cell:(UITableViewCell *)cell {
    
    UIView *oldView = [cell viewWithTag:10010];
    if (oldView) {
        [oldView removeFromSuperview];
    }
    SEL selector = [object.drawDashedMethod pointerValue];
    UIView *view = nil;
    SuppressPerformSelectorLeakWarning({
        view = [DashedView performSelector:selector withObject:self.dashedModel];
        view.tag = 10010;
    });
    [cell addSubview:view];
}

#pragma mark - getter / setter

- (DashedSettingView *)settingView {
    if (_settingView == nil) {
        _settingView = [[[NSBundle mainBundle] loadNibNamed:@"DashedSettingView" owner:self options:nil] lastObject];
        _settingView.frame = CGRectMake(0, 0, SCREENWIDTH, SettingViewHeight);
    }
    return _settingView;
}

- (DashedModel *)dashedModel {
    if (!_dashedModel) {
        _dashedModel = [[DashedModel alloc] init];
    }
    return _dashedModel;
}

@end
