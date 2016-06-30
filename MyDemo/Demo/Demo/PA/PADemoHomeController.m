//
//  PADemoHomeController.m
//  Demo
//
//  Created by apple on 16/6/2.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "PADemoHomeController.h"

@interface PADemoHomeController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *infoArray;

@end

@implementation PADemoHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.tableView];
}

#pragma mark - getter / setter
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
- (NSArray *)infoArray {
    if (_infoArray == nil) {
        _infoArray = @[@{@"info": @"蒙版提示视图", @"class": @"TipsViewDemoHomeController"}];
    }
    return _infoArray;
}
#pragma mark - UITableView DataSource&Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [[self.infoArray objectAtIndex:indexPath.row] valueForKey:@"info"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class vcClass = NSClassFromString([[self.infoArray objectAtIndex:indexPath.row] valueForKey:@"class"]);
    UIViewController *vc = [vcClass new];
    if (vcClass && vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
