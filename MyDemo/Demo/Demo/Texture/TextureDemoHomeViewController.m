//
//  TextureDemoHomeViewController.m
//  Demo
//
//  Created by zcp on 2019/4/29.
//  Copyright © 2019 zcp. All rights reserved.
//

#import "TextureDemoHomeViewController.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface TextureDemoHomeViewController ()<ASTableDataSource, ASTableDelegate>

@property (nonatomic, strong) ASTableNode *tableNode;

@end

@implementation TextureDemoHomeViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.node addSubnode:self.tableNode];
}

#pragma mark - ASTableDataSource, ASTableDelegate

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
