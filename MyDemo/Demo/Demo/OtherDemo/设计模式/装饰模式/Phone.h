//
//  Phone.h
//  Demo
//
//  Created by 朱超鹏 on 2017/9/18.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PhoneProtocol

@property (nonatomic, copy) NSString *name;

- (NSString *)callNumber;
- (NSString *)sendMessage;

@end

@interface Phone : NSObject <PhoneProtocol>

@end
