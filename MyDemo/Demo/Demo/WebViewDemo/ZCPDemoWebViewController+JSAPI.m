//
//  ZCPDemoWebViewController+JSAPI.m
//  Demo
//
//  Created by zcp on 2019/6/4.
//  Copyright © 2019 zcp. All rights reserved.
//

#import "ZCPDemoWebViewController+JSAPI.h"

@implementation ZCPDemoWebViewController (JSAPI)

// ----------------------------------------------------------------------
#pragma mark - block register
// ----------------------------------------------------------------------

- (void)registerJSAPI {
    [self.jsBridge registerHandler:@"getUserInfo" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"JS调用了Native方法：getUserInfo");
        NSDictionary *dic = data;
        NSString *secret = dic[@"secret"];
        if (![secret isEqualToString:@"zcp123"]) {
            return;
        }
        responseCallback(@{@"name": @"zcp", @"phone": @"17600000000"});
    }];
}

// ----------------------------------------------------------------------
#pragma mark - method register
// ----------------------------------------------------------------------

- (void)js_zcpMethod:(NSDictionary *)data responseCallback:(WVJBResponseCallback)responseCallback {
    NSLog(@"JS调用了Native方法：zcpMethod");
    NSDictionary *dic = data;
    NSString *secret = dic[@"secret"];
    if (![secret isEqualToString:@"zcp123"]) {
        return;
    }
    responseCallback(@{@"name": @"zcp", @"phone": @"17600000000"});
}

@end
