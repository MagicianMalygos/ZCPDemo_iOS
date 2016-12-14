//
//  ZCPBaseNavigator.h
//  Apartment
//
//  Created by apple on 15/12/28.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ZCPVCDataModel;
@protocol ZCPNavigatorProtocol;

// 控制器跳转方式
typedef NS_ENUM(NSInteger, ZCPViewJumpMode) {
    ZCPViewNavJumpMode      = 1,    // 导航方式跳转
    ZCPViewModalJumpMode    = 2     // 模态方式跳转
};

// ----------------------------------------------------------------------
#pragma mark - 基础导航器
// ----------------------------------------------------------------------
@interface ZCPBaseNavigator : NSObject

// 导航栈
@property (nonatomic, strong, readonly) NSArray  *navigationStack;
// 导航栈的根视图控制器
@property (nonatomic, readonly) UIViewController *rootViewController;
// 导航栈的顶部视图控制器
@property (nonatomic, readonly) UIViewController *topViewController;

// 根据ViewDataModel获得视图控制器对象，并进行跳转
- (UIViewController *)pushViewControllerWithViewDataModel:(ZCPVCDataModel *)vcDataModel animated:(BOOL)animated;
// 根据viewDataModel配置进入一个新的viewcontroller页面
- (UIViewController *)pushViewControllerWithViewDataModel:(ZCPVCDataModel *)vcDataModel retrospect:(BOOL)retrospect animated:(BOOL)animated;

// 视图返回
- (void)viewExit:(NSDictionary *)params;
// 退到root页面
- (void)popToRoot:(NSDictionary *)params;

@end


// ----------------------------------------------------------------------
#pragma mark - 控制器初始化协议
// ----------------------------------------------------------------------
// 使用导航栏导航的控制器均需要实现此协议
@protocol ZCPNavigatorProtocol <NSObject>

@required
- (instancetype)initWithParams:(NSDictionary *)params;

@end

// ----------------------------------------------------------------------
#pragma mark - UIViewController导航分类
// ----------------------------------------------------------------------
@interface UIViewController (ZCPNavigator)

// 前一控制器
@property (nonatomic, weak) UIViewController *formerViewController;
// 后一控制器
@property (nonatomic, weak) UIViewController *latterViewController;
// 视图跳转模式
@property (nonatomic, assign) ZCPViewJumpMode viewJumpModel;

- (UIViewController *)formerViewController;
- (UIViewController *)latterViewController;
- (ZCPViewJumpMode)viewJumpModel;
- (void)setFormerViewController:(UIViewController *)formerViewController;
- (void)setLatterViewController:(UIViewController *)latterViewController;
- (void)setViewJumpModel:(ZCPViewJumpMode)viewJumpModel;

@end
