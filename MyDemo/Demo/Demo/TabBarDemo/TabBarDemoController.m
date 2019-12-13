//
//  TabBarDemoController.m
//  Demo
//
//  Created by 朱超鹏 on 2018/10/10.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "TabBarDemoController.h"
#import "TBDemoVC1.h"
#import "TBDemoVC2.h"
#import "ZCPDemoTabBar.h"

@interface TabBarDemoController ()

@end

@implementation TabBarDemoController

- (instancetype)init {
    if (self = [super init]) {
        // 添加tab
        self.viewControllers = [self tabViewControllers];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZCPDemoTabBar *tabBar = [[ZCPDemoTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
}

#pragma mark - 这些方法应该写在创建TabBarController的类中，或其他类中
#pragma mark Tab控制器数组
- (NSArray *)tabViewControllers {
    
    TBDemoVC1 *vc1 = [TBDemoVC1 new];
    TBDemoVC2 *vc2 = [TBDemoVC2 new];
    TBDemoVC2 *vc3 = [TBDemoVC2 new];
    TBDemoVC2 *vc4 = [TBDemoVC2 new];
    TBDemoVC2 *vc5 = [TBDemoVC2 new];
    
    vc1.tabBarItem = [self createTabBarItemWithTitle:@"首页"
                                               image:[UIImage imageNamed:@"tabbar_home_normal"]
                                       selectedImage:[UIImage imageNamed:@"tabbar_home_selected"]
                                                 tag:0];
    vc2.tabBarItem = [self createTabBarItemWithTitle:@"职位"
                                               image:[UIImage imageNamed:@"tabbar_job_normal"]
                                       selectedImage:[UIImage imageNamed:@"tabbar_job_selected"]
                                                 tag:1];
    vc3.tabBarItem = [self createTabBarItemWithTitle:@"经纪人"
                                               image:[UIImage imageNamed:@"tabbar_agent_normal"]
                                       selectedImage:[UIImage imageNamed:@"tabbar_agent_normal"]
                                                 tag:2];
    vc4.tabBarItem = [self createTabBarItemWithTitle:@"头条"
                                               image:[UIImage imageNamed:@"tabbar_top_normal"]
                                       selectedImage:[UIImage imageNamed:@"tabbar_top_selected"]
                                                 tag:3];
    vc5.tabBarItem = [self createTabBarItemWithTitle:@"我的"
                                               image:[UIImage imageNamed:@"tabbar_my_normal"]
                                       selectedImage:[UIImage imageNamed:@"tabbar_my_selected"]
                                                 tag:4];
    
    [self setTabBarBackgroundColor];
    
    return @[vc1, vc2, vc3, vc4, vc5];
}

#pragma mark Set TabBar BgColor
- (void)setTabBarBackgroundColor {
    // 背景颜色（透明效果色）
//    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    // 选中图标的颜色
//    [[UITabBar appearance] setTintColor:[UIColor redColor]];
    // TabBar背景颜色（真实效果色）
    //    [[UITabBar appearance] setBarTintColor:[UIColor brownColor]];
}


#pragma mark Create Tab
- (UITabBarItem *)createTabBarItemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage tag:(NSInteger)tag {
    
    UITabBarItem *tabbarItem = [[UITabBarItem alloc] initWithTitle:title image:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabbarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]} forState:UIControlStateNormal];
    [tabbarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor orangeColor]} forState:UIControlStateSelected];
    tabbarItem.tag = tag;
    return tabbarItem;
    
    
//    // 创建UITabBarItem
//    UITabBarItem *tabBarItem = [[UITabBarItem alloc] init];
//    [tabBarItem setTitle:title];
//    [tabBarItem setTag:tag];
//
//    // tabbarItem文字选中的颜色
//    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]} forState:UIControlStateNormal];
//    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor orangeColor]} forState:UIControlStateSelected];
    
    /**
     *  控制图片大小
     *  scale:原始图片缩放倍数
     *  orientation:控制image的绘制方向
     */
//    UIImage *normalIMG = [UIImage imageWithCGImage:image.CGImage
//                                             scale:[UIScreen mainScreen].scale
//                                       orientation:UIImageOrientationUp];
//    UIImage *selectedIMG = [UIImage imageWithCGImage:selectedImage.CGImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
//
//    [tabBarItem setImage:normalIMG];
//    [tabBarItem setSelectedImage:selectedIMG];
    
//    [tabBarItem setImage:image];
//    [tabBarItem setSelectedImage:selectedImage];
//
//    return tabBarItem;
}


@end
