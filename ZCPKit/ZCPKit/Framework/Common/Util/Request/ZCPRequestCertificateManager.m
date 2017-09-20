//
//  PARequestCertificateManager.m
//  ZCPKit
//
//  Created by zhuchaopeng on 16/9/21.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestCertificateManager.h"
#import "ZCPCategory.h"

typedef void (^ZCPRequestCertificateSuccessHandler)(void);
typedef void (^ZCPRequestCertificateFailureHandler)(void);

@interface ZCPRequestCertificateManager () <NSURLConnectionDelegate, NSURLSessionTaskDelegate>

@property (nonatomic, strong) NSURLConnection       *connection;
@property (nonatomic, strong) NSURLSessionDataTask  *task;

@property (nonatomic, copy) NSString                            *url;
@property (nonatomic, copy) ZCPRequestCertificateSuccessHandler successHandler;
@property (nonatomic, copy) ZCPRequestCertificateFailureHandler failureHandler;

@end

@implementation ZCPRequestCertificateManager

IMP_SINGLETON(ZCPRequestCertificateManager)

#pragma mark - public method

#pragma mark 允许https的证书通过
- (void)allowHttpsCertificate:(NSString *)httpsURL completion:(void(^)(void))completion {
    [self allowHttpsCertificate:httpsURL success:completion failure:completion];
}
#pragma mark 允许https的证书通过
- (void)allowHttpsCertificate:(NSString *)httpsURL success:(void (^)(void))success failure:(void (^)(void))failure {
    self.successHandler = success;
    self.failureHandler = failure;
    self.url = httpsURL;
    
    // 如果不是https的请求，可以不用处理证书
    if (![httpsURL contains:@"https"]) {
        if (self.successHandler) {
            self.successHandler();
        }
    } else {
        // 处理url里的中文，转码为UTF8
        NSString *urlString = [httpsURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        // 请求url处理证书
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
        
        // * * * 此处如果以后使用NSURLSession可以替换为sessionFun: * * *
        [self connectionFun:request];
//        [self sessionFun:request];
    }
}

#pragma mark - private method

- (void)connectionFun:(NSURLRequest *)request {
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self.connection start];
}
/*
    ps:12306之类的网站没办法认证其证书，qq聊天记录里点开12306的网站也是加载不出来的
 */
- (void)sessionFun:(NSURLRequest *)request {
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue currentQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request];
    [task resume];
}

#pragma mark - NSURLConnectionDelegate

#pragma mark 处理服务器返回的证书
- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge previousFailureCount] == 0) {
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
    } else {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
    }
}
#pragma mark 接收到服务器响应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if (self.successHandler) {
        self.successHandler();
    }
    [self.connection cancel];
}
#pragma mark 加载失败
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if (self.failureHandler) {
        self.failureHandler();
    }
}

#pragma mark - NSURLSessionTaskDelegate

#define mark 处理服务器返回的证书
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    __block NSURLCredential *credential = nil;
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        if (credential) {
            disposition = NSURLSessionAuthChallengeUseCredential;
        } else {
            disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        }
    } else {
        disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    }
    // 安装证书
    if (completionHandler) {
        completionHandler(disposition, credential);
    }
}
#pragma mark 接收到服务器的响应
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    completionHandler(NSURLSessionResponseAllow);
}
#pragma mark 加载结束
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error {
    if (error) {
        if (self.failureHandler) {
            self.failureHandler();
        }
    } else {
        if (self.successHandler) {
            self.successHandler();
        }
    }
}

@end
