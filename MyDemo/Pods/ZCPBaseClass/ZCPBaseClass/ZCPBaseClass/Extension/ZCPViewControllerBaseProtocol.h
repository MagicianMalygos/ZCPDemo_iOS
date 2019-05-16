//
//  ZCPViewControllerBaseProtocol.h
//  ZCPKit
//
//  Created by zcp on 2019/1/7.
//  Copyright © 2019 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol __ZCPViewControllerBaseProtocol0 <NSObject>

@optional
/// 点击手势
@property (nonatomic, strong) UITapGestureRecognizer *tap;
/// 是否需要在键盘显示之后，点击页面让键盘消失
@property (nonatomic, strong) NSNumber *needsTapToDismissKeyboard;

// ----------------------------------------------------------------------
#pragma mark - 键盘事件
// ----------------------------------------------------------------------

/**
 注册键盘通知事件监听
 */
- (void)registerKeyboardNotification;

/**
 移除键盘事件监听
 */
- (void)breakdown;

/**
 缩回键盘
 */
- (void)dismissKeyboard;

/**
 键盘事件监听
 */
- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardDidShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;
- (void)keyboardDidHide:(NSNotification *)notification;
- (void)keyboardWillChangeFrame:(NSNotification *)notification;
- (void)keyboardDidChangeFrame:(NSNotification *)notification;

/**
 点击self.view
 */
- (void)selfViewTapped:(UITapGestureRecognizer *)tap;

// ----------------------------------------------------------------------
#pragma mark - NavigationBar
// ----------------------------------------------------------------------

/**
 重写此方法，返回YES为隐藏
 */
- (BOOL)isHideLeftBarButton;

/**
 清除导航栏方法
 */
- (void)initNavigationBar;

/**
 返回方法
 */
- (void)backTo;

/**
 设置返回按钮
 */
- (void)setBackBarButton;

@end

@protocol ZCPViewControllerBaseProtocol <__ZCPViewControllerBaseProtocol0>

@end

NS_ASSUME_NONNULL_END
