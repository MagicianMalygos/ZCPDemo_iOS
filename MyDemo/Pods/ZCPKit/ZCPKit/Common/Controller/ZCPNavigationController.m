//
//  ZCPNavigationController.m
//  ZCPKit
//
//  Created by zhuchaopeng on 16/10/13.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPNavigationController.h"
#import "ZCPNavigator.h"

@implementation ZCPNavigationController

//#pragma mark - jump / back
//- (void)pushViewController:(UIViewController<ZCPNavigatorProtocol> *)viewController animated:(BOOL)animated {
//    if (self.topViewController) {
//        UIViewController<ZCPNavigatorProtocol> *topVC = (UIViewController<ZCPNavigatorProtocol> *)self.topViewController;
//        topVC.latterViewController = viewController;
//        viewController.formerViewController         = (UIViewController<ZCPNavigatorProtocol> *)self.topViewController;
//        viewController.viewJumpModel                = ZCPViewNavJumpMode;
//    }
//    [super pushViewController:viewController animated:animated];
//}
//
//- (UIViewController<ZCPNavigatorProtocol> *)popViewControllerAnimated:(BOOL)animated {
//    UIViewController<ZCPNavigatorProtocol> *topVC = (UIViewController<ZCPNavigatorProtocol> *)self.topViewController;
//    topVC.formerViewController.latterViewController = nil;
//    return (UIViewController<ZCPNavigatorProtocol> *)[super popViewControllerAnimated:animated];
//}
//
//- (NSArray<UIViewController<ZCPNavigatorProtocol> *> *)popToViewController:(UIViewController<ZCPNavigatorProtocol> *)viewController animated:(BOOL)animated {
//    viewController.latterViewController         = nil;
//    return [super popToViewController:viewController animated:animated];
//}
//
//- (NSArray<UIViewController<ZCPNavigatorProtocol> *> *)popToRootViewControllerAnimated:(BOOL)animated {
//    UIViewController<ZCPNavigatorProtocol> *vc  = [self.viewControllers firstObject];
//    vc.latterViewController                     = nil;
//    return [super popToRootViewControllerAnimated:animated];
//}

@end
