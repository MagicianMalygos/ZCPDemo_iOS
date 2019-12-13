//
//  SingleSectionListViewViewController.m
//  Demo
//
//  Created by zhuchaopeng06607 on 2019/12/13.
//  Copyright © 2019 zcp. All rights reserved.
//

#import "SingleSectionListViewViewController.h"
#import <ZCPListView.h>

#define CELLTYPE_TITLE @"cell.type.title"

@interface SingleSectionListViewViewController () <UITableViewDelegate>

@property (nonatomic, strong) ZCPTableViewSingleSectionDataSource *tableViewDataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *rawData;

@end

@implementation SingleSectionListViewViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.tableView];
    [self setupData];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - setup

- (void)setupData {
    self.rawData = @[@"王小二", @"李嗣源", @"张晓晓", @"孙二虎"];
    
    [self.tableViewDataSource.cellViewModelArray removeAllObjects];
    for (NSString *title in self.rawData) {
        ZCPTableViewSingleTitleCellViewModel *cellVM = [[ZCPTableViewSingleTitleCellViewModel alloc] init];
        cellVM.titleString = title;
        cellVM.cellHeight = @50;
        cellVM.bottomSeparatorHidden = NO;
        cellVM.cellType = CELLTYPE_TITLE;
        [self.tableViewDataSource.cellViewModelArray addObject:cellVM];
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

UITableViewDelegate_ZCP_BASE_IMP(self.tableViewDataSource);

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ZCPTableViewCellViewModel *cellVM = [self.tableViewDataSource viewModelForRowAtIndexPath:indexPath];
    if ([cellVM.cellType isEqualToString:CELLTYPE_TITLE]) {
        NSLog(@"%@", self.rawData[indexPath.row]);
    }
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
