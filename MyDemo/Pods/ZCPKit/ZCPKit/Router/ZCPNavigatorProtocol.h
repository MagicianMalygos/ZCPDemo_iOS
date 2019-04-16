//
//  ZCPNavigatorProtocol.h
//  ZCPKit
//
//  Created by zcp on 2019/1/7.
//  Copyright © 2019 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ZCPNavigatorProtocol;

NS_ASSUME_NONNULL_BEGIN

// ----------------------------------------------------------------------
#pragma mark - 导航器管理的视图控制器协议
// ----------------------------------------------------------------------
// 使用导航栏导航的控制器均需要实现此协议
@protocol __ZCPNavigatorProtocol0 <NSObject>

@required
/// 前一控制器
@property (nonatomic, weak) UIViewController<ZCPNavigatorProtocol> *formerViewController;
/// 后一控制器
@property (nonatomic, weak) UIViewController<ZCPNavigatorProtocol> *latterViewController;

@optional
/**
 带参初始化方法
 
 @param query 参数字典
 */
- (instancetype)initWithQuery:(NSDictionary *)query;

@end

@protocol ZCPNavigatorProtocol <__ZCPNavigatorProtocol0>

@end

NS_ASSUME_NONNULL_END
