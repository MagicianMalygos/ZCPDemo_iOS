//
//  MyViewController.m
//  JumpToVC
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

#pragma mark - synthesize
@synthesize tap = _tap;
@synthesize needsTapToDismissKeyboard = _needsTapToDismissKeyboard;

#pragma mark - 初始化方法
- (instancetype)initWithParams:(NSDictionary *)params {
    if (self = [super init]) {
    }
    return self;
}
- (void) dealloc {
    [self breakdown];  // 移除键盘监听
}

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 默认点击界面使键盘消失
    self.needsTapToDismissKeyboard = @YES;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self becomeFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - keyboard event
/**
 *  注册键盘事件监听
 */
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
/**
 *   移除键盘事件监听
 */
- (void)breakdown {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
}
/**
 *  缩回键盘
 */
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
    if (_tap) {
        [self.view removeGestureRecognizer:self.tap];
    }
}
- (void)keyboardDidHide:(NSNotification *)notification {
}
- (void)keyboardWillChangeFrame:(NSNotification *)notification {
}
- (void)keyboardDidChangeFrame:(NSNotification *)notification {
}

#pragma mark - getter / setter
- (UIGestureRecognizer *)tap {
    if (_tap == nil) {
        self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfViewTapped:)];
    }
    return _tap;
}

#pragma mark - events
- (void)selfViewTapped:(UITapGestureRecognizer *)tap {
    if (tap.view == self.view) {
        [self dismissKeyboard];
    }
}


@end








