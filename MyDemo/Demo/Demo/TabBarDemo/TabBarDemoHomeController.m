//
//  TabBarDemoHomeController.m
//  Demo
//
//  Created by apple on 16/6/3.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "TabBarDemoHomeController.h"
#import "TabBarDemoController.h"

@interface TabBarDemoHomeController ()

@property (nonatomic, strong) TabBarDemoController *tabbar;

@end

@implementation TabBarDemoHomeController

- (void)loadView {
    [super loadView];
    [self.view addSubview:self.tabbar.view];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tabbar.view.frame = self.view.bounds;
}

- (TabBarDemoController *)tabbar {
    if (!_tabbar) {
        _tabbar = [[TabBarDemoController alloc] init];
    }
    return _tabbar;
}


@end
