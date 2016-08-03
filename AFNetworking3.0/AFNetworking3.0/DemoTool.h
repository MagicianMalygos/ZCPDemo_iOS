//
//  DemoTool.h
//  AFNetworking3.0
//
//  Created by 朱超鹏(外包) on 16/7/26.
//  Copyright © 2016年 朱超鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemoTool : NSObject

- (NSURLSessionTask *)GET;
- (NSURLSessionTask *)POST;
- (NSURLSessionTask *)UPLOAD;
- (NSURLSessionTask *)DOWNLOAD;

@end
