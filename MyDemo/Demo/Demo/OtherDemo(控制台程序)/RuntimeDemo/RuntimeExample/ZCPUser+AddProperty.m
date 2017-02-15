

//
//  ZCPUser+AddProperty.m
//  Demo
//
//  Created by 朱超鹏(外包) on 17/1/12.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "ZCPUser+AddProperty.h"

/*
@interface ZCPUser () {
    NSString *_name;
}
@end
*/
 
@implementation ZCPUser (AddProperty)

//@dynamic age;

// @synthesize not allowed in a category`s implementation
// @synthesize name = _name;
// @dynamic name;

/*
- (NSString *)name {
    return _name;
}
- (void)setName:(NSString *)name {
    _name = name;
}
 */

static NSString *name_var = @"name";

/*
  属性关联策略
 OBJC_ASSOCIATION_ASSIGN = 0,           //关联对象的属性是弱引用
 OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1, //关联对象的属性是强引用并且关联对象不使用原子性
 OBJC_ASSOCIATION_COPY_NONATOMIC = 3,   //关联对象的属性是copy并且关联对象不使用原子性
 OBJC_ASSOCIATION_RETAIN = 01401,       //关联对象的属性是copy并且关联对象使用原子性
 OBJC_ASSOCIATION_COPY = 01403          //关联对象的属性是copy并且关联对象使用原子性
 */

- (NSString *)name {
    // 根据关联的key获取关联的值
    return objc_getAssociatedObject(self, &name_var);
}
- (void)setName:(NSString *)name {
    // param1：给那个对象添加关联
    // param2：关联的key
    // param3：关联的value
    // param4：关联的策略
    objc_setAssociatedObject(self, &name_var, name, OBJC_ASSOCIATION_COPY);
}

@end
