//
//  ZCPIndicator.m
//  ZCPKit
//
//  Created by zhuchaopeng on 16/9/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPIndicator.h"

@interface ZCPIndicator()

@property (nonatomic, assign) NSInteger loadingCount;

@end

@implementation ZCPIndicator

+ (nonnull instancetype)sharedInstance {
    static dispatch_once_t once;
    static id __singleton__;
    dispatch_once(&once, ^{
        __singleton__ = [[self alloc] init];
    });
    return __singleton__;
} \

#pragma mark - public methods
+ (void)showIndicator {
    // 显示状态栏菊花
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

+ (void)dismissIndicator {
    //隐藏状态栏菊花
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

+ (void)stopLoading {
    [ZCPIndicator sharedInstance].loadingCount --;
    if ([ZCPIndicator sharedInstance].loadingCount == 0) {
        [self dismissIndicator];
    }
}

@end
