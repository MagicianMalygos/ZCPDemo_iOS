//
//  UIViewController+Property.m
//  ZCPKit
//
//  Created by 朱超鹏 on 2017/8/10.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "UIViewController+Property.h"
#import "UIViewController+AOPMethod.h"

@implementation UIViewController (Property)

static NSString *kTap                       = @"kTap";
static NSString *kNeedsTapToDismissKeyboard = @"kNeedsTapToDismissKeyboard";

- (UITapGestureRecognizer *)tap {
    UITapGestureRecognizer *_tap = objc_getAssociatedObject(self, &kTap);
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfViewTapped:)];
        _tap.cancelsTouchesInView = YES;
        [self setTap:_tap];
    }
    return _tap;
}

- (void)setTap:(UITapGestureRecognizer *)tap {
    objc_setAssociatedObject(self, &kTap, tap, OBJC_ASSOCIATION_RETAIN);
}

- (NSNumber *)needsTapToDismissKeyboard {
    return objc_getAssociatedObject(self, &kNeedsTapToDismissKeyboard);
}

- (void)setNeedsTapToDismissKeyboard:(NSNumber *)needsTapToDismissKeyboard {
    objc_setAssociatedObject(self, &kNeedsTapToDismissKeyboard, needsTapToDismissKeyboard, OBJC_ASSOCIATION_RETAIN);
}

@end
