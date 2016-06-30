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


@end
