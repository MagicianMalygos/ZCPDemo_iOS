//
//  ZCPControllerFactory+Category.m
//  Demo
//
//  Created by 朱超鹏 on 2017/10/10.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "ZCPControllerFactory+Category.h"

@implementation ZCPControllerFactory (Category)

- (UINavigationController *)generateCustomStack {
    
    UIViewController *rootViewController = [[ZCPControllerFactory sharedInstance] generateVCWithIdentifier:APPURL_VIEW_IDENTIFIER_HOME];
    
    // 初始化nav
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    navigationController.navigationBar.translucent = NO;
    
    // 初始化状态栏
    if (iOS9Upper) {
        [navigationController preferredStatusBarStyle];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
#pragma clang diagnostic pop
    }
    
    // 组成栈
    return navigationController;
}

@end
