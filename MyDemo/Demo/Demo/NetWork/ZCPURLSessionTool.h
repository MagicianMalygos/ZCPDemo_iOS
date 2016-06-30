//
//  ZCPURLSessionTool.h
//  Demo
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GET_URL         [NSURL URLWithString:@"http://www.weather.com.cn/data/sk/101010100.html"]
#define POST_URL        [NSURL URLWithString:@"http://120.25.226.186:32812/login"]
#define POST_URL_PARAMS @"username=520it&pwd=520it&type=JSON"

@interface ZCPURLSessionTool : NSObject

- (void)getRequest_Synchronouos_Session;
- (void)getRequest_Asynchronous_Session;
- (void)postRequest_Synchronous_Session;
- (void)postRequest_Asynchronous_Session;

@end
