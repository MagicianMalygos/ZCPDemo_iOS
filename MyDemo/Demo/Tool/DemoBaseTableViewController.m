//
//  DemoBaseTableViewController.m
//  Demo
//
//  Created by 朱超鹏(外包) on 17/1/11.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "DemoBaseTableViewController.h"

@interface DemoBaseTableViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation DemoBaseTableViewController

@synthesize infoArr = _infoArr;

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - Override method
- (NSMutableArray *)infoArr {
    if (_infoArr == nil) {
        _infoArr = [NSMutableArray array];
    }
    return _infoArr;
}

- (CGFloat)cellHeight {
    return 50.0f;
}

- (void)setupCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = [[self.infoArr objectAtIndex:indexPath.row] valueForKey:@"title"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)didSelectCell:(NSIndexPath *)indexPath {
    Class vcClass = NSClassFromString([[self.infoArr objectAtIndex:indexPath.row] valueForKey:@"class"]);
    UIViewController *vc = [vcClass new];
    if (vcClass && vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    [self setupCell:cell indexPath:indexPath];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self cellHeight];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self didSelectCell:indexPath];
}

@end
