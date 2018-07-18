//
//  ZCPAFNetworkingTool.m
//  Demo
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPAFNetworkingTool.h"

@implementation ZCPAFNetworkingTool

- (NSURLSessionDataTask *)getRequest {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLSessionDataTask *task = [manager GET:GET_URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DebugLog(@"%@ %@", responseObject, [responseObject className]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DebugLog(@"Fetch Error: %@", error);
    }];
    return task;
}

- (NSURLSessionDataTask *)postRequest {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURLSessionDataTask *task = [manager POST:POST_URL parameters:POST_URL_PARAMS_DICT progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DebugLog(@"%@ %@", responseObject, [responseObject className]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DebugLog(@"Fetch Error: %@", error);
    }];
    return task;
}

- (NSURLSessionUploadTask *)uploadRequest {
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

- (NSURLSessionDownloadTask *)downloadRequest {
    // ! 当服务器返回的头信息中有Content-Length时，才能获取到下载文件的大小 !
    // 断点续传其实就是利用了http的range请求头
    
    // HEAD请求
    
    /**
     *  当头信息中无Content-Length时，第一次只有当在文件读取结束的时候才能知道文件的大小
     */
    

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *url = [NSURL URLWithString:@"https://raw.githubusercontent.com/MagicianMalygos/MyDocuments/master/software/RTX_V1.1%20For%20Mac.dmg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        NSLog(@"%@ \n %@", targetPath, response);
        
        //        NSLog(@"%@ %@", responseObject, [responseObject className]);
        //        NSLog(@"\n- - - - - Request - - - - -\n%@\n\n - - - - - Response - - - - -\n%@", operation.request, operation.response);
        //        NSLog(@"头信息：%@, 编码方式：%@, 文件名：%@", operation.response.allHeaderFields, operation.response.textEncodingName, operation.response.suggestedFilename);
        
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

#pragma mark - https

- (void)testHttps {
    // 设置使用自签名证书
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
    securityPolicy.allowInvalidCertificates = YES;      // 是否允许使用自签名证书
    securityPolicy.validatesDomainName = YES;            // 是否需要验证域名
//    securityPolicy.validatesCertificateChain    = NO;   // 是否校验证书链
    __weak AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.securityPolicy = securityPolicy;
    
    // 处理服务器质询（challenge）
//    [manager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession *session, NSURLAuthenticationChallenge *challenge, NSURLCredential *__autoreleasing *credential) {
//        SecTrustRef serverTrust = challenge.protectionSpace.serverTrust;    // 获取服务器trust object
//        NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"zcp" ofType:@"cer"];   // 导入自签名证书
//        NSData *caCert = [NSData dataWithContentsOfFile:cerPath];
//        NSArray *cerArr = @[caCert];
//        manager.securityPolicy.pinnedCertificates = cerArr;
//        
//        SecCertificateRef caRef = SecCertificateCreateWithData(NULL, (__bridge CFDataRef)caCert);
//        NSCAssert(caRef != nil, @"caRef is nil");
//        
//        NSArray *caArray = @[(__bridge id)caRef];
//        NSCAssert(caArray != nil, @"caArray is nil");
//        
//        OSStatus status = SecTrustSetAnchorCertificates(serverTrust, (__bridge CFArrayRef)caArray);
//        SecTrustSetAnchorCertificatesOnly(serverTrust, NO);
//        NSCAssert(errSecSuccess == status, @"SecTrustSetAnchorCertificates failed");
//        
//        // 选择质询认证的处理方式
//        NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
//        
//        __autoreleasing NSURLCredential *_credential = nil;
//        
//        // NSURLAuthenticationMethodServerTrust质询认证方式
//        if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
//            // 基于客户端的安全策略来决定是否信任该服务器，不信任则不响应质询
//            if ([manager.securityPolicy evaluateServerTrust:serverTrust forDomain:challenge.protectionSpace.host]) {
//                // 创建质询证书
//                _credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
//                // 确认质询方式
//                if (_credential) {
//                    disposition = NSURLSessionAuthChallengeUseCredential;
//                } else {
//                    disposition = NSURLSessionAuthChallengePerformDefaultHandling;
//                }
//            } else {
//                // 取消质询
//                disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
//            }
//        } else {
//            disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
//        }
//        return disposition;
//    }];
    
    NSString *url = @"https://blog.xxwu.me/p/user/login.jhtml";
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Success");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Fetch Error: %@", error);
    }];
}

@end
