//
//  TestViewController.m
//  AwesomeProject
//
//  Created by 朱超鹏(外包) on 16/11/10.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "TestViewController.h"
#import "RCTBundleURLProvider.h"
#import "RCTRootView.h"

@interface TestViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *vcInfoArr;

@end

static RCTBridge *bridge = nil;

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _vcInfoArr = @[@{@"title": @"index", @"js": @"index.ios"}
                   , @{@"title": @"demo", @"js": @"demo.ios"}
                   , @{@"title": @"home", @"js": @"js/home"}];
    [self.view addSubview:self.tableView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64);
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vcInfoArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [self.vcInfoArr[indexPath.row] objectForKey:@"title"];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSURL *jsCodeLocation;
  
    jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:[self.vcInfoArr[indexPath.row] objectForKey:@"js"] fallbackResource:nil];
//    jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"home" withExtension:@"jsbundle"];
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:@"AwesomeProject"
                                                 initialProperties:nil
                                                     launchOptions:nil];
    rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
    UIViewController *rootViewController = [UIViewController new];
    rootViewController.view = rootView;
    [self presentViewController:rootViewController animated:YES completion:nil];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
