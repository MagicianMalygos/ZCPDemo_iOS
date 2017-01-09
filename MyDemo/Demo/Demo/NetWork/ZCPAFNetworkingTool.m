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
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperation *operation = [manager POST:@"" parameters:@{} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    return operation;
}
- (AFHTTPRequestOperation *)downloadRequest_AF {
    
    // ! 当服务器返回的头信息中有Content-Length时，才能获取到下载文件的大小 !
#pragma mark 公共部分
    NSString *url = @"https://raw.githubusercontent.com/MagicianMalygos/MyDocuments/master/software/RTX_V1.1%20For%20Mac.dmg";
    // 创建请求队列管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 设置request解析方式
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    // 设置response解析方式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
#pragma mark HEAD请求
    AFHTTPRequestOperation *operationHEAD = [manager HEAD:url parameters:@{} success:^(AFHTTPRequestOperation *operation) {
        NSLog(@"头信息：%@, 编码方式：%@, 文件名：%@", operation.response.allHeaderFields, operation.response.textEncodingName, operation.response.suggestedFilename);
        NSLog(@"Length: %lli\n", operation.response.expectedContentLength);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    operationHEAD = nil;
    
    /**
     *  第一次只有当在文件读取结束的时候才能知道文件的大小
     */
    AFHTTPRequestOperation *operationGET = [manager GET:url parameters:@{} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"%@ %@", responseObject, [responseObject className]);
        //        NSLog(@"\n- - - - - Request - - - - -\n%@\n\n - - - - - Response - - - - -\n%@", operation.request, operation.response);
        //        NSLog(@"头信息：%@, 编码方式：%@, 文件名：%@", operation.response.allHeaderFields, operation.response.textEncodingName, operation.response.suggestedFilename);
        
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
    [operationGET setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        
        NSLog(@"读取字节数：%lu，已下载：%lli，总大小：%lli，当前下载进度：%f", (unsigned long)bytesRead, totalBytesRead, totalBytesExpectedToRead, (double)totalBytesRead / totalBytesExpectedToRead);
        
    }];
    return operationGET;
}

- (NSURLSessionDataTask *)getRequest_Asynchronous_AF_Session {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLSessionDataTask *task = [manager GET:URL_STR parameters:URL_PARAMS_AF success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@ %@", responseObject, [responseObject className]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Fetch Error: %@", error);
    }];
    return task;
}
- (NSURLSessionDataTask *)postRequest_Asynchronous_AF_Session {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLSessionDataTask *task = [manager POST:URL_STR parameters:URL_PARAMS_AF success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@ %@", responseObject, [responseObject className]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Fetch Error: %@", error);
    }];
    return task;
}
- (NSURLSessionUploadTask *)uploadRequest_AF_Session {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *url = [NSURL URLWithString:@"http://example.com/upload"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURL *filePath = [NSURL fileURLWithPath:@"file:///Test/"];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Success: %@ %@", response, responseObject);
        }
    }];
    [uploadTask resume];
    return uploadTask;
}
- (NSURLSessionDownloadTask *)downloadRequest_AF_Session {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *url = [NSURL URLWithString:@"https://raw.githubusercontent.com/MagicianMalygos/MyDocuments/master/software/RTX_V1.1%20For%20Mac.dmg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        NSLog(@"%@ \n %@", targetPath, response);
        
        
        // 将下载得到的数据生成文件放在沙盒的Documents文件夹下
        // 沙盒路径 http://m.blog.csdn.net/article/details?id=51265014
        NSArray *patchs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        // Documents路径
        NSString *documentsDirectory = [patchs objectAtIndex:0];
        NSString *fileDirectory = [documentsDirectory stringByAppendingPathComponent:response.suggestedFilename? response.suggestedFilename: @"未知文件"];
        return [NSURL URLWithString:fileDirectory];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
    }];
    [downloadTask resume];
    return downloadTask;
}

@end
