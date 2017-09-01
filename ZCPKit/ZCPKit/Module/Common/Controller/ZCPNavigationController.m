//
//  ZCPNavigationController.m
//  ZCPKit
//
//  Created by zhuchaopeng on 16/10/13.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPNavigationController.h"

@interface ZCPNavigationController ()

@end

@implementation ZCPNavigationController

#pragma mark - jump / back
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.topViewController) {
        self.topViewController.latterViewController = viewController;
        viewController.formerViewController         = self.topViewController;
        viewController.viewJumpModel                = ZCPViewNavJumpMode;
    }
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    self.topViewController.formerViewController.latterViewController = nil;
    return [super popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.latterViewController         = nil;
    return [super popToViewController:viewController animated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    UIViewController *vc                        = [self.viewControllers firstObject];
    vc.latterViewController                     = nil;
    return [super popToRootViewControllerAnimated:animated];
}



@end
