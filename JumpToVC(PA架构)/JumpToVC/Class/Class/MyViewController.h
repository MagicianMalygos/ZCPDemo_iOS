//
//  MyViewController.h
//  JumpToVC
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyViewController : UIViewController

#pragma mark - property

// 是否需要在键盘显示之后，点击界面让键盘消失
@property (nonatomic, strong) NSNumber *needsTapToDismissKeyboard;
// tap事件
@property (nonatomic, strong) UITapGestureRecognizer * tap;


#pragma mark - keyboard event
/**
 *  注册键盘通知事件监听
 */
- (void)registerKeyboardNotification;
/**
 *  移除监听
 */
- (void)breakdown;
/**
 *  缩回键盘
 */
- (void)dismissKeyboard;

// 键盘将要显示
- (void)keyboardWillShow:(NSNotification *)notification;
// 键盘已经显示
- (void)keyboardDidShow:(NSNotification *)notification;
// 键盘布局将要改变
- (void)keyboardWillChangeFrame:(NSNotification *)notification;
// 键盘布局已经改变
- (void)keyboardDidChangeFrame:(NSNotification *)notification;
// 键盘将要消失
- (void)keyboardWillHide:(NSNotification *)notification;
// 键盘已经消失
- (void)keyboardDidHide:(NSNotification *)notification;



@end
