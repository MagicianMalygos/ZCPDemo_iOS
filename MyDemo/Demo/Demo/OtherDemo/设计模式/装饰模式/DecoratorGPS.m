//
//  DecoratorGPS.m
//  Demo
//
//  Created by 朱超鹏 on 2017/9/18.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "DecoratorGPS.h"

@implementation DecoratorGPS

@synthesize gps = _gps;

- (NSString *)callNumber {
    if (_gps) {
        return [NSString stringWithFormat:@"%@%@", [super callNumber], @" with GPS"];
    }
    return [NSString stringWithFormat:@"%@ call number fail, because gps is not open", self.name];
}

- (NSString *)sendMessage {
    if (_gps) {
        return [NSString stringWithFormat:@"%@%@", [super sendMessage], @" with GPS"];
    }
    return [NSString stringWithFormat:@"%@ send message fail, because gps is not open", self.name];
}

- (NSString *)openGPS {
    _gps = YES;
    return @"open gps";
}

- (NSString *)closeGPS {
    _gps = NO;
    return @"close gps";
}

@end
