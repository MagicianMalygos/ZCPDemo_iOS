//
//  UIViewController+AOP.m
//  ZCPKit
//
//  Created by 朱超鹏 on 2017/8/10.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "UIViewController+AOP.h"
#import <Aspects.h>

#import "UIViewController+Property.h"
#import "UIViewController+AOPMethod.h"

@implementation UIViewController (AOP)

+ (void)load {
    return;
    NSError *error;
    [UIViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        UIViewController *vc = aspectInfo.instance;
        [vc aop_viewDidLoad];
    } error:&error];
    if (error) NSLog(@"%@", error);
    
    [UIViewController aspect_hookSelector:@selector(viewDidDisappear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        UIViewController *vc = aspectInfo.instance;
        [vc.view endEditing:YES];
    } error:&error];
    if (error) NSLog(@"%@", error);
    
    [UIViewController aspect_hookSelector:@selector(presentViewController:animated:completion:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
        UIViewController *vc = aspectInfo.instance;
        NSArray *arguments = aspectInfo.arguments;
        [vc aop_presentViewController:arguments[0] animated:[arguments[1] boolValue] completion:arguments[2]];
    } error:nil];
    if (error) NSLog(@"%@", error);
    
    [UIViewController aspect_hookSelector:@selector(dismissViewControllerAnimated:completion:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
        UIViewController *vc = aspectInfo.instance;
        NSArray *arguments = aspectInfo.arguments;
        [vc dismissViewControllerAnimated:[arguments[0] boolValue] completion:arguments[1]];
    } error:nil];
    if (error) NSLog(@"%@", error);
}

#pragma mark - private

- (void)aop_viewDidLoad {
    self.view.backgroundColor         = [UIColor whiteColor];
    self.needsTapToDismissKeyboard    = @YES;
    if ([self isHideLeftBarButton] == NO) {
        [self setBackBarButton];
    }
    [self registerKeyboardNotification];
}

- (void)aop_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    self.latterViewController                       = viewControllerToPresent;
    viewControllerToPresent.formerViewController    = self;
    viewControllerToPresent.viewJumpModel           = ZCPViewModalJumpMode;
}
- (void)aop_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    self.formerViewController.latterViewController  = nil;
}

@end
