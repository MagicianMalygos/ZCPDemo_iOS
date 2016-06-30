//
//  ZCPBaseNavigator.h
//  Apartment
//
//  Created by apple on 15/12/28.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ZCPViewDataModel;
@protocol ZCPNavigatorProtocol;

#pragma mark - 控制器初始化协议
// 使用导航栏导航的控制器均需要实现此协议
@protocol ZCPNavigatorProtocol <NSObject>

@required
- (instancetype)initWithParams:(NSDictionary *)params;
@optional
- (void)doInitializeWithParams:(NSDictionary *)params;

@end
