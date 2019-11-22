//
//  GestureRecognizerFactory.h
//  Demo
//
//  Created by zhuchaopeng on 2019/9/12.
//  Copyright © 2019 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 手势类型
typedef NS_ENUM(NSInteger, GestureType) {
    GestureTypeTap = 0,
    GestureTypeLongPress,
    GestureTypePan,
    GestureTypeSwipe,
    GestureTypePinch,
    GestureTypeRotation
};

NS_ASSUME_NONNULL_BEGIN

@interface GestureRecognizerFactory : NSObject

+ (UIGestureRecognizer *)createGestureRecognizerWithType:(GestureType)gestureType;

@end

NS_ASSUME_NONNULL_END
