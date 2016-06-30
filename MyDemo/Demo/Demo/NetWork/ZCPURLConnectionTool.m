//
//  ZCPURLConnectionTool.m
//  Demo
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPURLConnectionTool.h"

@interface ZCPOperation : NSOperation <NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *conn;
@property (nonatomic, strong) NSURLRequest *request;
@property (nonatomic, strong) NSOutputStream *outputStream;
@property (nonatomic, strong) NSThread *requestThread;
@property (nonatomic, strong) id responseData;

- (instancetype)initWithRequest:(NSURLRequest *)request;

@end
@implementation ZCPOperation

- (instancetype)initWithRequest:(NSURLRequest *)request {
    if (self = [super init]) {
        _request = request;
    }
    return self;
}

- (void)start {
    if ([self isCancelled]) {
        
    } else if ([self isReady]) {
        NSThread *thread = self.requestThread;
        [self performSelector:@selector(didStart) onThread:thread withObject:nil waitUntilDone:NO];
    }
}

- (void)didStart {
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    
    self.conn = [[NSURLConnection alloc] initWithRequest:self.request delegate:self startImmediately:NO];
    
    [self.conn scheduleInRunLoop:runLoop forMode:NSRunLoopCommonModes];
    [self.outputStream scheduleInRunLoop:runLoop forMode:NSRunLoopCommonModes];
    
    [self.conn start];
    [self.outputStream open];
}
- (void)didCancel {
    NSLog(@"Did Cancel!");
}

- (NSThread *)requestThread {
    if (!_requestThread) {
        _requestThread = [[NSThread alloc] initWithTarget:self selector:@selector(requestThreadEntryPoint) object:nil];
        [_requestThread start];
    }
    return _requestThread;
}
- (void)requestThreadEntryPoint {
    @autoreleasepool {
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        // 不让runloop进入休眠
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    }
}

#pragma mark - NSURLConnectionDataDelegate
// 将要发送request时调用
- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response {
    NSLog(@"send thread:%p", [NSThread currentThread]);
    return request;
}
// 接收到response
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"receive thread:%p", [NSThread currentThread]);
    NSLog(@"%@", response);
}
// 接收到数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSUInteger length = [data length];
    while (YES) {
        NSInteger totalNumberOfBytesWritten = 0;
        if ([self.outputStream hasSpaceAvailable]) {
            const uint8_t *dataBuffer = (uint8_t *)[data bytes];
            
            NSInteger numberOfBytesWritten = 0;
            while (totalNumberOfBytesWritten < (NSInteger)length) {
                numberOfBytesWritten = [self.outputStream write:&dataBuffer[(NSUInteger)totalNumberOfBytesWritten] maxLength:(length - (NSUInteger)totalNumberOfBytesWritten)];
                if (numberOfBytesWritten == -1) {
                    break;
                }
                totalNumberOfBytesWritten += numberOfBytesWritten;
            }
            break;
        }
    }
}
// 连接出错
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Fetch Error: %@", error);
}
// 上传相关
- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite {
}
// 缓存相关
- (nullable NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return cachedResponse;
}
// 连接结束
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    self.responseData = [self.outputStream propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
    NSString *result = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
    //    NSLog(@"%@，%@", self.responseData, result);
}

#pragma mark - getter
- (NSOutputStream *)outputStream {
    if (!_outputStream) {
        _outputStream = [NSOutputStream outputStreamToMemory];
    }
    return _outputStream;
}

@end







@interface ZCPURLConnectionTool ()

@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation ZCPURLConnectionTool

#pragma mark -
- (NSOperationQueue *)queue {
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

#pragma mark -

#pragma mark get异步
/**
 2.初始化请求对象
 url:请求求访问路径、cachePolicy:缓存协议、timeoutInterval:网络请求超时时间
 
 其中缓存协议是个枚举类型包含：
 NSURLRequestUseProtocolCachePolicy（基础策略）
 NSURLRequestReloadIgnoringLocalCacheData（忽略本地缓存）
 NSURLRequestReturnCacheDataElseLoad（首先使用缓存，如果没有本地缓存，才从原地址下载）
 NSURLRequestReturnCacheDataDontLoad（使用本地缓存，从不下载，如果本地没有缓存，则请求失败，此策略多用于离线操作）
 NSURLRequestReloadIgnoringLocalAndRemoteCacheData（无视任何缓存策略，无论是本地的还是远程的，总是从原地址重新下载）
 NSURLRequestReloadRevalidatingCacheData（如果本地缓存是有效的则不下载，其他任何情况都从原地址重新下载）
 */
- (void)getRequest_Asynchronous_Connection {
    
    NSLog(@" - - - - - get 异步 - - - - - ");
    
    // 1.url
    // 2.request
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:GET_URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    // 3.创建连接
    /**
        加载请求是在系统自己私有的一个线程中进行的，
        同步请求：会拥塞发送请求的线程（此处系统自己的私有线程是否就是主线程？）
        异步请求：不会拥塞发送请求的线程
        delegate方法和块：执行在发送请求的线程中
        sendAsynchronousRequest:queue:completionHandler:方法中的queue参数决定了是在哪个线程中发送请求
     */
    // 5.建立连接 （使用newQueue，在子线程中发起请求）
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        /** 此处两个线程相同，在子线程中发起请求，完成块的执行也在该线程中 */
        NSLog(@"Main:%p, Curr:%p", [NSThread mainThread], [NSThread currentThread]);
        
        if (connectionError) {
            NSLog(@"Fetch Error: %@", connectionError);
        } else {
            NSString *resultStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@", resultStr);
        }
        sleep(5); // 阻塞当前线程，测试是否是在子线程中执行
    }];
}

#pragma mark post异步
- (void)postRequest_Asynchronous_Connection {
    NSLog(@" - - - - - post 异步 - - - - - ");
    
    // 1.url
    // 2.参数转换为NSData类型
//    NSString *params = POST_URL_PARAMS;
    NSString *params = @"https://github.com/MagicianMalygos/MyDocuments/archive/master.zip";
    NSData *paramsData = [params dataUsingEncoding:NSUTF8StringEncoding];
    // 3.request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:POST_URL];
    // 4.设置请求方式 和 请求参数
    request.HTTPMethod = @"POST";
    request.HTTPBody = paramsData;
    // 5.建立连接 （使用mainQueue，在主线程中发起请求）
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        /** 此处两个线程相同，在主线程中发起请求，完成块的执行也在该线程中 */
        NSLog(@"Main:%p, Curr:%p", [NSThread mainThread], [NSThread currentThread]);
        
        if (connectionError) {
            NSLog(@"Fetch Error: %@", connectionError);
        } else {
            NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@", result);
        }
        sleep(5); // 阻塞当前线程，测试是否是在主线程中执行
    }];
}

#pragma mark 下载
- (void)uploadRequest_Connection {
    // 1.url
    NSString *url = @"https://github.com/MagicianMalygos/MyDocuments/archive/master.zip";
    // 2.request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    // 3.connection
    ZCPOperation *operation = [[ZCPOperation alloc] initWithRequest:request];
    NSLog(@"main thread:%p, operation thread:%p", [NSThread mainThread], operation.requestThread);
    
    [self.queue addOperation:operation];
}

@end

