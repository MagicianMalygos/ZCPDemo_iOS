//
//  ZCPAFNetworkingTool.h
//  Demo
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

#define URL_STR         @"http://apis.juhe.cn/cook/query"
#define URL_PARAMS      @"key=6bafd131caa6630e90453dcedf21cd3d&menu=%E8%A5%BF%E7%BA%A2%E6%9F%BF&rn=10&pn=3"
#define URL_PARAMS_AF   @{@"key":@"6bafd131caa6630e90453dcedf21cd3d", @"menu":@"%E8%A5%BF%E7%BA%A2%E6%9F%BF", @"rn":@"10", @"pn":@"3"}
#define URL             [NSURL URLWithString:URL_STR]

@interface ZCPAFNetworkingTool : NSObject

- (AFHTTPRequestOperation *)getRequest_Asynchronous_AF;
- (AFHTTPRequestOperation *)postRequest_Asynchronous_AF;
- (AFHTTPRequestOperation *)uploadRequest_AF;
- (AFHTTPRequestOperation *)downloadRequest_AF;

- (AFHTTPRequestOperation *)getRequest_Asynchronous_AF_Session;
- (AFHTTPRequestOperation *)postRequest_Asynchronous_AF_Session;
- (NSURLSessionUploadTask *)uploadRequest_AF_Session;
- (NSURLSessionDownloadTask *)downloadRequest_AF_Session;

@end
