//
//  ZCPUser.m
//  Demo
//
//  Created by 朱超鹏(外包) on 17/1/12.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "ZCPUser.h"
#import "ZCPUserMethod.h"

@implementation ZCPUser

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    // 可以拿到@property定义的属性，但是拿不到成员变量
    unsigned int propertyCount = 0;
    objc_property_t *propertys = class_copyPropertyList([ZCPUser class], &propertyCount);
    for (int i = 0; i < propertyCount; i++) {
        objc_property_t property = propertys[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    
    // 可以拿到类中定义的成员变量和成员属性，但是拿不到分类中通过runtime增加的成员属性
    unsigned int ivarCount = 0;
    Ivar *ivars = class_copyIvarList([ZCPUser class], &ivarCount);
    for (int i = 0; i < ivarCount; i++) {
        // 取出成员变量
        Ivar ivar = ivars[i];
        // 获取成员变量名
        const char *name = ivar_getName(ivar);
        // 归档
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(ivars);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        
        unsigned int propertyCount = 0;
        objc_property_t *propertys = class_copyPropertyList([ZCPUser class], &propertyCount);
        for (int i = 0; i < propertyCount; i++) {
            objc_property_t property = propertys[i];
            NSString *key = [NSString stringWithUTF8String:property_getName(property)];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        
        unsigned int ivarCount = 0;
        Ivar *ivars = class_copyIvarList([ZCPUser class], &ivarCount);
        for (int i = 0; i < ivarCount; i++) {
            // 取出成员变量
            Ivar ivar = ivars[i];
            // 获取成员变量名
            const char *name = ivar_getName(ivar);
            // 解档
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    return self;
}

#pragma mark - 给对象增加方法

// 当一个类调用未实现的方法时，会调用这个方法处理
// 如果类有N个静态方法，则这个方法会被调用N次，sel为遍历所有方法的某一个
+ (BOOL)resolveClassMethod:(SEL)sel {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    if (sel == @selector(privilegeList)) {
#pragma clang diagnostic pop
        // 类方法不能动态添加
        return NO;
    }
    return [super resolveClassMethod:sel];
}

// 当一个对象调用未实现的方法时，会调用这个方法处理
// 如果对象所属类有N个实例方法，则这个方法会被调用N次，sel为遍历所有方法的某一个
+ (BOOL)resolveInstanceMethod:(SEL)sel {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    if (sel == @selector(eat)) {
        #pragma clang diagnostic pop
        /**
         给类添加实例方法

         @param self 要添加的是哪个类
         @param @selector(eat) 方法指针
         @param eat 方法的实现
         @param "v@:" 方法的类型（返回值+参数），v表示返回值为void、@表示对象、:表示SEL，每个方法一定要有Class和SEL这两个参数
         @return 是否添加成功
         */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        class_addMethod(self, @selector(eat), (IMP)eat, "v@:");
#pragma clang diagnostic pop
    }
    return [super resolveInstanceMethod:sel];
}

#pragma mark - 字典转模型

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    ZCPLog(@"捕获到ZCPUser中没有的属性：%@", key);
}

#pragma mark - getter / setter

- (NSNumber *)level {
    return _level;
}
- (void)setLevel:(NSNumber *)level {
    _level = [level copy];
}

#pragma mark - override

- (NSString *)description {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    // 可以拿到@property定义的属性，但是拿不到成员变量
    unsigned int propertyCount = 0;
    objc_property_t *propertys = class_copyPropertyList([ZCPUser class], &propertyCount);
    for (int i = 0; i < propertyCount; i++) {
        objc_property_t property = propertys[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        id value = [self valueForKey:key];
        if (value == nil) {
            value = [NSNull null];
        }
        [dict setValue:value forKey:key];
    }
    
    // 可以拿到类中定义的成员变量和成员属性，但是拿不到分类中通过runtime增加的成员属性
    unsigned int ivarCount = 0;
    Ivar *ivars = class_copyIvarList([ZCPUser class], &ivarCount);
    for (int i = 0; i < ivarCount; i++) {
        // 取出成员变量
        Ivar ivar = ivars[i];
        // 获取成员变量名
        const char *name = ivar_getName(ivar);
        // 归档
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        if (value == nil) {
            value = [NSNull null];
        }
        [dict setValue:value forKey:key];
    }
    
    __block NSString *desc = @"";
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        desc = [desc stringByAppendingString:[NSString stringWithFormat:@"%@: %@, ", key, obj]];
    }];
    
    return desc;
}

@end
