//
//  ZCPBaseNavigator.h
//  Apartment
//
//  Created by apple on 15/12/28.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCPNavigatorProtocol.h"
@class ZCPVCDataModel;

// ----------------------------------------------------------------------
#pragma mark - 基础导航器
// ----------------------------------------------------------------------
@interface ZCPBaseNavigator : NSObject

/// 导航栈
@property (nonatomic, strong, readonly) NSArray  *navigationStack;
/// 导航栈的根视图控制器
@property (nonatomic, readonly) UIViewController<ZCPNavigatorProtocol> *rootViewController;
/// 导航栈的顶部视图控制器
@property (nonatomic, readonly) UIViewController<ZCPNavigatorProtocol> *topViewController;

#pragma mark - push

/**
 跳转到控制器模型描述的视图控制器

 @param vcDataModel 控制器模型
 @param animated 转场动画
 @return 控制器对象
 */
- (UIViewController<ZCPNavigatorProtocol> *)pushViewControllerWithViewDataModel:(ZCPVCDataModel *)vcDataModel animated:(BOOL)animated;

/**
 跳转到控制器模型描述的视图控制器

 @param vcDataModel 控制器模型
 @param retrospect 回溯
 @param animated 转场动画
 @return 控制器对象
 */
- (UIViewController<ZCPNavigatorProtocol> *)pushViewControllerWithViewDataModel:(ZCPVCDataModel *)vcDataModel retrospect:(BOOL)retrospect animated:(BOOL)animated;

#pragma mark - pop

/**
 栈顶控制器退出控制器栈

 @param params APPURL_PARAM_ANIMATED
 */
- (void)viewExit:(NSDictionary *)params;

/**
 回退到栈底控制器

 @param params APPURL_PARAM_ANIMATED
 */
- (void)popToRoot:(NSDictionary *)params;

/**
 切换到指定TabBarItem

 @param index tabBarItem索引值
 */
- (void)goToTabBarItemIndex:(NSUInteger)index;

@end
