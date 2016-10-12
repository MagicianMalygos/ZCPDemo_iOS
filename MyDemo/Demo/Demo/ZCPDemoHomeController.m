//
//  ZCPDemoHomeController.m
//  Demo
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPDemoHomeController.h"

@interface ZCPDemoHomeController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *demoArr;

@end

@implementation ZCPDemoHomeController

#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.tableView];
}
#pragma mark - getter / setter
- (UITableView *)tableView {
    if (_tableView == nil) {
        // GCC编译器的语法
        _tableView = ({
            UITableView *tableView = [[UITableView alloc] initWithFrame:({
                CGRect frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64);
                frame;
            })];
            tableView.dataSource = self;
            tableView.delegate = self;
            tableView;
        });
    }
    return _tableView;
}
- (NSMutableArray *)demoArr {
    if (_demoArr == nil) {
        _demoArr = [NSMutableArray arrayWithObjects:
  @{@"DemoName": @"WebViewDemo", @"DemoHomeClass": @"WebViewDemoHomeController"}
, @{@"DemoName": @"SizeToFitDemo", @"DemoHomeClass": @"SizeToFitDemoHomeController"}
, @{@"DemoName": @"AlertViewDemo", @"DemoHomeClass": @"AlertViewDemoHomeController"}
, @{@"DemoName": @"PageVCDemo", @"DemoHomeClass": @"PageVCDemoHomeController"}
, @{@"DemoName": @"CameraAndAlbumDemo", @"DemoHomeClass": @"CameraAndAlbumDemoHomeController"}
, @{@"DemoName": @"FontDemo", @"DemoHomeClass": @"FontDemoHomeControllerViewController"}
, @{@"DemoName": @"OtherDemo", @"DemoHomeClass": @"OtherDemoHomeController"}
, @{@"DemoName": @"PhotoCarouselDemo", @"DemoHomeClass": @"PhotoCarouselDemoHomeController"}
, @{@"DemoName": @"CollectionViewDemo", @"DemoHomeClass": @"CollectionViewDemoHomeController"}
, @{@"DemoName": @"SetFilletDemo", @"DemoHomeClass": @"SetFilletDemoHomeController"}
, @{@"DemoName": @"ShareDemo", @"DemoHomeClass": @"ShareDemoHomeController"}
, @{@"DemoName": @"PADemo", @"DemoHomeClass": @"PADemoHomeController"}
, @{@"DemoName": @"TabBarDemo", @"DemoHomeClass": @"TabBarDemoHomeController"}
, @{@"DemoName": @"NetWorkDemo", @"DemoHomeClass": @"NetWorkDemoHomeController"}
, @{@"DemoName": @"二维码扫描", @"DemoHomeClass": @"QRCodeDemoHomeController"}
, @{@"DemoName": @"UIDemo", @"DemoHomeClass": @"UIDemoHomeController"}
, @{@"DemoName": @"Palette", @"DemoHomeClass": @"PaletteDemoHomeController"}
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
    Class vcClass = NSClassFromString([[self.demoArr objectAtIndex:indexPath.row] valueForKey:@"DemoHomeClass"]);
    UIViewController *vc = [vcClass new];
    if (vcClass && vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
