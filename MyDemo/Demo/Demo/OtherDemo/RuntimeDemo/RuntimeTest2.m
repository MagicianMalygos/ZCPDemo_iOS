//
//  RuntimeTest2.m
//  RuntimeDemo
//
//  Created by apple on 16/2/26.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "RuntimeTest2.h"

/*
    假定这样一个场景，我们从服务端两个不同的接口获取相同的字典数据，但这两个接口是由两个人写的，相同的信息使用了不同的字段表示。
    我们在接收到数据时，可将这些数据保存在相同的对象中。
    接口A、B返回的字典数据：
    @{@"name1": "张三", @"status1": @"start"}
    @{@"name2": "张三", @"status2": @"end"}
 */
@interface MyObject : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *status;
@end

static NSMutableDictionary *map = nil;

@implementation MyObject
+ (void)load {
    map = [NSMutableDictionary dictionary];
    map[@"name1"]       =   @"name";
    map[@"status1"]     =   @"status";
    map[@"name2"]       =   @"name";
    map[@"status2"]     =   @"status";
}
- (void)setDataWithDict:(NSDictionary *)dict {
    if (map == nil) {
        [MyObject load];
    }
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *propertyKey = [map valueForKey:key];
        if (propertyKey) {
//            objc_property_t property = class_getProperty([self class], [propertyKey UTF8String]);
//            NSString *attributeString = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
            // ...
//            NSLog(@"attri:%@", attributeString);
            
            [self setValue:obj forKey:propertyKey];
        }
    }];
}
@end



@implementation RuntimeTest2

// 类型编码
- (void)typeEncoding {
    // 当给定一个类型时，@encode返回这个类型的字符串编码。任何可以作为sizeof()操作参数的类型都可以用于@encode()
    int i = 1;
    float f = 1.0f;
    double d = 1.0;
    char *c = "asdf";
    float ff[] = {1.0f, 2.0f, 3.0f};
    NSString *str = @"abcedf";
    NSLog(@"%s %s %s %s %s %s", @encode(typeof(i))
                              , @encode(typeof(f))
                              , @encode(typeof(d))
                              , @encode(typeof(c))
                              , @encode(typeof(ff))
                              , @encode(typeof(str)));
}
// 关联对象，这个对象通过给定的key连接到类的一个实例上
- (void)associatedObject {
    /*
        OBJC_ASSOCIATION_ASSIGN
        OBJC_ASSOCIATION_RETAIN_NONATOMIC
        OBJC_ASSOCIATION_COPY_NONATOMIC
        OBJC_ASSOCIATION_RETAIN
        OBJC_ASSOCIATION_COPY
     */
    
    // 将anObject对象使用myKey连接到self上
    static char myKey;
    id anObject;
    objc_setAssociatedObject(self, &myKey, anObject, OBJC_ASSOCIATION_RETAIN);
}

static char kDTActionHandlerTapGestureKey;
static char kDTActionHandlerTapBlockKey;
// 设置手势响应事件Block
- (void)setTapActionWithBlock:(void (^)(void))block {
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerTapGestureKey);
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kDTActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kDTActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
    NSLog(@"Tap be ready");
}
// 响应方法
- (void)__handleActionForTapGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        void(^action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerTapBlockKey);
        if (action) {
            action();
        }
    }
}

// test
- (void)propertyOperation {
    MyObject *myObject = [MyObject new];
    
    [myObject setDataWithDict:@{@"name1": @"张三", @"status1": @"start"}];
    NSLog(@"name: %@ status: %@", myObject.name, myObject.status);
    [myObject setDataWithDict:@{@"name2": @"张三", @"status2": @"end"}];
    NSLog(@"name: %@ status: %@", myObject.name, myObject.status);
}


@end
