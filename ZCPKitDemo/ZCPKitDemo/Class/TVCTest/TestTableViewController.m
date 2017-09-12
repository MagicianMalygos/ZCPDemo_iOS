//
//  TestTableViewController.m
//  ZCPKitDemo
//
//  Created by 朱超鹏 on 2017/9/11.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "TestTableViewController.h"
#import "TestCell.h"

@interface TestTableViewController ()

@end

@implementation TestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView reloadData];
}

- (void)constructData {
    
    // blank
    ZCPCellDataModel *blankItem = [[ZCPCellDataModel alloc] init];
    blankItem.cellClass = [ZCPBlankCell class];
    blankItem.cellHeight = @(20);
    blankItem.cellBgColor = [UIColor colorFromHexRGB:@"a3a3a3"];
    [self.tableViewAdaptor.items addObject:blankItem];
    
    // section
    ZCPSectionCellItem *sectionItem = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem.sectionTitle = @"分类";
    sectionItem.cellHeight = @(80);
    sectionItem.sectionTitlePosition = ZCPSectionTitleLeftPosition | ZCPSectionTitleTopPosition;
    sectionItem.sectionTitleEdgeInset = UIEdgeInsetsMake(15, 15, 0, 0);
    [self.tableViewAdaptor.items addObject:sectionItem];
    
    // button
    ZCPButtonCellItem *buttonItem = [[ZCPButtonCellItem alloc] initWithDefault];
    buttonItem.buttonTitle = @"登录";
    buttonItem.buttonTitleColorNormal = [UIColor whiteColor];
    buttonItem.buttonBackgroundColor = [UIColor colorFromHexRGB:@"abcdef"];
    [self.tableViewAdaptor.items addObject:buttonItem];
    
    // textfield
    ZCPTextFieldCellItem *tfItem = [[ZCPTextFieldCellItem alloc] initWithDefault];
    tfItem.cellBgColor = [UIColor redColor];
    [self.tableViewAdaptor.items addObject:tfItem];
    
    // textview
    ZCPTextViewCellItem *tvItem = [[ZCPTextViewCellItem alloc] initWithDefault];
    tvItem.cellBgColor = [UIColor greenColor];
    [self.tableViewAdaptor.items addObject:tvItem];
    
    // with line cell
    for (int i = 0; i < 3; i++) {
        ZCPCellDataModel *withLineItem = [[ZCPCellDataModel alloc] init];
        withLineItem.cellClass = [ZCPTableViewWithLineCell class];
        withLineItem.cellBgColor = [UIColor whiteColor];
        withLineItem.cellHeight = @(44);
        withLineItem.topLineWidth = self.view.width;
        withLineItem.bottomLineWidth = self.view.width;
        [self.tableViewAdaptor.items addObject:withLineItem];
    }
    
    for (int i = 0; i < 3; i++) {
        TestCellItem *item = [[TestCellItem alloc] initWithDefault];
        item.title = [NSString stringWithFormat:@"标题：%d", i];
        item.subTitle = [NSString stringWithFormat:@"副标题%d", i];
        item.showAccessory = i%2;
        item.cellBgColor = [UIColor yellowColor];
        [self.tableViewAdaptor.items addObject:item];
    }
}

@end
