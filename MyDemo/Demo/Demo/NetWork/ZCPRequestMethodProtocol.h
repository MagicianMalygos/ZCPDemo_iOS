//
//  ZCPRequestMethodProtocol.h
//  Demo
//
//  Created by 朱超鹏 on 2018/7/18.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GET_URL                 @"http://www.weather.com.cn/data/sk/101010100.html"
#define POST_URL                @"http://apis.juhe.cn/cook/query"
#define POST_URL_PARAMS         @"key=6bafd131caa6630e90453dcedf21cd3d&menu=%E8%A5%BF%E7%BA%A2%E6%9F%BF&rn=10&pn=3"
#define POST_URL_PARAMS_DICT    @{@"key":@"6bafd131caa6630e90453dcedf21cd3d", @"menu":@"%E8%A5%BF%E7%BA%A2%E6%9F%BF", @"rn":@"10", @"pn":@"3"}
#define URL(url)                [NSURL URLWithString:url]

/**
 请求方法协议
 */
@protocol ZCPRequestMethodProtocol <NSObject>

- (NSURLSessionDataTask *)getRequest;
- (NSURLSessionDataTask *)postRequest;
- (NSURLSessionUploadTask *)uploadRequest;
- (NSURLSessionDownloadTask *)downloadRequest;

@end
