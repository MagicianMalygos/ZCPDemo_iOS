//
//  PARequestCertificateManager.h
//  haofang
//
//  Created by 朱超鹏(外包) on 16/8/2.
//  Copyright © 2016年 平安好房. All rights reserved.
//

#import <Foundation/Foundation.h>

// 网络请求的证书管理器
@interface ZCPRequestCertificateManager : NSObject

DEF_SINGLETON

// 允许https的证书通过
- (void)allowHttpsCertificate:(NSString * _Nonnull)httpsURL completion:(void(^ _Nonnull)(void))completion;
- (void)allowHttpsCertificate:(NSString * _Nonnull)httpsURL success:(void (^ _Nonnull)(void))success failure:(void (^ _Nonnull)(void))failure;

@end
