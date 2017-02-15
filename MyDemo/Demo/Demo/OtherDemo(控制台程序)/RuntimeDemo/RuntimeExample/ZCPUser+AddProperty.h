//
//  ZCPUser+AddProperty.h
//  Demo
//
//  Created by 朱超鹏(外包) on 17/1/12.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "ZCPUser.h"

@interface ZCPUser (AddProperty)

@property (nonatomic, copy) NSString *name;
//@property (nonatomic, copy) NSString *age;

- (NSString *)name;
- (void)setName:(NSString *)name;

@end
