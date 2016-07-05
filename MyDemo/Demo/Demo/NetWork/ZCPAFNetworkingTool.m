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

- (AFHTTPRequestOperation *)getRequest_Asynchronous_AF {
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
    return operation;
}

- (AFHTTPRequestOperation *)postRequest_Asynchronous_AF {
    // 创建请求队列管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 设置response解析方式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    AFHTTPRequestOperation *operation = [manager POST:URL_STR parameters:URL_PARAMS_AF success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@ %@", responseObject, [responseObject className]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Fetch Error: %@", error);
    }];
    return operation;
}


- (AFHTTPRequestOperation *)uploadRequest_AF {
    return nil;
}
- (AFHTTPRequestOperation *)downloadRequest_AF {
    
    // HEAD 请求
    
    
    
    
    /**
     *  第一次只有当在文件读取结束的时候才能知道文件的大小
     */
    
    // 创建请求队列管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 设置request解析方式
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    // 设置response解析方式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    AFHTTPRequestOperation *operation = [manager GET:@"https://github.com/MagicianMalygos/MyDocuments/blob/master/%E5%9B%BE/AFNetworking%E7%BD%91%E7%BB%9C%E8%AF%B7%E6%B1%82%E6%89%A7%E8%A1%8C%E6%B5%81%E7%A8%8B.png" parameters:@{} success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@ %@", responseObject, [responseObject className]);
        NSLog(@"\n- - - - - Request - - - - -\n%@\n\n - - - - - Response - - - - -\n%@", operation.request, operation.response);
        NSLog(@"头信息：%@, 编码方式：%@, 文件名：%@", operation.response.allHeaderFields, operation.response.textEncodingName, operation.response.suggestedFilename);
        
        // 将下载得到的数据生成文件放在沙盒的Documents文件夹下
        // 沙盒路径 http://m.blog.csdn.net/article/details?id=51265014
        NSArray *patchs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        // Documents路径
        NSString *documentsDirectory = [patchs objectAtIndex:0];
        NSString *fileDirectory = [documentsDirectory stringByAppendingPathComponent:operation.response.suggestedFilename? operation.response.suggestedFilename: @"未知文件"];
        
        NSData *data = responseObject;
        [data writeToFile:fileDirectory atomically:YES];
        
        // 获取Documents文件夹下所有文件名
        NSArray *files = [[NSArray alloc] initWithArray:[[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:nil]];
        NSLog(@"\n- - - - - Documents - - - - - \n%@\n\n - - - - - 文件列表 - - - - - \n%@", patchs, files);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Fetch Error: %@", error);
    }];
    
    /**
     *  多部下载
     *
     *  @param bytesRead                当前一次读取的字节数
     *  @param totalBytesRead           已经下载的字节数
     *  @param totalBytesExpectedToRead 文件总大小
     *
     */
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        
        NSLog(@"读取字节数：%lu，已下载：%lli，总大小：%lli，当前下载进度：%f", (unsigned long)bytesRead, totalBytesRead, totalBytesExpectedToRead, (double)totalBytesRead / totalBytesExpectedToRead);
        
    }];
    
    return operation;
}

@end
