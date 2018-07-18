//
//  ZCPURLSessionTool.h
//  Demo
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCPRequestMethodProtocol.h"

@interface ZCPURLSessionTool : NSObject <ZCPRequestMethodProtocol>

- (NSURLSessionDataTask *)getRequest_Synchronouos;
- (NSURLSessionDataTask *)postRequest_Synchronouos;

@end
