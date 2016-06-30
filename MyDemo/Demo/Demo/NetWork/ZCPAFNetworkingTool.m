//
//  ZCPAFNetworkingTool.m
//  Demo
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPAFNetworkingTool.h"

@interface ZCPAFNetworkingTool ()

@end

@implementation ZCPAFNetworkingTool

- (void)getRequest_Asynchronous_AF {
    // 创建请求队列管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 设置request解析方式
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    // 设置response解析方式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    AFHTTPRequestOperation *operation = [manager GET:URL_STR parameters:URL_PARAMS_AF success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@ %@", responseObject, [responseObject className]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Fetch Error: %@", error);
    }];
}

- (void)postRequest_Asynchronous_AF {
    // 创建请求队列管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 设置response解析方式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    AFHTTPRequestOperation *operation = [manager POST:URL_STR parameters:URL_PARAMS_AF success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@ %@", responseObject, [responseObject className]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Fetch Error: %@", error);
    }];
}


- (void)uploadRequest_AF {
    
}
- (void)downloadRequest_AF {
    // 创建请求队列管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 设置request解析方式
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    // 设置response解析方式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    AFHTTPRequestOperation *operation = [manager GET:@"https://github.com/MagicianMalygos/MyDocuments/archive/master.zip" parameters:@{} success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@ %@", responseObject, [responseObject className]);
        
        // 将下载得到的数据生成文件放在沙盒的Documents文件夹下
        // 沙盒路径 http://m.blog.csdn.net/article/details?id=51265014
        NSArray *patchs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        // Documents路径
        NSString *documentsDirectory = [patchs objectAtIndex:0];
        NSString *fileDirectory = [documentsDirectory stringByAppendingPathComponent:@"master.zip"];
        
        NSData *data = responseObject;
        [data writeToFile:fileDirectory atomically:YES];
        
        // 获取Documents文件夹下所有文件名
        NSArray *files = [[NSArray alloc] initWithArray:[[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:nil]];
        NSLog(@"%@, %@", patchs, files);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Fetch Error: %@", error);
    }];
}

@end
