//
//  GestureRecognizerFactory.m
//  Demo
//
//  Created by zhuchaopeng on 2019/9/12.
//  Copyright © 2019 zcp. All rights reserved.
//

#import "GestureRecognizerFactory.h"

@implementation GestureRecognizerFactory

+ (UIGestureRecognizer *)createGestureRecognizerWithType:(GestureType)gestureType {
    UIGestureRecognizer *gestureRecognizer = nil;
    
    switch (gestureType) {
        case GestureTypeTap: {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
            tap.numberOfTapsRequired = 0;
            tap.numberOfTouchesRequired = 0;
            
            gestureRecognizer = tap;
        }
            break;
        case GestureTypeLongPress: {
            gestureRecognizer = [[UILongPressGestureRecognizer alloc] init];
        }
            break;
        case GestureTypePan: {
            gestureRecognizer = [[UIPanGestureRecognizer alloc] init];
        }
            break;
        case GestureTypeSwipe: {
            gestureRecognizer = [[UISwipeGestureRecognizer alloc] init];
        }
            break;
        case GestureTypePinch: {
            gestureRecognizer = [[UIPinchGestureRecognizer alloc] init];
        }
            break;
        case GestureTypeRotation: {
            gestureRecognizer = [[UIRotationGestureRecognizer alloc] init];
        }
            break;
        default:
            break;
    }
    return gestureRecognizer;
}

@end
