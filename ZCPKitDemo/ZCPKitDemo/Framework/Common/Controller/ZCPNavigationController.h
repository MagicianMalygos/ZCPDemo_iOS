//
//  ZCPNavigationController.h
//  ZCPKit
//
//  Created by zhuchaopeng on 16/9/21.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCPBaseNavigator;

// ----------------------------------------------------------------------
#pragma mark - 导航视图控制器
// ----------------------------------------------------------------------
@interface ZCPNavigationController : UINavigationController

// 所属导航器
@property (nonatomic, weak) ZCPBaseNavigator *navigator;

@end
