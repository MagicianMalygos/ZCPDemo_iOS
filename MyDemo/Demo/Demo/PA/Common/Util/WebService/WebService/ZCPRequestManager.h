//
//  ZCPRequestManager.h
//  Apartment
//
//  Created by apple on 16/2/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

// 构造url
extern NSString *ZCPMakeURLString(NSString *scheme, NSString *host, NSString *path);

typedef void(^requestSuccessHandler)(AFHTTPRequestOperation *operation, id responseObject);
typedef void(^requestFailHandler)(AFHTTPRequestOperation *operation, NSError *error);

// 加载块
typedef void (^LoadListBlock)(AFHTTPRequestOperation *operation, ZCPListDataModel *listModel);
typedef void (^HeaderLoadListBlock)(AFHTTPRequestOperation *operation, ZCPListDataModel *listModel);
typedef void (^FooterLoadListBlock)(AFHTTPRequestOperation *operation, ZCPListDataModel *listModel);

// 网络请求类
@interface ZCPRequestManager : AFHTTPRequestOperationManager

+ (instancetype)sharedInstance;

@end
