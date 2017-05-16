

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
    /**
     根据关联对象的key从指定对象中获取关联对象
     
     @param self        从哪个对象中获取
     @param name_var    关联对象的key
     @return            关联对象
     */
    return objc_getAssociatedObject(self, &name_var);
}

- (void)setName:(NSString *)name {
    /**
     设置某个对象的关联对象
     
     @param self        给哪个对象添加关联
     @param name_var    关联对象的key
     @param name        关联对象
     @param OBJC_ASSOCIATION_COPY   关联策略
     */
    objc_setAssociatedObject(self, &name_var, name, OBJC_ASSOCIATION_COPY);
}

@end
