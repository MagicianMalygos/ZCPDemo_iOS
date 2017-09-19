//
//  Nokia5230Phone.m
//  Demo
//
//  Created by 朱超鹏 on 2017/9/18.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "Nokia5230Phone.h"

@implementation Nokia5230Phone

@synthesize gps = _gps;
@synthesize blueTooth = _blueTooth;

- (NSString *)callNumberWithGPS {
    if (_gps) {
        return [NSString stringWithFormat:@"%@%@", [super callNumber], @" with GPS"];
    }
    return [NSString stringWithFormat:@"%@ call number fail, because gps is not open", self.name];
}

- (NSString *)sendMessageWithGPS {
    if (_gps) {
        return [NSString stringWithFormat:@"%@%@", [super sendMessage], @" with GPS"];
    }
    return [NSString stringWithFormat:@"%@ send message fail, because gps is not open", self.name];
}

- (NSString *)callNumberWithBlueTooth {
    if (_blueTooth) {
        return [NSString stringWithFormat:@"%@%@", [super callNumber], @" with BlueTooth"];
    }
    return [NSString stringWithFormat:@"%@ call number fail, because blueTooth is not open", self.name];
}

- (NSString *)sendMessageWithBlueTooth {
    if (_blueTooth) {
        return [NSString stringWithFormat:@"%@%@", [super sendMessage], @" with BlueTooth"];
    }
    return [NSString stringWithFormat:@"%@ send message fail, because blueTooth is not open", self.name];
}

- (NSString *)callNumberWithGPSAndBlueTooth {
    if (_gps && _blueTooth) {
        return [NSString stringWithFormat:@"%@%@%@", [super callNumber], @" with GPS", @" with BlueTooth"];
    } else if (!_gps) {
        return [NSString stringWithFormat:@"%@ call number fail, because GPS is not open", self.name];
    } else if (!_blueTooth) {
        return [NSString stringWithFormat:@"%@ call number fail, because blueTooth is not open", self.name];
    }
    return @"";
}

- (NSString *)sendMessageWithGPSAndBlueTooth {
    if (_gps && _blueTooth) {
        return [NSString stringWithFormat:@"%@%@%@", [super sendMessage], @" with GPS", @" with BlueTooth"];
    } else if (!_gps) {
        return [NSString stringWithFormat:@"%@ send message fail, because GPS is not open", self.name];
    } else if (!_blueTooth) {
        return [NSString stringWithFormat:@"%@ send message fail, because blueTooth is not open", self.name];
    }
    return @"";
}

- (NSString *)openGPS {
    _gps = YES;
    return @"open gps";
}

- (NSString *)closeGPS {
    _gps = NO;
    return @"close gps";
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
