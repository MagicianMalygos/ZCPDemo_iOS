//
//  RuntimeTest2.h
//  RuntimeDemo
//
//  Created by apple on 16/2/26.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <objc/runtime.h>

@interface RuntimeTest2 : UIView

// 类型编码
- (void)typeEncoding;

// 关联对象，解决不能在分类中定义成员变量的问题
- (void)associatedObject;
- (void)setTapActionWithBlock:(void (^)())block;

- (void)propertyOperation;


@end

/*
 
 // Ivar: objc_ivar *类型，是一个结构体指针
 typedef struct objc_ivar *Ivar;
 
 // 变量结构体
 struct objc_ivar {
    char *ivar_name                 OBJC2_UNAVAILABLE;  // 变量名
    char *ivar_type                 OBJC2_UNAVAILABLE;  // 变量类型
    int ivar_offset                 OBJC2_UNAVAILABLE;  // 基地址偏移字节
    #ifdef __LP64__
    int space                       OBJC2_UNAVAILABLE;
    #endif
 }
 
 // objc_property_t: objc_property*类型，是一个结构体指针
 typedef struct objc_property *objc_property_t;
 
 // 属性结构体
 typedef struct {
    const char *name;           // 特性名
    const char *value;          // 特性值
 } objc_property_attribute_t;
 
 
 */