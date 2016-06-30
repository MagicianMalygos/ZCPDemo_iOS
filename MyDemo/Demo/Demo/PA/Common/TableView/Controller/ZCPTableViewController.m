//
//  ZCPTableViewController.m
//  Apartment
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import "ZCPTableViewController.h"

@interface ZCPTableViewController ()

@end

@implementation ZCPTableViewController

#pragma mark - synthesize
@synthesize tableView           = _tableView;
@synthesize tableViewAdaptor    = _tableViewAdaptor;

#pragma mark - init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

#pragma mark - life cycle
- (void)loadView {
    [super loadView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化
    [self initialize];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    // 调整tableview
    self.tableView.height = self.view.height;
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - functions
/**
 *  初始化方法
 */
- (void)initialize {
    // 创建tableView 适配器
    [self createTableViewAdaptor];
    // 构造数据
    [self constructData];
    // 创建TableView
    [self createTableView];
}
/**
 *  创建适配器
 */
- (void)createTableViewAdaptor {
    self.tableViewAdaptor               = [[ZCPListTableViewAdaptor alloc] init];
    self.tableViewAdaptor.delegate      = self;
}
/**
 *  构造数据方法，子类重写此方法实现构造
 */
- (void)constructData {
}
/**
 *  创建tableview
 */
- (void)createTableView {
    // 初始化tableview
    self.tableView                      = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    self.tableView.backgroundColor      = [UIColor clearColor];
    self.tableView.backgroundView       = nil;
    self.tableView.separatorStyle       = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource           = self.tableViewAdaptor;
    self.tableView.delegate             = self.tableViewAdaptor;
    self.tableView.scrollsToTop         = YES;
    
    self.tableViewAdaptor.tableView     = self.tableView;
    [self.view addSubview:self.tableView];
}

#pragma mark - tableview delegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - ZCPListTableViewAdaptorDelegate
- (void)tableView:(UITableView *)tableView didSelectObject:(id<ZCPTableViewCellItemBasicProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath {
}

@end
