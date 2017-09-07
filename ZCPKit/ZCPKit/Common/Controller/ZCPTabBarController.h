//
//  ZCPTabBarController.h
//  ZCPKit
//
//  Created by zhuchaopeng on 16/10/13.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

// ----------------------------------------------------------------------
#pragma mark - 选项卡视图控制器
// ----------------------------------------------------------------------
@interface ZCPTabBarController : UITabBarController

/**
 初始化方法
 
 @param vcIdentifiers 控制器标识数组

 @return 实例化对象
 */
- (instancetype)initWithVCIdentifier:(NSArray *)vcIdentifiers;

/**
 初始化方法

 @param vcIdentifiers  控制器标识数组
 @param titles         标题数组
 @param normalImages   正常显示图数组
 @param selectedImages 选中显示图数组

 @return 实例化对象
 */
- (instancetype)initWithVCIdentifier:(NSArray *)vcIdentifiers tabBarItemTitles:(NSArray *)titles normalImages:(NSArray *)normalImages selectedImages:(NSArray *)selectedImages;


/**
 设置TabBarController的viewControllers

 @param vcIdentifiers 控制器标识数组
 */
- (void)setViewControllersWithVCIdentifiers:(NSArray *)vcIdentifiers;

/**
 设置TabBarItem的title、NormalImage、SelectedImage

 @param titles         标题数组
 @param normalImages   正常显示图数组
 @param selectedImages 选中显示图数组
 */
- (void)setTabBarItemTitles:(NSArray *)titles normalImages:(NSArray *)normalImages selectedImages:(NSArray *)selectedImages;

@end
