//
//  MessageModel.m
//  MyServer
//
//  Created by 朱超鹏 on 2018/10/24.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self.sender = [dict[@"sender"] intValue];
    self.target = [dict[@"target"] intValue];
    self.content = dict[@"content"];
    return self;
}

- (NSDictionary *)dictionaryValue {
    return @{@"sender": @(self.sender),
             @"target": @(self.target),
             @"content": self.content?:@""};
}

@end
