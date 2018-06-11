//
//  ARManager.m
//  ARDemo
//
//  Created by 朱超鹏 on 2017/11/15.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "ARManager.h"

@implementation ARManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static ARManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[ARManager alloc] init];
    });
    return instance;
}

- (ARSession *)sharedSession {
    if (!_sharedSession) {
        _sharedSession = [[ARSession alloc] init];
    }
    return _sharedSession;
}

@end
