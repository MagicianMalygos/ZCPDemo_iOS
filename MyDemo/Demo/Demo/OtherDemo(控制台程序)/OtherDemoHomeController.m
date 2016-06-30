//
//  OtherDemoHomeController.m
//  Demo
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "OtherDemoHomeController.h"
#import <objc/runtime.h>

@interface OtherDemoHomeController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *demoArr;

@end

@implementation OtherDemoHomeController

#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    [self.view addSubview:self.tableView];
}
#pragma mark - getter / setter
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
- (NSMutableArray *)demoArr {
    if (_demoArr == nil) {
        _demoArr = [NSMutableArray arrayWithObjects:
                    @{@"DemoName":@"MacroDemo", @"DemoHomeClass":@"MacroDemo"}
                    , @{@"DemoName":@"RuntimeDemo", @"DemoHomeClass":@"RuntimeDemo"}
                    , @{@"DemoName":@"EnumAndFormatDemo", @"DemoHomeClass":@"EnumAndFormatDemo"}
                    , @{@"DemoName":@"OCClassMethodDemo", @"DemoHomeClass":@"OCClassMethodDemo"}
                    , @{@"DemoName":@"AlgorithmDemo", @"DemoHomeClass":@"AlgorithmDemo"}
                    , nil];
    }
    return _demoArr;
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.demoArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"homeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [[self.demoArr objectAtIndex:indexPath.row] valueForKey:@"DemoName"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class class = NSClassFromString([[self.demoArr objectAtIndex:indexPath.row] valueForKey:@"DemoHomeClass"]);
    NSObject *object = [class new];
    if (class && object) {
        [object performSelector:@selector(run)];
    }
}


@end
