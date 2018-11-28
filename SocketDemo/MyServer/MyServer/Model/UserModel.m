//
//  UserModel.m
//  MyServer
//
//  Created by 朱超鹏 on 2018/10/24.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self.userId = [dict[@"userId"] intValue];
    self.name = dict[@"name"];
    return self;
}

- (NSDictionary *)dictionaryValue {
    return @{@"userId": @(self.userId),
             @"name": self.name?:@""
             };
}

@end
