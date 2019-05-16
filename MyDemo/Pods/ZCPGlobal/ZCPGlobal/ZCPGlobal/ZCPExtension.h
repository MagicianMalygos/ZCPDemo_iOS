//
//  ZCPExtension.h
//  ZCPKit
//
//  Created by zcp on 2019/1/14.
//  Copyright © 2019 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 属性扩展宏
#define ZCPEXTENSION_PROPERTY(__propertyName, __cls, __baseType) \
@property (nonatomic, strong) __cls<__baseType> *zcp ## __propertyName ## Extension;

// 属性get set方法宏
#define ZCPEXTENSION_GETSET(__extensionName, __propertyType, __getter, __setter) \
- (__propertyType)__getter { \
    return self.zcp ## __extensionName ## Extension.__getter; \
} \
- (void)__setter:(__propertyType)__getter {\
    [self.zcp ## __extensionName ## Extension __setter:__getter];\
}


/**
 zcp扩展类
 */
@interface ZCPExtension<__covariant Base> : NSObject

/// 需要被扩展的基类
@property (nonatomic, weak) Base base;
/**
 实例化方法
 */
- (instancetype)initWithBase:(Base)base;

@end

NS_ASSUME_NONNULL_END
