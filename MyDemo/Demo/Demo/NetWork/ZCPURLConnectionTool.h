//
//  ZCPURLConnectionTool.h
//  Demo
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GET_URL         [NSURL URLWithString:@"http://www.weather.com.cn/data/sk/101010100.html"]
//#define POST_URL        [NSURL URLWithString:@"http://ipad-bjwb.bjd.com.cn/DigitalPublication/publish/Handler/APINewsList.ashx"]
//#define POST_URL_PARAMS @"date=20151031&startRecord=1&len=5&udid=1234567890&terminalType=Iphone&cid=213"
#define POST_URL        [NSURL URLWithString:@"http://120.25.226.186:32812/login"]
#define POST_URL_PARAMS @"username=520it&pwd=520it&type=JSON"

@interface ZCPURLConnectionTool : NSObject

- (void)getRequest_Asynchronous_Connection;
- (void)postRequest_Asynchronous_Connection;

@end
