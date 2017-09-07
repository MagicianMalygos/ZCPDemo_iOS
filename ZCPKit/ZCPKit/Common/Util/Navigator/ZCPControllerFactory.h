//
//  ZCPControlingCenter.h
//  Apartment
//
//  Created by apple on 15/12/28.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCPMacros.h"
@class ZCPVCDataModel;

// ----------------------------------------------------------------------
#pragma mark - 视图控制器工厂
// ----------------------------------------------------------------------
@interface ZCPControllerFactory : NSObject

DEF_SINGLETON

// ----------------------------------------------------------------------
#pragma mark - 生成控制器方法
// ----------------------------------------------------------------------

// 通过控制器标识 生成 控制器模型
- (nullable ZCPVCDataModel *)generateVCModelWithIdentifier:(nonnull NSString *)identifier;
// 通过控制器模型 生成 控制器对象
- (nullable UIViewController *)generateVCWithVCModel:(nonnull ZCPVCDataModel *)vcDataModel;
// 通过控制器标识 生成 控制器对象
- (nullable UIViewController *)generateVCWithIdentifier:(nonnull NSString *)identifier;

// ----------------------------------------------------------------------
#pragma mark - 控制器配置方法
// ----------------------------------------------------------------------

- (void)configController:(nonnull UIViewController *)controller withVCDataModel:(nonnull ZCPVCDataModel *)vcDataModel shouldCallInitMethod:(BOOL)shouldCallInitMethod;


// ----------------------------------------------------------------------
#pragma mark - 自定义生成控制器栈方法
// ----------------------------------------------------------------------

// 生成 Nav - Tab - VCs 控制器栈
- (nonnull UINavigationController *)generate_Nav_Tab_VCs_Stack;

@end
