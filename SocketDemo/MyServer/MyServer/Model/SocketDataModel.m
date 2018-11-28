//
//  SocketDataModel.m
//  MyClient
//
//  Created by 朱超鹏 on 2018/10/25.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "SocketDataModel.h"

@implementation SocketDataModel

- (instancetype)initWithData:(NSData *)data {
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    self.method = dict[@"method"];
    self.body = dict[@"body"];
    return self;
}

- (NSData *)dataValue {
    NSDictionary *dict = @{@"method": self.method?:@"", @"body": self.body?:@""};
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:nil];
    return data;
}

@end
