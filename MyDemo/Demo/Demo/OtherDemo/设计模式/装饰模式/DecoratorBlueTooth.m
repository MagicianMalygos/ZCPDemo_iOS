//
//  DecoratorBlueTooth.m
//  Demo
//
//  Created by 朱超鹏 on 2017/9/18.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "DecoratorBlueTooth.h"

@implementation DecoratorBlueTooth

@synthesize blueTooth = _blueTooth;

- (NSString *)callNumber {
    if (_blueTooth) {
        return [NSString stringWithFormat:@"%@%@", [super callNumber], @" with BlueTooth"];
    }
    return [NSString stringWithFormat:@"%@ call number fail, because blueTooth is not open", self.name];
}

- (NSString *)sendMessage {
    if (_blueTooth) {
        return [NSString stringWithFormat:@"%@%@", [super sendMessage], @" with BlueTooth"];
    }
    return [NSString stringWithFormat:@"%@ send message fail, because blueTooth is not open", self.name];
}

- (NSString *)openBlueTooth {
    _blueTooth = YES;
    return @"open blueTooth";
}

- (NSString *)closeBlueTooth {
    _blueTooth = NO;
    return @"close blueTooth";
}

@end
