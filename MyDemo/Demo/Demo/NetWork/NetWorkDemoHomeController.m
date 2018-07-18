
//
//  NetWorkDemoHomeController.m
//  Demo
//
//  Created by apple on 16/6/6.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "NetWorkDemoHomeController.h"
#import "ZCPURLSessionTool.h"
#import "ZCPAFNetworkingTool.h"

@implementation NetWorkDemoHomeController

@synthesize infoArr = _infoArr;

- (NSMutableArray *)infoArr {
    if (_infoArr == nil) {
        _infoArr = @[@{@"title": @"get同步",
                       @"sel": @"getRequest_Synchronouos",
                       @"type": @"session"},
                     @{@"title": @"post同步",
                       @"sel": @"postRequest_Synchronouos",
                       @"type": @"session"},
                     @{@"title": @"get异步",
                       @"sel": @"getRequest",
                       @"type": @"session"},
                     @{@"title": @"post异步",
                       @"sel": @"postRequest",
                       @"type": @"session"},
                     @{@"title": @"上传",
                       @"sel": @"uploadRequest",
                       @"type": @"session"},
                     @{@"title": @"下载",
                       @"sel": @"downloadRequest",
                       @"type": @"session"},
                     
                     @{@"title": @"get异步 AF",
                       @"sel": @"getRequest",
                       @"type": @"AF"},
                     @{@"title": @"post异步 AF",
                       @"sel": @"postRequest",
                       @"type": @"AF"},
                     @{@"title": @"上传 AF",
                       @"sel": @"uploadRequest",
                       @"type": @"AF"},
                     @{@"title": @"下载 AF",
                       @"sel": @"downloadRequest",
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

- (void)tableView:(UITableView *)tableView didSelectObject:(id<ZCPTableViewCellItemBasicProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath {
    SEL method = NSSelectorFromString([[self.infoArr objectAtIndex:indexPath.row] valueForKey:@"sel"]);
    
    NSObject *obj = nil;
    NSString *type = [[self.infoArr objectAtIndex:indexPath.row] valueForKey:@"type"];
    if ([type isEqualToString:@"session"]) {
        obj = [ZCPURLSessionTool new];
    } else if ([type isEqualToString:@"AF"]) {
        obj = [ZCPAFNetworkingTool new];
    } else if ([type isEqualToString:@"self"]) {
        obj = self;
    }
    
    if ([obj respondsToSelector:method]) {
        SuppressPerformSelectorLeakWarning({
            [obj performSelector:method];
        });
    }
}

#pragma mark - test
- (void)test {
    // 1. url中不能有中文
    NSString *urlStr1 = @"http://www.weather.com.cn/data/sk/101010100.html?username=1001&pwd=abc123";
    NSString *urlStr2 = @"http://www.weather.com.cn/data/sk/101010100.html?username=朱超鹏&pwd=abc123";
    // 如果参数有中文需要转码
    NSString *transformURLStr2 = [urlStr2 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
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
