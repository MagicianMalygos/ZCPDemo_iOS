//
//  MessageModel.h
//  MyServer
//
//  Created by 朱超鹏 on 2018/10/24.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelProtocol.h"

@interface MessageModel : NSObject <ModelProtocol>

@property (nonatomic, assign) int sender;
@property (nonatomic, assign) int target;
@property (nonatomic, copy) NSString *content;

@end
