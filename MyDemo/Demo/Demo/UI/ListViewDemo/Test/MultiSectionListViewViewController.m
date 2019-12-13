//
//  MultiSectionListViewViewController.m
//  Demo
//
//  Created by zhuchaopeng06607 on 2019/12/13.
//  Copyright © 2019 zcp. All rights reserved.
//

#import "MultiSectionListViewViewController.h"
#import <ZCPListView.h>

#define CELLTYPE_TITLE @"cell.type.title"

@interface MultiSectionListViewViewController () <UITableViewDelegate>

@property (nonatomic, strong) ZCPTableViewDataSource *tableViewDataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *rawData;

@end

@implementation MultiSectionListViewViewController

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
    self.rawData = @[@{@"section": @"A", @"words": @[@"about", @"apple", @"application", @"attack"]},
                     @{@"section": @"B", @"words": @[@"but", @"bullet", @"best"]},
                     @{@"section": @"C", @"words": @[@"card", @"cat", @"category"]},
                     @{@"section": @"D", @"words": @[@"dead", @"distance", @"disappear", @"dequeue"]},
                     @{@"section": @"E", @"words": @[@"egg", @"equal", @"english", @"eight"]}];
    
    [self.tableViewDataSource.sectionDataModelArray removeAllObjects];
    for (NSDictionary *dict in self.rawData) {
        ZCPTableViewSectionDataModel *sectionModel = [[ZCPTableViewSectionDataModel alloc] init];
        ZCPTableViewSingleTitleSectionViewModel *sectionVM = [[ZCPTableViewSingleTitleSectionViewModel alloc] init];
        sectionVM.titleString = dict[@"section"];
        sectionVM.sectionViewHeight = @20;
        sectionVM.sectionViewBgColor = [UIColor lightGrayColor];
        sectionModel.headerViewModel = sectionVM;
        
        NSArray *words = dict[@"words"];
        for (NSString *word in words) {
            ZCPTableViewSingleTitleCellViewModel *cellVM = [[ZCPTableViewSingleTitleCellViewModel alloc] init];
            cellVM.titleString = word;
            cellVM.cellHeight = @50;
            cellVM.bottomSeparatorHidden = NO;
            cellVM.cellType = CELLTYPE_TITLE;
            [sectionModel.cellViewModelArray addObject:cellVM];
        }
        [self.tableViewDataSource.sectionDataModelArray addObject:sectionModel];
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

UITableViewDelegate_ZCP_BASE_IMP(self.tableViewDataSource);

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCPTableViewCellViewModel *cellVM = [self.tableViewDataSource viewModelForRowAtIndexPath:indexPath];
    if ([cellVM.cellType isEqualToString:CELLTYPE_TITLE]) {
        NSLog(@"%@ - %@", self.rawData[indexPath.section][@"section"], self.rawData[indexPath.section][@"words"][indexPath.row]);
    }
}

#pragma mark - getters and setters

- (ZCPTableViewDataSource *)tableViewDataSource {
    if (!_tableViewDataSource) {
        _tableViewDataSource = [[ZCPTableViewDataSource alloc] init];
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
