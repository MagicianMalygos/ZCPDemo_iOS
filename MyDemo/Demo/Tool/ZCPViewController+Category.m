//
//  ZCPViewController+Category.m
//  Demo
//
//  Created by 朱超鹏 on 2017/10/11.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "ZCPViewController.h"
#import <Aspects.h>

@implementation ZCPViewController (Category)

+ (void)load {
    [ZCPViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated) {
        ZCPViewController *instance = aspectInfo.instance;
        NSArray *arguments = aspectInfo.arguments;
        [instance hook_viewWillAppear:arguments[0]];
    } error:nil];
}

- (void)hook_viewWillAppear:(BOOL)animated {
    NSLog(@"%@ will Appear", NSStringFromClass(self.class));
}

@end
