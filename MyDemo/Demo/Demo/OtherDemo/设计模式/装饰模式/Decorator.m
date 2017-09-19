//
//  Decorator.m
//  Demo
//
//  Created by 朱超鹏 on 2017/9/18.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "Decorator.h"

@implementation Decorator

@synthesize phone = _phone;

- (instancetype)initWithPhone:(id<PhoneProtocol>)phone {
    if (self = [super init]) {
        _phone = phone;
    }
    return self;
}

- (NSString *)name {
    return _phone.name;
}
- (void)setName:(NSString *)name {
    [_phone setName:name];
}

- (NSString *)callNumber {
    return [_phone callNumber];
}

- (NSString *)sendMessage {
    return [_phone sendMessage];
}

@end
