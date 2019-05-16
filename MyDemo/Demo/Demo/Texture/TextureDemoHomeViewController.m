//
//  TextureDemoHomeViewController.m
//  Demo
//
//  Created by zcp on 2019/4/29.
//  Copyright © 2019 zcp. All rights reserved.
//

#import "TextureDemoHomeViewController.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "TravelCellNode.h"

@interface TextureDemoHomeViewController ()<ASTableDataSource, ASTableDelegate>

@property (nonatomic, strong) ASTableNode *tableNode;
@property (nonatomic, strong) NSMutableArray *travelModelArr;

@end

@implementation TextureDemoHomeViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubnode:self.tableNode];
    
    self.travelModelArr = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        TravelModel *model = [[TravelModel alloc] init];
        model.time = @"2018-10-22 19:20";
        model.sourceAddr = @"西子国际中心";
        model.destinationAddr = @"上海虹桥国际机场";
        model.status = @"未支付";
        model.amount = @"0.01元";
        [self.travelModelArr addObject:model];
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableNode.frame = self.view.bounds;
}

#pragma mark - ASTableDataSource, ASTableDelegate

- (NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode {
    return 1;
}

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section {
    return self.travelModelArr.count;
}

- (ASCellNode *)tableNode:(ASTableNode *)tableNode nodeForRowAtIndexPath:(NSIndexPath *)indexPath {
    TravelCellNode *node = [[TravelCellNode alloc] init];
    [node updateWithTravelModel:self.travelModelArr[indexPath.row]];
    return node;
}

- (ASSizeRange)tableNode:(ASTableNode *)tableNode constrainedSizeForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ASSizeRangeMake(CGSizeMake(kScreenWidth, 200), CGSizeMake(kScreenWidth, 200));
}

#pragma mark - getters

- (ASTableNode *)tableNode {
    if (!_tableNode) {
        _tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];
        _tableNode.dataSource = self;
        _tableNode.delegate = self;
    }
    return _tableNode;
}

@end
