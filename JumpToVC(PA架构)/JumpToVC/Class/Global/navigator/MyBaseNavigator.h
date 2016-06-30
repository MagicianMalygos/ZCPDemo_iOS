//
//  MyBaseNavigator.h
//  JumpToVC
//
//  Created by apple on 15/12/4.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MyViewDataModel;
@protocol MyNavigatorProtocol;

@interface MyBaseNavigator : NSObject

#pragma mark - Navigator属性
// 系统window，承载导航堆栈
@property (nonatomic, readonly) UIWindow *window;
// window的根视图控制器
@property (nonatomic, readonly) UIViewController *rootViewController;
// 导航堆栈顶部viewController
@property (nonatomic, readonly) UIViewController *topViewController;

#pragma mark - 设置rootViewController
- (void)setupRootViewController;
- (void)setupRootViewControllerWithAd;

#pragma mark - 公有方法
// 通过identifier获取视图模型
- (MyViewDataModel *)viewDataModelForIdentifier:(NSString *)identifier;
// 根据ViewDataModel获得控制器对象，并进行跳转
- (UIViewController *)pushViewControllerWithViewDataModel:(MyViewDataModel *)viewDataModel animated:(BOOL)animated;

@end

#pragma mark - 控制器初始化协议
@protocol MyNavigatorProtocol <NSObject>

@required
- (instancetype)initWithParams:(NSDictionary *)params;
@optional
- (void)doInitializeWithParams:(NSDictionary *)params;

@end
