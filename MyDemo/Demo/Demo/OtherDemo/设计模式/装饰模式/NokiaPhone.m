//
//  NokiaPhone.m
//  Demo
//
//  Created by 朱超鹏 on 2017/9/18.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "NokiaPhone.h"

@implementation NokiaPhone

- (instancetype)init {
    if (self = [super init]) {
        self.name = @"Nokia";
    }
    return self;
}

- (NSString *)callNumber {
    return [NSString stringWithFormat:@"%@ %@", self.name, [super callNumber]];
}

- (NSString *)sendMessage {
    return [NSString stringWithFormat:@"%@ %@", self.name, [super sendMessage]];
}

@end
