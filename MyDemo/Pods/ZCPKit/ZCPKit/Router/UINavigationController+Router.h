//
//  UINavigationController+Router.h
//  Pods-ZCPKitExample
//
//  Created by 朱超鹏 on 2017/12/21.
//

#import <UIKit/UIKit.h>
@class ZCPBaseNavigator;

@interface UINavigationController (Router)

/// 所属导航器
@property (nonatomic, weak) ZCPBaseNavigator *navigator;

@end
