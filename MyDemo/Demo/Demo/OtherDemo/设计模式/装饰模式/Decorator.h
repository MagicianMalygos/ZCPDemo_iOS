//
//  Decorator.h
//  Demo
//
//  Created by 朱超鹏 on 2017/9/18.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "Phone.h"

@protocol DecoratorProtocol <PhoneProtocol>

@property (nonatomic, strong) id<PhoneProtocol> phone;
- (instancetype)initWithPhone:(id<PhoneProtocol>)phone;

@end

@interface Decorator : NSObject <DecoratorProtocol>

@end
