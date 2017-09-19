//
//  Phone.m
//  Demo
//
//  Created by 朱超鹏 on 2017/9/18.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "Phone.h"

@implementation Phone

@synthesize name = _name;

- (instancetype)init {
    if (self = [super init]) {
        self.name = @"phone";
    }
    return self;
}

- (NSString *)callNumber {
    return @"call number";
}

- (NSString *)sendMessage {
    return @"send message";
}

@end
