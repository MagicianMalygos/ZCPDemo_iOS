//
//  ZCPURLSessionTool.m
//  Demo
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPURLSessionTool.h"

@interface ZCPURLSessionTool () <NSURLSessionDataDelegate>

@property (nonatomic, strong) NSMutableData *responseData;

@end

@implementation ZCPURLSessionTool

#pragma mark - getter / setter
- (NSMutableData *)responseData {
    if (_responseData == nil) {
        _responseData = [[NSMutableData alloc] init];
    }
    return _responseData;
}

#pragma mark - public method
- (void)getRequest_Synchronouos_Session {
    // 1.request
    NSURLRequest *request = [NSURLRequest requestWithURL:GET_URL];
    /**
     *  2.创建会话
     *  第一个参数：会话对象的配置信息，defaultSessionConfiguration为默认配置
     *  第二个参数：代理
     *  第三个参数：决定代理方法在哪个线程中调用
     */
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    // 3.根据会话创建一个Task
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    // 4.唤醒任务
    [dataTask resume];
    
    // 如果使用默认request，可以使用如下方法
    //    [session dataTaskWithURL:GET_URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    //    }];
}
- (void)postRequest_Asynchronous_Session {
    
    // 1.url
    // 2.参数转换为NSData类型
    NSString *params = POST_URL_PARAMS;
    NSData *paramsData = [params dataUsingEncoding:NSUTF8StringEncoding];
    // 3.request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:POST_URL];
    // 4.设置请求方式 和 请求参数
    request.HTTPMethod = @"POST";
    request.HTTPBody = paramsData;
    // 5.创建会话
    NSURLSession *session = [NSURLSession sharedSession];
    // 6.根据会话创建一个Task
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"Main:%p, Curr:%p", [NSThread mainThread], [NSThread currentThread]);
        // 挂起当前线程，模拟网络延迟
        sleep(5);
        
        if (error) {
            NSLog(@"Fetch Error: %@", error);
        } else {
            NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@", result);
        }
    }];
    [dataTask resume];
}

#pragma mark - NSURLSessionDataDelegate
#pragma mark 接收到服务器响应的时候调用该方法
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    
    NSLog(@"Main:%p, Curr:%p", [NSThread mainThread], [NSThread currentThread]);
    /**
     *  需要使用completionHandler回调告诉系统应该如何处理服务器返回的数据
     *  默认是取消的
        NSURLSessionResponseCancel          默认的处理方式，取消
        NSURLSessionResponseAllow           接收服务器返回的数据
        NSURLSessionResponseBecomeDownload  变成一个下载请求
        NSURLSessionResponseBecomeStream    变成一个流
     */
    completionHandler(NSURLSessionResponseAllow);
}
#pragma mark 接收到服务器返回的数据的时候会调用该方法，如果数据较大那么该方法可能会调用多次
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    NSLog(@"Main:%p, Curr:%p", [NSThread mainThread], [NSThread currentThread]);
    // 拼接服务器返回的数据
    [self.responseData appendData:data];
}
#pragma mark 当请求完成的时候回调用此方法，如果请求失败，则error有值
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSLog(@"Main:%p, Curr:%p", [NSThread mainThread], [NSThread currentThread]);
    
    if (error) {
        NSLog(@"Fetch Error: %@", error);
    } else {
        NSString *result = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
        NSLog(@"%@", result);
    }
}


@end
