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

#pragma mark - public method

- (NSURLSessionDataTask *)getRequest_Synchronouos {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL(GET_URL)];
    [request setHTTPMethod:@"GET"];
    return [self request:request queue:[NSOperationQueue mainQueue]];
}

- (NSURLSessionDataTask *)postRequest_Synchronouos {
    NSString *params = POST_URL_PARAMS;
    NSData *paramsData = [params dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL(POST_URL)];
    [request setHTTPMethod:@"POST"];
    request.HTTPBody = paramsData;
    return [self request:request queue:[NSOperationQueue mainQueue]];
}

- (NSURLSessionDataTask *)getRequest {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL(GET_URL)];
    [request setHTTPMethod:@"GET"];
    return [self request:request queue:[NSOperationQueue new]];
}

- (NSURLSessionDataTask *)postRequest {
    NSString *params = POST_URL_PARAMS;
    NSData *paramsData = [params dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL(POST_URL)];
    [request setHTTPMethod:@"POST"];
    request.HTTPBody = paramsData;
    return [self request:request queue:[NSOperationQueue new]];
}

- (NSURLSessionUploadTask *)uploadRequest {
    return nil;
}

- (NSURLSessionDownloadTask *)downloadRequest {
    return nil;
}

#pragma mark <help method>

- (NSURLSessionDataTask *)request:(NSURLRequest *)request queue:(NSOperationQueue *)queue {
    // 1.代理方式 2.block方式
    int type = 2;
    
    if (type == 1) {
        
        /*
         1.创建会话
         configuration: 会话对象的配置信息，defaultSessionConfiguration为默认配置
         delegate: 代理
         queue: 决定代理方法在哪个线程中调用
         */
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:queue];
        // 2.创建任务
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
        // 3.唤醒任务
        [dataTask resume];
        return dataTask;
        
    } else if (type == 2) {
        
        // 1.创建会话
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:queue];
        // 2.创建任务
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                NSLog(@"Fetch Error: %@", error);
            } else {
                NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"%@", result);
            }
        }];
        // 3.唤醒任务
        [dataTask resume];
        return dataTask;
        
    }
    return nil;
}

#pragma mark - NSURLSessionDataDelegate

/**
 当任务收到响应时会执行该方法。
 直到completionHandler block被调用之后，才会进一步接收响应。
 可以使用NSURLSessionResponseDisposition参数来取消任务或者将数据任务转换为下载任务。
 该方法可选实现，如果不实现，可以在task中拿到response
 该方法在后台进行上传任务时不会回调。（由于无法转换为下载任务）
 
 e.如果不实现该方法，默认为NSURLSessionResponseAllow。如果实现了却不执行completionHandler，则本次请求将不会继续下去。
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    /*
     需要使用completionHandler回调告诉系统应该如何处理服务器返回的数据
     NSURLSessionResponseCancel          取消加载，与[task cancel]相同
     NSURLSessionResponseAllow           允许继续加载
     NSURLSessionResponseBecomeDownload  变成一个下载请求
     NSURLSessionResponseBecomeStream    变成一个流任务，iOS9之后可用
     */
    completionHandler(NSURLSessionResponseAllow);
}

/**
 当接收到服务器返回的数据且数据可用时会调用该方法。
 由于数据可能是不连续的，应该使用[NSData enumerateByteRangesUsingBlock:]方法去接收它
 
 e.如果数据较大那么该方法可能会调用多次
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    // 拼接服务器返回的数据
    [self.responseData appendData:data];
}

/**
 通知数据任务已经变成了下载任务，后续的消息将不会发送给数据任务
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask {
    
}

/**
 通知数据任务已经变成了双向的流任务，后续的消息将不会发送给数据任务
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didBecomeStreamTask:(NSURLSessionStreamTask *)streamTask {
    
}

/**
 缓存相关。
 在某个task对应的URLSession:dataTask:didReceiveData:最后一次被调用（也就是获取完某个Response中所有的data）后被调用
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask willCacheResponse:(NSCachedURLResponse *)proposedResponse completionHandler:(void (^)(NSCachedURLResponse * _Nullable cachedResponse))completionHandler {
    
    /*
     应该在此方法中执行Handler，传入的NSCachedURLResponse表明了代理对于缓存的存储控制
     
     若传入NULL，表明不允许缓存响应
     若传入proposedResponse，表示缓存原始响应
     若传入修改后的NSCachedURLResponse对象，则表示存储该对象（可在其userInfo中添加需要额外存储的信息）
     这个方法只有允许缓存的条件下才会被调用，以确定用户最后的存储控制策略，具体包括
     
     The provided response came from the server, rather than out of the cache
     The session configuration’s cache policy allows caching.
     The provided NSURLRequest object's cache policy(if applicable) allows caching.
     The cache-related headers in the server’s response (if present) allow caching.
     response尺寸足够小（比如当缓存在磁盘上时，所缓存的内容不能大于磁盘大小的5%）
     */
    completionHandler(NULL);
}

#pragma mark - NSURLSessionTaskDelegate

/**
 当任务完成时调用
 eror可能为nil，表示该任务成功，未发生错误。
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error) {
        NSLog(@"Fetch Error: %@", error);
    } else {
        NSString *result = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
        NSLog(@"%@", result);
    }
}

/**
 使用流来上传信息时，因为会话对象不能保证必定能从提供的流中读取数据，比如认证失败的情况，所以app需要提供一个新的流以便会话重新进行请求
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task needNewBodyStream:(void (^)(NSInputStream * _Nullable bodyStream))completionHandler {
    
}

/**
 每隔一段时间将调用该方法告知上传进度。
 该信息也保存在task中
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
    
}

/**
 当HTTP请求尝试重定向到一个不同的URL时调用。
 需要执行completionHandler来完成重定向。
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler {
    
}

/**
 只要请求的地址是HTTPS的，就会调用这个代理方法
 我们需要在该方法中告诉系统，是否信任服务器返回的证书
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    
}

#pragma mark - getters and setters

- (NSMutableData *)responseData {
    if (_responseData == nil) {
        _responseData = [[NSMutableData alloc] init];
    }
    return _responseData;
}

@end
