//
//  PARequestCertificateManager.h
//  ZCPKit
//
//  Created by zhuchaopeng on 16/9/21.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCPMacros.h"

// 网络请求的证书管理器
@interface ZCPRequestCertificateManager : NSObject

DEF_SINGLETON

// 允许https的证书通过
- (void)allowHttpsCertificate:(NSString * _Nonnull)httpsURL completion:(void(^ _Nonnull)(void))completion;
- (void)allowHttpsCertificate:(NSString * _Nonnull)httpsURL success:(void (^ _Nonnull)(void))success failure:(void (^ _Nonnull)(void))failure;

@end
