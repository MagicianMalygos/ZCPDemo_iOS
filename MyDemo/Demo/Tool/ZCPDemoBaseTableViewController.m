//
//  ZCPDemoBaseTableViewController.m
//  Demo
//
//  Created by 朱超鹏 on 2017/10/10.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "ZCPDemoBaseTableViewController.h"

@interface ZCPDemoBaseTableViewController ()

@end

@implementation ZCPDemoBaseTableViewController

@synthesize tap = _tap;
@synthesize needsTapToDismissKeyboard = _needsTapToDismissKeyboard;
@synthesize formerViewController = _formerViewController;
@synthesize latterViewController = _latterViewController;

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - tableview

- (void)constructData {
    [self.tableViewDataSource.sectionDataModelArray removeAllObjects];
    
    ZCPTableViewSectionDataModel *section = [[ZCPTableViewSectionDataModel alloc] init];
    for (NSDictionary *infoDict in self.infoArr) {
        ZCPTableViewSingleTitleCellViewModel *viewModel = [[ZCPTableViewSingleTitleCellViewModel alloc] init];
        viewModel.titleString = infoDict[@"title"];
        viewModel.titleFont = [UIFont boldSystemFontOfSize:18];
        viewModel.cellHeight = @(50);
        viewModel.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        [section.cellViewModelArray addObject:viewModel];
    }
    [self.tableViewDataSource.sectionDataModelArray addObject:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = self.infoArr[indexPath.row][@"class"];
    [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:identifier queryForInit:nil  propertyDictionary:nil];
}

#pragma mark - getters and setters

- (NSMutableArray *)infoArr {
    if (_infoArr == nil) {
        _infoArr = [NSMutableArray array];
    }
    return _infoArr;
}

@end
