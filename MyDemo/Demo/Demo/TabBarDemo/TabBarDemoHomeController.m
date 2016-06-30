//
//  TabBarDemoHomeController.m
//  Demo
//
//  Created by apple on 16/6/3.
//  Copyright © 2016年 zcp. All rights reserved.
//

// TODO: .strings

#import "TabBarDemoHomeController.h"
#import "TBDemoVC1.h"
#import "TBDemoVC2.h"

@interface TabBarDemoHomeController ()

@end

@implementation TabBarDemoHomeController

- (instancetype)init {
    if (self = [super init]) {
        
//        self.view.frame = CGRectMake(0, 0, SCREENWIDTH, 100);
        // 添加tab
        self.viewControllers = [self tabViewControllers];
    }
    return self;
}

#pragma mark - 这些方法应该写在创建TabBarController的类中，或其他类中
#pragma mark Tab控制器数组
- (NSArray *)tabViewControllers {
    
    TBDemoVC1 *vc1 = [TBDemoVC1 new];
    TBDemoVC2 *vc2 = [TBDemoVC2 new];
    
    vc1.tabBarItem = [self createTabBarItemWithTitle:@"首页" image:[UIImage imageNamed:@"pa_tabbar_home_normal_icon"] selectedImage:[UIImage imageNamed:@"pa_tabbar_home_selected_icon"] tag:0];
    vc2.tabBarItem = [self createTabBarItemWithTitle:@"我的" image:[UIImage imageNamed:@"pa_tabbar_user_normal_icon"] selectedImage:[UIImage imageNamed:@"pa_tabbar_user_selected_icon"] tag:1];
    
    [self setTabBarBackgroundColor];
    
    return @[vc1, vc2];
}

#pragma mark Set TabBar BgColor
- (void)setTabBarBackgroundColor {
    // 背景颜色（透明效果色）
    [[UITabBar appearance] setBackgroundColor:[UIColor brownColor]];
    // 选中图标的颜色
    [[UITabBar appearance] setTintColor:[UIColor redColor]];
    // TabBar背景颜色（真实效果色）
//    [[UITabBar appearance] setBarTintColor:[UIColor brownColor]];
}


#pragma mark Create Tab
- (UITabBarItem *)createTabBarItemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage tag:(NSInteger)tag {
    
    // 创建UITabBarItem
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] init];
    [tabBarItem setTitle:title];
    [tabBarItem setTag:tag];
    
    // tabbarItem文字选中的颜色
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor]} forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} forState:UIControlStateSelected];
    
    /**
     *  控制图片大小
     *  scale:原始图片缩放倍数
     *  orientation:控制image的绘制方向
     */
    UIImage *normalIMG = [UIImage imageWithCGImage:image.CGImage
                                               scale:[UIScreen mainScreen].scale
                                         orientation:UIImageOrientationUp];
    UIImage *selectedIMG = [UIImage imageWithCGImage:selectedImage.CGImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    
    // 设置图片
    if ([[UIDevice currentDevice].systemVersion integerValue] >= 7) {
        [tabBarItem setImage:normalIMG];
        [tabBarItem setSelectedImage:selectedIMG];
    } else {
        [tabBarItem setFinishedSelectedImage:selectedIMG withFinishedUnselectedImage:normalIMG];
    }
    
    return tabBarItem;
}

@end
