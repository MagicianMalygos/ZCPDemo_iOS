//
//  RuntimeTest1.h
//  RuntimeDemo
//
//  Created by apple on 16/2/25.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <objc/runtime.h>

@interface RuntimeTest1 : NSObject

- (void)ex_registerClassPair;
- (void)classOperation;
- (void)dynamicCreate;
- (void)operationFouction;

@end

/*
 
 // 类结构体
 struct objc_class {
     Class isa  OBJC_ISA_AVAILABILITY;
 
     Class super_class                                        OBJC2_UNAVAILABLE;
     const char *name                                         OBJC2_UNAVAILABLE;
     long version                                             OBJC2_UNAVAILABLE;
     long info                                                OBJC2_UNAVAILABLE;
     long instance_size                                       OBJC2_UNAVAILABLE;
     struct objc_ivar_list *ivars                             OBJC2_UNAVAILABLE;
     struct objc_method_list **methodLists                    OBJC2_UNAVAILABLE;
     struct objc_cache *cache                                 OBJC2_UNAVAILABLE;
     struct objc_protocol_list *protocols                     OBJC2_UNAVAILABLE;
 
 } OBJC2_UNAVAILABLE;
 
 // Class类型用来表示一个类: objc_class *类型，是一个结构体指针
 typedef struct objc_class *Class;
 
 // 表示一个类实例的结构体
 struct objc_object {
    Class isa  OBJC_ISA_AVAILABILITY;
 };
 
 // id: objc_object *类型，是一个结构体指针
 typedef struct objc_object *id;
 
 // 用于缓存调用过的方法
 struct objc_cache {
    // total = mask + 1
    unsigned int mask                                        OBJC2_UNAVAILABLE;
    unsigned int occupied                                    OBJC2_UNAVAILABLE;
    Method buckets[1]                                        OBJC2_UNAVAILABLE;
};

 */
