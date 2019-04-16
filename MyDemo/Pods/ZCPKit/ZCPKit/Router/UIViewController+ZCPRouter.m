//
//  UIViewController+ZCPRouter.m
//  ZCPKit
//
//  Created by zcp on 2019/1/7.
//  Copyright © 2019 zcp. All rights reserved.
//

#import "UIViewController+ZCPRouter.h"
#import "Aspects.h"
#import <objc/runtime.h>
#import "ZCPGlobal.h"

// ----------------------------------------------------------------------
#pragma mark - UIViewController路由属性扩展类
// ----------------------------------------------------------------------
@interface _UIViewController_ZCPRouterExtension<Base> : ZCPExtension<Base> <__ZCPNavigatorProtocol0>

@end

@implementation _UIViewController_ZCPRouterExtension

@synthesize formerViewController = _formerViewController;
@synthesize latterViewController = _latterViewController;

@end


// ----------------------------------------------------------------------
#pragma mark - UIViewController路由扩展
// ----------------------------------------------------------------------
@interface UIViewController ()

/// 路由扩展
ZCPEXTENSION_PROPERTY(Router, _UIViewController_ZCPRouterExtension, UIViewController *)

@end

@implementation UIViewController (ZCPRouter)

// ----------------------------------------------------------------------
#pragma mark - ZCPNavigatorProtocol
// ----------------------------------------------------------------------

ZCPEXTENSION_GETSET(Router, UIViewController <ZCPNavigatorProtocol>*, formerViewController, setFormerViewController)
ZCPEXTENSION_GETSET(Router, UIViewController <ZCPNavigatorProtocol>*, latterViewController, setLatterViewController)

- (instancetype)initWithQuery:(NSDictionary *)query {
    return [self init];
}

// ----------------------------------------------------------------------
#pragma mark - swizzing
// ----------------------------------------------------------------------

+ (void)load {
    NSError * __strong error = nil;
    
    [UIViewController aspect_hookSelector:@selector(presentViewController:animated:completion:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
        UIViewController *vc    = aspectInfo.instance;
        NSArray *arguments      = aspectInfo.arguments;
        [vc zcp_presentViewController:arguments[0] animated:[arguments[1] boolValue] completion:[arguments[2] copy]];
    } error:&error];
    
    if (error) NSAssert(YES, error.localizedDescription);
    
    [UIViewController aspect_hookSelector:@selector(dismissViewControllerAnimated:completion:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
        UIViewController *vc    = aspectInfo.instance;
        NSArray *arguments      = aspectInfo.arguments;
        [vc zcp_dismissViewControllerAnimated:[arguments[0] boolValue] completion:[arguments[1] copy]];
    } error:&error];
    
    if (error) NSAssert(YES, error.localizedDescription);
}

- (void)zcp_presentViewController:(UIViewController<ZCPNavigatorProtocol> *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    SELF_CONFORMS_TO_PROTOCOL(@protocol(ZCPNavigatorProtocol), ^() {
        self.latterViewController = viewControllerToPresent;
        if ([viewControllerToPresent conformsToProtocol:@protocol(ZCPNavigatorProtocol)]) {
            viewControllerToPresent.formerViewController = (UIViewController <ZCPNavigatorProtocol>*)self;
        }
    });
}

- (void)zcp_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    SELF_CONFORMS_TO_PROTOCOL(@protocol(ZCPNavigatorProtocol), ^() {
        self.formerViewController.latterViewController  = nil;
    });
}

// ----------------------------------------------------------------------
#pragma mark - getters and setters
// ----------------------------------------------------------------------

- (_UIViewController_ZCPRouterExtension<UIViewController *> *)zcpRouterExtension {
    _UIViewController_ZCPRouterExtension *extension = objc_getAssociatedObject(self, @selector(zcpRouterExtension));
    if (!extension) {
        extension = [[_UIViewController_ZCPRouterExtension alloc] initWithBase:self];
    }
    return extension;
}

- (void)setZcpRouterExtension:(_UIViewController_ZCPRouterExtension<UIViewController *> *)zcpRouterExtension {
    objc_setAssociatedObject(self, @selector(zcpRouterExtension), zcpRouterExtension, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
