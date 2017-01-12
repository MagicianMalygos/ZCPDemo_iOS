//
//  DemoBaseTableViewController.h
//  Demo
//
//  Created by 朱超鹏(外包) on 17/1/11.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoBaseTableViewController : DemoBaseViewController

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *infoArr;

- (void)setupCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath;
- (CGFloat)cellHeight;
- (void)didSelectCell:(NSIndexPath *)indexPath;

@end
