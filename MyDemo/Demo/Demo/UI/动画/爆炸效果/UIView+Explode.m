//
//  UIView+Explode.m
//  Demo
//
//  Created by 朱超鹏 on 2018/6/25.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "UIView+Explode.h"
#import "UIViewExplodeHelper.h"
#import <objc/runtime.h>
#import <Aspects.h>

static NSString *helperKey          = @"helper";
static NSString *explodeDelegateKey = @"explodeDelegateKey";

static id<AspectToken> aop_willMoveToSuperview;
static BOOL isOpenExplodeFunction;

@implementation UIView (Explode)

#pragma mark - init

+ (NSError *)openExplodeFunction {
    NSError *error = nil;
    aop_willMoveToSuperview = [self aspect_hookSelector:@selector(willMoveToSuperview:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        UIView *instance    = aspectInfo.instance;
        NSArray *arguments  = aspectInfo.arguments;
        [instance aop_willMoveToSuperview:arguments[0]];
    } error:&error];
    if (!error) {
        isOpenExplodeFunction = YES;
    }
    return error;
}

+ (void)closeExplodeFunction {
    [aop_willMoveToSuperview remove];
    aop_willMoveToSuperview = nil;
    isOpenExplodeFunction = NO;
}

- (void)aop_willMoveToSuperview:(UIView *)newSuperview {
    if (self.helper.explodeState == UIViewExplodeStateExploding &&
        [newSuperview isKindOfClass:[NSNull class]]) {
        [self recoverUnexplodedState];
    }
}

#pragma mark - public

- (void)explode {
    if (isOpenExplodeFunction) {
        [self.helper explode];
    }
}

- (void)recoverUnexplodedState {
    if (isOpenExplodeFunction) {
        [self.helper recover];
    }
}

#pragma mark - getters & setters

- (UIViewExplodeHelper *)helper {
    UIViewExplodeHelper *helper = objc_getAssociatedObject(self, &helperKey);
    if (!helper) {
        helper = [UIViewExplodeHelper new];
        helper.view = self;
        helper.explodeEffect = UIViewExplodeEffectShockWave;
        [self setHelper:helper];
    }
    return helper;
}

- (void)setHelper:(UIViewExplodeHelper *)helper {
    objc_setAssociatedObject(self, &helperKey, helper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<UIViewExplodeDelegate>)explodeDelegate {
    id<UIViewExplodeDelegate> delegate = objc_getAssociatedObject(self, &explodeDelegateKey);
    return delegate;
}

- (void)setExplodeDelegate:(id<UIViewExplodeDelegate>)explodeDelegate {
    objc_setAssociatedObject(self, &explodeDelegateKey, explodeDelegate, OBJC_ASSOCIATION_ASSIGN);
}

@end
