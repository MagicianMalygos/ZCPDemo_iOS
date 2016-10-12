//
//  NavigationController.m
//  OrientationDemo
//
//  Created by zhuchaopeng on 16/10/12.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

// 是否支持
-(BOOL)shouldAutorotate{
    return [self.topViewController shouldAutorotate];
}
// 支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}

@end
