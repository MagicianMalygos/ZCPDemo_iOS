//
//  ViewController.m
//  AFNetworking3.0
//
//  Created by 朱超鹏(外包) on 16/7/26.
//  Copyright © 2016年 朱超鹏. All rights reserved.
//

#import "ViewController.h"
#import "DemoTool.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation ViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"afcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    NSDictionary *dic = [self.dataArr objectAtIndex:indexPath.row];
    NSString *textString = [dic objectForKey:@"text"];
    cell.textLabel.text = textString;

    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = [self.dataArr objectAtIndex:indexPath.row];
    NSString *selectorString = [dic objectForKey:@"method"];
    SEL sel = NSSelectorFromString(selectorString);
    [[DemoTool new] performSelector:sel];
}

#pragma mark - getter / setter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[@{@"text": @"GET", @"method": @"GET"},
                     @{@"text": @"POST", @"method": @"POST"},
                     @{@"text": @"上传", @"method": @"UPLOAD"},
                     @{@"text": @"下载", @"method": @"DOWNLOAD"}];
    }
    return _dataArr;
}

@end
