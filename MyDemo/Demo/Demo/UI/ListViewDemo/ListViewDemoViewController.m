//
//  ListViewDemoViewController.m
//  Demo
//
//  Created by zhuchaopeng06607 on 2019/12/13.
//  Copyright © 2019 zcp. All rights reserved.
//

#import "ListViewDemoViewController.h"
#import "MultiSectionListViewViewController.h"
#import "SingleSectionListViewViewController.h"
#import <ZCPListView.h>

@interface ListViewDemoViewController () <UITableViewDelegate>

@property (nonatomic, strong) ZCPTableViewSingleSectionDataSource *tableViewDataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *rawData;

@end

@implementation ListViewDemoViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self setupData];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - setup

- (void)setupData {
    self.rawData = @[@{@"title": @"单Section Table View", @"class": @"SingleSectionListViewViewController"},
                     @{@"title": @"多Section Table View", @"class": @"MultiSectionListViewViewController"}];
    
    [self.tableViewDataSource.cellViewModelArray removeAllObjects];
    for (NSDictionary *dict in self.rawData) {
        ZCPTableViewSingleTitleCellViewModel *cellVM = [[ZCPTableViewSingleTitleCellViewModel alloc] init];
        cellVM.titleString = dict[@"title"];
        cellVM.cellHeight = @50;
        cellVM.bottomSeparatorHidden = NO;
        [self.tableViewDataSource.cellViewModelArray addObject:cellVM];
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

UITableViewDelegate_ZCP_BASE_IMP(self.tableViewDataSource);

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *clsString = self.rawData[indexPath.row][@"class"];
    UIViewController *vc = [[NSClassFromString(clsString) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getters and setters

- (ZCPTableViewSingleSectionDataSource *)tableViewDataSource {
    if (!_tableViewDataSource) {
        _tableViewDataSource = [[ZCPTableViewSingleSectionDataSource alloc] init];
    }
    return _tableViewDataSource;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.backgroundView = nil;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.dataSource = self.tableViewDataSource;
        _tableView.delegate = self;
    }
    return _tableView;
}

@end
