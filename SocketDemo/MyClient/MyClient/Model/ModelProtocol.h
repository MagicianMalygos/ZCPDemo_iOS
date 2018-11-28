//
//  ModelProtocol.h
//  MyServer
//
//  Created by 朱超鹏 on 2018/10/24.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModelProtocol <NSObject>

- (instancetype)initWithDict:(NSDictionary *)dict;
- (NSDictionary *)dictionaryValue;

@end
