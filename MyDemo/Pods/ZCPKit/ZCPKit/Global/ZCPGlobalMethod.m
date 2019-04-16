//
//  ZCPGlobalMethod.m
//  ZCPKit
//
//  Created by 朱超鹏 on 2018/6/15.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "ZCPGlobalMethod.h"
#import <pthread.h>

CGFloat ZCPScreenScale() {
    static CGFloat __scale = 0.0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSCAssert(0 != pthread_main_np(), @"This function must be called on the main thread");
        __scale = [[UIScreen mainScreen] scale];
    });
    return __scale;
}
