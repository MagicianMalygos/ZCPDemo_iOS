//
//  SetFilletDemoHomeController.m
//  Demo
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "SetFilletDemoHomeController.h"
#import "SetFilletTestCell.h"
#import <YYKit.h>

@interface SetFilletDemoHomeController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *infoArray;

@end

@implementation SetFilletDemoHomeController

#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    for (int i = 0; i < 100; i++) {
        [self.infoArray addObject:@{@"label": @"啦啦", @"button": @"点击就送", @"image": @"001.jpg"}];
    }
    
    UIView *toolView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 36)];
    YYFPSLabel *fpsLabel = [YYFPSLabel new];
    fpsLabel.center = CGPointMake(SCREENWIDTH / 2, 18);
    [toolView addSubview:fpsLabel];
    
    [self.view addSubview:toolView];
    [self.view addSubview:self.tableView];
}

#pragma mark - getter / setter
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 36, SCREENWIDTH, SCREENHEIGHT - 64 - 36) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 50.0f;
    }
    return _tableView;
}
- (NSMutableArray *)infoArray {
    if (_infoArray == nil) {
        _infoArray = [NSMutableArray array];
    }
    return _infoArray;
}

#pragma mark - UITableView DataSource&Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SetFilletTestCell *cell = [tableView dequeueReusableCellWithIdentifier:[SetFilletTestCell cellIdentifier]];
    if (cell == nil) {
        cell = [[SetFilletTestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[SetFilletTestCell cellIdentifier]];
    }
    
    cell.testLabel.text = [self.infoArray objectAtIndex:indexPath.row][@"label"];
    [cell.testButton setTitle:[self.infoArray objectAtIndex:indexPath.row][@"button"] forState:UIControlStateNormal];
    cell.testImageView.image = [UIImage imageNamed:[self.infoArray objectAtIndex:indexPath.row][@"image"]];
    return cell;
}

@end
