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

static id<AspectToken> aop_willMoveToSuperview;
static BOOL isOpenExplodeFunction;

// property key
static NSString *explodeHelperKey   = @"explodeHelper";
static NSString *explodeDelegateKey = @"explodeDelegateKey";

@implementation UIView (Explode)

#pragma mark - setup

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
    if (self.explodeHelper.explodeState == UIViewExplodeStateExploding &&
        [newSuperview isKindOfClass:[NSNull class]]) {
        [self recoverUnexplodedState];
    }
}

#pragma mark - function

- (void)explode {
    if (isOpenExplodeFunction) {
        [self.explodeHelper explode];
    }
}

- (void)recoverUnexplodedState {
    if (isOpenExplodeFunction) {
        [self.explodeHelper recover];
    }
}

#pragma mark - getters & setters

- (UIViewExplodeHelper *)explodeHelper {
    UIViewExplodeHelper *explodeHelper = objc_getAssociatedObject(self, &explodeHelperKey);
    if (!explodeHelper) {
        explodeHelper               = [UIViewExplodeHelper new];
        explodeHelper.view          = self;
        explodeHelper.explodeEffect = UIViewExplodeEffectShockWave;
        [self setExplodeHelper:explodeHelper];
    }
    return explodeHelper;
}

- (void)setExplodeHelper:(UIViewExplodeHelper *)explodeHelper {
    objc_setAssociatedObject(self, &explodeHelperKey, explodeHelper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<UIViewExplodeDelegate>)explodeDelegate {
    id<UIViewExplodeDelegate> explodeDelegate = objc_getAssociatedObject(self, &explodeDelegateKey);
    return explodeDelegate;
}

- (void)setExplodeDelegate:(id<UIViewExplodeDelegate>)explodeDelegate {
    objc_setAssociatedObject(self, &explodeDelegateKey, explodeDelegate, OBJC_ASSOCIATION_ASSIGN);
}

@end
