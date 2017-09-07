//
//  ZCPServiceHandler.h
//  ZCPKit
//
//  Created by zhuchaopeng on 16/9/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZCPServiceResult;
@class ZCPServiceHandler;

typedef void (^_Nullable ZCPServiceResultBlock)(void);

// ----------------------------------------------------------------------
#pragma mark - ZCPServiceHandlerDelegate
// ----------------------------------------------------------------------

@protocol ZCPServiceHandlerDelegate <NSObject>

// service处理后的回调协议
- (void)service:(ZCPServiceHandler * _Nonnull)handler finishedWithResult:(ZCPServiceResult * _Nonnull)result;

@end

// ----------------------------------------------------------------------
#pragma mark - 统一处理app service请求
// ----------------------------------------------------------------------

@interface ZCPServiceHandler : NSObject

DEF_SINGLETON

@end

// ----------------------------------------------------------------------
#pragma mark - service处理结果类
// ----------------------------------------------------------------------

@interface ZCPServiceResult : NSObject

@property (nonatomic, strong, nullable) NSError *error;
@property (nonatomic, copy) ZCPServiceResultBlock action;

@end
