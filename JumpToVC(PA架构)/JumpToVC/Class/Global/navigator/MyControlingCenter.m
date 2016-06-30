//
//  MyControlingCenter.m
//  JumpToVC
//
//  Created by apple on 15/12/4.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MyControlingCenter.h"

// 各tabbar主视图控制器
#import "MyFirstViewController.h"
#import "MySecondViewController.h"

@interface MyControlingCenter ()

#pragma mark - property
// TabBarController
@property (nonatomic, strong) UITabBarController *tabBarController;

@end

@implementation MyControlingCenter

IMP_SINGLETON

#pragma mark - getter / setter
- (UITabBarController *)tabBarController {
    if (_tabBarController == nil) {
        _tabBarController = [[UITabBarController alloc] init];
    }
    // 设置各tabbar视图控制器
    [_tabBarController setViewControllers:[self getTabBarViewController]];
    return _tabBarController;
}

#pragma mark - 公有方法
/**
 *  获取应用程序根控制器：navigationController
 *
 *  @return navigationController
 */
- (UIViewController *)generateRootViewController {
    UINavigationController *navigationController = nil;
    UIViewController * rootController = [self tabBarController];
    navigationController = [[UINavigationController alloc] initWithRootViewController:rootController];
    
    // 设置navigation的颜色与样式
    UINavigationBar *navigationBar = navigationController.navigationBar;
    UIColor *color = [UIColor grayColor];
    [[UINavigationBar appearance] setTintColor:color];
    navigationBar.tintColor = color;                    // 左右按钮文字颜色
    navigationBar.barTintColor = [UIColor greenColor];  //navigationBar背景颜色
    navigationBar.translucent = NO;                     // 取消半透明效果，解决界面跳转的时候能看到导航栏的颜色发生变化
    NSDictionary *navTitleDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:18], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [navigationBar setTitleTextAttributes:navTitleDic];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    
    
    [navigationController preferredStatusBarStyle];
    
    return navigationController;
}
#pragma mark - 私有方法
/**
 *  得到各tabbar视图控制器
 *
 *  @return 各tabbar试图控制器
 */
- (NSArray *)getTabBarViewController {
    MyFirstViewController *firstVC = [MyFirstViewController new];
    MySecondViewController *secondVC = [MySecondViewController new];
    
    firstVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"VC1" image:nil tag:0];
    secondVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"VC2" image:nil tag:1];
    
    return @[firstVC, secondVC];
}
@end
