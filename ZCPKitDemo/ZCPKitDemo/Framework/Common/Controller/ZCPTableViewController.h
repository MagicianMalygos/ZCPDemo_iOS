//
//  ZCPTableViewController.h
//  ZCPKit
//
//  Created by zhuchaopeng on 16/9/21.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPViewController.h"
#import "ZCPListTableViewAdaptor.h"

// ----------------------------------------------------------------------
#pragma mark - 表格视图控制器基类
// ----------------------------------------------------------------------
@interface ZCPTableViewController : ZCPViewController <ZCPListTableViewAdaptorDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView               *tableView;         // tableView
@property (nonatomic, strong) ZCPListTableViewAdaptor   *tableViewAdaptor;  // 适配器

/**
 *  构造数据
 */
- (void)constructData;

@end
