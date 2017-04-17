
//
//  NetWorkDemoHomeController.m
//  Demo
//
//  Created by apple on 16/6/6.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "NetWorkDemoHomeController.h"
#import "ZCPURLConnectionTool.h"
#import "ZCPURLSessionTool.h"
#import "ZCPAFNetworkingTool.h"

@implementation NetWorkDemoHomeController

@synthesize infoArr = _infoArr;

- (NSMutableArray *)infoArr {
    if (_infoArr == nil) {
        _infoArr = @[@{@"title": @"get异步 Connection",
                       @"sel": @"getRequest_Asynchronous_Connection",
                       @"type": @"connection"},
                     @{@"title": @"post异步 Connection",
                       @"sel": @"postRequest_Asynchronous_Connection",
                       @"type": @"connection"},
                     @{@"title": @"下载 Connection",
                       @"sel": @"uploadRequest_Connection",
                       @"type": @"connection"},
                     
                     @{@"title": @"get同步 Session",
                       @"sel": @"getRequest_Synchronouos_Session",
                       @"type": @"session"},
                     @{@"title": @"post异步 Session",
                       @"sel": @"postRequest_Asynchronous_Session",
                       @"type": @"session"},
                     
                     @{@"title": @"get异步 AF",
                       @"sel": @"getRequest_Asynchronous_AF",
                       @"type": @"AF"},
                     @{@"title": @"post异步 AF",
                       @"sel": @"postRequest_Asynchronous_AF",
                       @"type": @"AF"},
                     @{@"title": @"上传 AF",
                       @"sel": @"uploadRequest_AF",
                       @"type": @"AF"},
                     @{@"title": @"下载 AF",
                       @"sel": @"downloadRequest_AF",
                       @"type": @"AF"},
                     @{@"title": @"get异步 AF Session",
                       @"sel": @"getRequest_Asynchronous_AF_Session",
                       @"type": @"AF"},
                     @{@"title": @"post异步 AF Session",
                       @"sel": @"postRequest_Asynchronous_AF_Session",
                       @"type": @"AF"},
                     @{@"title": @"上传AF Session",
                       @"sel": @"uploadRequest_AF_Session",
                       @"type": @"AF"},
                     @{@"title": @"下载AF Session",
                       @"sel": @"downloadRequest_AF_Session",
                       @"type": @"AF"},
                     @{@"title": @"测试Https",
                       @"sel": @"testHttps",
                       @"type": @"AF"},
                     @{@"title": @"测试",
                       @"sel": @"test",
                       @"type": @"self"}].mutableCopy;
    }
    return _infoArr;
}

- (void)didSelectCell:(NSIndexPath *)indexPath {
    SEL method = NSSelectorFromString([[self.infoArr objectAtIndex:indexPath.row] valueForKey:@"sel"]);
    
    NSObject *object = nil;
    NSString *type = [[self.infoArr objectAtIndex:indexPath.row] valueForKey:@"type"];
    if ([type isEqualToString:@"connection"]) {
        object = [ZCPURLConnectionTool new];
    } else if ([type isEqualToString:@"session"]) {
        object = [ZCPURLSessionTool new];
    } else if ([type isEqualToString:@"AF"]) {
        object = [ZCPAFNetworkingTool new];
    } else if ([type isEqualToString:@"self"]) {
        object = self;
    }
    
    if ([object respondsToSelector:method]) {
        SuppressPerformSelectorLeakWarning({
            [object performSelector:method];
        });
    }
}

#pragma mark - test
- (void)test {
    // 1. url中不能有中文
    NSString *urlStr1 = @"http://www.weather.com.cn/data/sk/101010100.html?username=1001&pwd=abc123";
    NSString *urlStr2 = @"http://www.weather.com.cn/data/sk/101010100.html?username=朱超鹏&pwd=abc123";
    // 如果参数有中文需要转码
    NSString *transformURLStr2 = [urlStr2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:urlStr1];
    NSURL *url2 = [NSURL URLWithString:urlStr2];
    NSURL *url3 = [NSURL URLWithString:transformURLStr2];
    NSLog(@"URL1: %@, URL2: %@, URL3: %@", url1, url2, url3);
    
    // 2. 添加http头信息
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url3];
    [request setValue:@"ios" forHTTPHeaderField:@"User-Agent"];
    
    // 3.任何NSURLRequest默认都是get请求
    
}

@end
