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

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - tableview

- (void)constructData {
    [self.tableViewAdaptor.items removeAllObjects];
    
    for (NSDictionary *infoDict in self.infoArr) {
        ZCPSectionCellItem *item    = [[ZCPSectionCellItem alloc] initWithDefault];
        item.sectionTitle           = infoDict[@"title"];
        item.sectionTitlePosition   = ZCPSectionTitleLeftPosition;
        item.sectionTitleFont       = [UIFont systemFontOfSize:20.0f];
        item.cellHeight             = @(50.0f);
        [self.tableViewAdaptor.items addObject:item];
    }
}

- (void)tableView:(UITableView *)tableView didSelectObject:(id<ZCPTableViewCellItemBasicProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath {
    
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
