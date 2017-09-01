//
//  UIViewController+AOPMethod.h
//  ZCPKit
//
//  Created by 朱超鹏 on 2017/8/10.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (AOPMethod) <ZCPNavigatorProtocol>

- (void)registerKeyboardNotification;
- (void)breakdown;
- (void)dismissKeyboard;

- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardDidShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;
- (void)keyboardDidHide:(NSNotification *)notification;
- (void)keyboardWillChangeFrame:(NSNotification *)notification;
- (void)keyboardDidChangeFrame:(NSNotification *)notification;

- (void)selfViewTapped:(UITapGestureRecognizer *)tap;
- (BOOL)isHideLeftBarButton;
- (void)initNavigationBar;
- (void)setBackBarButton;
- (void)backTo;

@end
