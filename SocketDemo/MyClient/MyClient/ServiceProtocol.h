//
//  ServiceProtocol.h
//  MyClient
//
//  Created by 朱超鹏 on 2018/10/25.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ClientProtocol <NSObject>

- (void)callback_updateUserList:(NSString *)body;
- (void)callback_receiveMessage:(NSString *)body;
- (void)callback_login:(NSString *)body;

@end

@protocol ServerProtocol <NSObject>

- (void)api_changeUserName:(NSString *)body;
- (void)api_sendMessage:(NSString *)body;

@end
