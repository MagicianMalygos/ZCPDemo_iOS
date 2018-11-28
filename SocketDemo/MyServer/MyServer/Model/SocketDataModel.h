//
//  SocketDataModel.h
//  MyClient
//
//  Created by 朱超鹏 on 2018/10/25.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SocketDataModel : NSObject

@property (nonatomic, assign) int socket;
@property (nonatomic, copy) NSString *method;
@property (nonatomic, copy) NSString *body;

- (instancetype)initWithData:(NSData *)data;
- (NSData *)dataValue;

@end

NS_ASSUME_NONNULL_END
