//
//  UIViewController+AOPMethod.m
//  ZCPKit
//
//  Created by 朱超鹏 on 2017/8/10.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "UIViewController+AOPMethod.h"
#import "UIViewController+Property.h"

@implementation UIViewController (AOPMethod)

- (instancetype)initWithParams:(NSDictionary *)params {
    if (self = [self init]) {
    }
    return self;
}

- (void)registerKeyboardNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    if (SYSTEM_VERSION >= 5.0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
    }
}

- (void)breakdown {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    if (SYSTEM_VERSION >= 5.0) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
    }
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    if ([self.needsTapToDismissKeyboard boolValue]) {
        [self.view addGestureRecognizer:self.tap];
    }
}

- (void)keyboardDidShow:(NSNotification *)notification {
    
}
- (void)keyboardWillHide:(NSNotification *)notification {
    if (self.tap) {
        [self.view removeGestureRecognizer:self.tap];
    }
}
- (void)keyboardDidHide:(NSNotification *)notification {
}
- (void)keyboardWillChangeFrame:(NSNotification *)notification {
}
- (void)keyboardDidChangeFrame:(NSNotification *)notification {
}

- (void)selfViewTapped:(UITapGestureRecognizer *)tap {
    if (tap.view == self.view) {
        // 让键盘消失
        [self dismissKeyboard];
    }
}

- (BOOL)isHideLeftBarButton {
    return NO;
}
- (void)initNavigationBar {
}
- (void)setBackBarButton {
    
}
- (void)backTo {
}

@end
