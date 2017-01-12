//
//  OCClassPropertyDemo.m
//  Demo
//
//  Created by 朱超鹏(外包) on 17/1/12.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "OCClassPropertyDemo.h"

@implementation OCClassPropertyDemo

- (void)run {
    
    // 1.给分类添加属性
    /*
     http://www.jianshu.com/p/3cbab68fb856
     
     1.当直接在category中加属性使用时，会crash。
     *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[ZCPUser setName:]: unrecognized selector sent to instance 0x60000001f2d0'
     
     
     2.在加了get set方法和@synthesize之后，编译不通过。
     @synthesize not allowed in a category`s implementation
     
     3.将@synthesize改为@dynamic依旧不行，然后又加了一个扩展，依旧编译不通过。
     Undefined symbols for architecture x86_64:
     "_OBJC_IVAR_$_ZCPUser._name", referenced from:
     -[ZCPUser(AddProperty) name] in ZCPUser+AddProperty.o
     -[ZCPUser(AddProperty) setName:] in ZCPUser+AddProperty.o
     ld: symbol(s) not found for architecture x86_64
     
     4.runtime解决问题
     objc_getAssociatedObject(self, &name_var);
     objc_setAssociatedObject(self, &name_var, name, OBJC_ASSOCIATION_COPY);
     
     */
    
    ZCPUser *user = [ZCPUser new];
    user.uID = @"001";
    user.name = @"Zcp大官人";
    ZCPLog(@"id: %@, name: %@", user.uID, user.name);
}

@end
