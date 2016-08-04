//
//  DemoTool.m
//  AFNetworking3.0
//
//  Created by 朱超鹏(外包) on 16/7/26.
//  Copyright © 2016年 朱超鹏. All rights reserved.
//

#import "DemoTool.h"
#import <AFNetworking.h>

#define SCHEME  @"http"
#define HOST    @"127.0.0.1:9527"
#define PATH    @"/test"
NSString *MakeURLString (NSString *scheme, NSString *host, NSString *path) {
    return [NSString stringWithFormat:@"%@://%@%@", scheme, host, path];
}

@implementation DemoTool

- (NSURLSessionTask *)GET {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.securityPolicy.allowInvalidCertificates = NO;
    
    NSURLSessionTask *task = [manager GET:MakeURLString(SCHEME, HOST, PATH) parameters:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"GET LOG: %f", (CGFloat)downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"GET LOG: Success: %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"GET LOG: Error: %@", error);
    }];
    return task;
}
- (NSURLSessionTask *)POST {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSURLSessionTask *task = [manager POST:MakeURLString(SCHEME, HOST, PATH) parameters:@{} progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"POST LOG: %f", (CGFloat)uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"POS LOG: Success: %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"POST LOG: Error: %@", error);
    }];
    return task;
}

// 有问题
- (NSURLSessionTask *)UPLOAD {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSURLSessionTask *task = [manager POST:@"" parameters:@{} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    [manager uploadTaskWithRequest:[NSURLRequest new] fromFile:[NSURL URLWithString:@""] progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
    }];
    [manager uploadTaskWithRequest:[NSURLRequest new] fromData:[NSData new] progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
    }];
    [manager uploadTaskWithStreamedRequest:[NSURLRequest new] progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
    }];
    [task resume];
    return task;
}

// 有问题
- (NSURLSessionTask *)DOWNLOAD {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSString *url = @"https://raw.githubusercontent.com/MagicianMalygos/MyDocuments/master/%E5%9B%BE/AFNetworking%E7%BD%91%E7%BB%9C%E8%AF%B7%E6%B1%82%E6%89%A7%E8%A1%8C%E6%B5%81%E7%A8%8B.png";
    url = @"http://25.io/mou/download/Mou_0.6.6.zip";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%lf", (CGFloat)downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSLog(@"DOWNLOAD LOG: 默认下载地址：%@", targetPath);
        NSURL *filePath = [NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]];
        return [filePath URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            NSLog(@"DOWNLOAD LOG: 下载失败");
            NSLog(@"DOWNLOAD LOG: %@", error);
        } else {
            NSLog(@"DOWNLOAD LOG: 下载完成");
            NSLog(@"DOWNLOAD LOG: %@", filePath);
        }
    }];
    [task resume];
    return task;
}

@end
