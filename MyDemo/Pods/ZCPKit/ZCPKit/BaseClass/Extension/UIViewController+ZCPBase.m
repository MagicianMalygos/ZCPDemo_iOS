//
//  UIViewController+ZCPBase.m
//  ZCPKit
//
//  Created by zcp on 2019/1/7.
//  Copyright © 2019 zcp. All rights reserved.
//

#import "UIViewController+ZCPBase.h"
#import "Aspects.h"
#import <objc/runtime.h>
#import "ZCPGlobal.h"

// ----------------------------------------------------------------------
#pragma mark - UIViewController基础扩展类
// ----------------------------------------------------------------------
@interface _UIViewController_ZCPBaseExtension <Base> : ZCPExtension<Base> <__ZCPViewControllerBaseProtocol0>

@end

@implementation _UIViewController_ZCPBaseExtension

@synthesize tap = _tap;
@synthesize needsTapToDismissKeyboard = _needsTapToDismissKeyboard;

- (UITapGestureRecognizer *)tap {
    if (_tap == nil) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfViewTapped:)];
        _tap.cancelsTouchesInView = YES;
    }
    return _tap;
}

@end


// ----------------------------------------------------------------------
#pragma mark - UIViewController基类扩展
// ----------------------------------------------------------------------
@interface UIViewController ()

ZCPEXTENSION_PROPERTY(Base, _UIViewController_ZCPBaseExtension, UIViewController *)

@end

@implementation UIViewController (ZCPBase)

// ----------------------------------------------------------------------
#pragma mark - swizzing
// ----------------------------------------------------------------------

+ (void)load {
    NSError * __strong error = nil;
    
    [UIViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        UIViewController *vc    = aspectInfo.instance;
        [vc zcp_viewDidLoad];
    } error:&error];

    if (error) NSAssert(YES, error.localizedDescription);

    [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        UIViewController *vc    = aspectInfo.instance;
        NSArray *arguments      = aspectInfo.arguments;
        [vc zcp_viewWillAppear:[arguments[0] boolValue]];
    } error:&error];

    if (error) NSAssert(YES, error.localizedDescription);
}

- (void)zcp_viewDidLoad {
    SELF_CONFORMS_TO_PROTOCOL(@protocol(ZCPViewControllerBaseProtocol), ^() {
        self.view.backgroundColor = [UIColor whiteColor];
        // 键盘点击隐藏事件
        self.needsTapToDismissKeyboard = @YES;
        if ([self isHideLeftBarButton] == NO) {
            [self setBackBarButton];
        }
        // 添加键盘响应事件
        [self registerKeyboardNotification];
    });
}

- (void)zcp_viewWillAppear:(BOOL)animated {
    SELF_CONFORMS_TO_PROTOCOL(@protocol(ZCPViewControllerBaseProtocol), ^() {
        [self.view endEditing:YES];
    });
}

// ----------------------------------------------------------------------
#pragma mark - ZCPViewControllerBaseProtocol
// ----------------------------------------------------------------------

ZCPEXTENSION_GETSET(Base, UITapGestureRecognizer *, tap, setTap)
ZCPEXTENSION_GETSET(Base, NSNumber *, needsTapToDismissKeyboard, setNeedsTapToDismissKeyboard)

#pragma mark <keyboard>

- (void)registerKeyboardNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
}

- (void)breakdown {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
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

#pragma mark <navigation bar>

- (BOOL)isHideLeftBarButton {
    return NO;
}

- (void)initNavigationBar {
}

//返回上级视图
- (void)backTo {
    if ([self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if([self.tabBarController.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]){
        [self.tabBarController.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)setBackBarButton {
}

#pragma mark - getters and setters

- (_UIViewController_ZCPBaseExtension<UIViewController *> *)zcpBaseExtension {
    _UIViewController_ZCPBaseExtension *extension = objc_getAssociatedObject(self, @selector(zcpBaseExtension));
    if (!extension) {
        extension = [[_UIViewController_ZCPBaseExtension alloc] initWithBase:self];
    }
    return extension;
}

- (void)setZcpBaseExtension:(_UIViewController_ZCPBaseExtension<UIViewController *> *)zcpBaseExtension {
    objc_setAssociatedObject(self, @selector(zcpBaseExtension), zcpBaseExtension, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
