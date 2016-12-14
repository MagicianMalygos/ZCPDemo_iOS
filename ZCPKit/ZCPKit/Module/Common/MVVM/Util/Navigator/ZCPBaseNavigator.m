//
//  ZCPBaseNavigator.m
//  Apartment
//
//  Created by apple on 15/12/28.
//  Copyright © 2015年. All rights reserved.
//

#import "ZCPBaseNavigator.h"
#import "ZCPVCDataModel.h"
#import <objc/runtime.h>

@interface ZCPBaseNavigator ()

// 存放ViewController的相关信息
// key是ViewController对象的identifier，value是ZCPViewDataModel对象
@property (nonatomic, strong) NSMutableDictionary *viewModelDict;

@end

@implementation ZCPBaseNavigator

@synthesize navigationStack     = _navigationStack;
@synthesize rootViewController  = _rootViewController;
@synthesize topViewController   = _topViewController;

// ----------------------------------------------------------------------
#pragma mark - 公有方法
// ----------------------------------------------------------------------

#pragma mark push跳转
- (UIViewController *)pushViewControllerWithViewDataModel:(ZCPVCDataModel *)vcDataModel animated:(BOOL)animated {
    return [self pushViewControllerWithViewDataModel:vcDataModel retrospect:NO animated:animated];
}

#pragma mark push跳转
- (UIViewController *)pushViewControllerWithViewDataModel:(ZCPVCDataModel *)vcDataModel retrospect:(BOOL)retrospect animated:(BOOL)animated {
    UIViewController * controller           = nil;
    
    // 不回溯，直接push一个新的viewcontroller
    if (!retrospect) {
        UIViewController *controller = [[ZCPControllerFactory sharedInstance] generateVCWithVCModel:vcDataModel];
        // 跳转
        if ([controller isKindOfClass:[UIViewController class]]) {
            // 配置controller
            [[ZCPControllerFactory sharedInstance] configController:controller withVCDataModel:vcDataModel shouldCallInitMethod:YES];
            [self pushViewController:controller animated:animated];
        }
        return controller;
    }
    
    if (vcDataModel) {
        // viewcontroller相关参数
        Class       viewClass               = vcDataModel.vcClass;
        
        // 检查是否在导航堆栈中已经存在此类的viewcontroller
        controller                          = [self checkIfVcClassExists:viewClass inStack:self.navigationStack];
        if (controller) {
            // 导航堆栈中存在这个类型的controller,那么跳转到这个controller
            // 配置controller
            [[ZCPControllerFactory sharedInstance] configController:controller withVCDataModel:vcDataModel shouldCallInitMethod:NO];
            
            // 跳转
            [self popToViewController:controller animated:animated];
            
            return controller;
        } else {
            // 导航堆栈中不存在这个类型的controller,那么跳转到新的controller
            [self pushViewControllerWithViewDataModel:vcDataModel animated:animated];
        }
    }
    
    return controller;
}

#pragma mark 视图返回
- (void)viewExit:(NSDictionary *)params {
    if ([self.rootViewController isKindOfClass:[UINavigationController class]]) {
        BOOL animated = YES;
        if (params) {
            NSString * animatedString   = [params objectForKey:APPURL_PARAM_ANIMATED];
            if (animatedString) {
                animated                = [animatedString boolValue];
            }
        }
        [(UINavigationController *)self.rootViewController popViewControllerAnimated:animated];
    }
}
#pragma mark 回退到root
- (void)popToRoot:(NSDictionary *)params {
    if ([self.rootViewController isKindOfClass:[UINavigationController class]]) {
        BOOL animated = YES;
        if (params) {
            NSString * animatedString   = [params objectForKey:APPURL_PARAM_ANIMATED];
            if (animatedString) {
                animated                = [animatedString boolValue];
            }
        }
        [(UINavigationController *)self.rootViewController popToRootViewControllerAnimated:animated];
    }
}

// ----------------------------------------------------------------------
#pragma mark - 安全基础跳转方法
// ----------------------------------------------------------------------
#pragma mark pop vc
- (void)popToViewController:(UIViewController *)controller animated:(BOOL)animated {
    if (self.rootViewController && [self.rootViewController isKindOfClass:[UINavigationController class]]) {
        if (controller && [controller isKindOfClass:[UIViewController class]] && [[(UINavigationController *)self.rootViewController viewControllers] containsObject:controller]) {
            [(UINavigationController *)self.rootViewController popToViewController:controller animated:animated];
        }
    }
}
#pragma mark - push vc
- (void)pushViewController:(UIViewController *)controller animated:(BOOL)animated {
    if (self.rootViewController && [self.rootViewController isKindOfClass:[UINavigationController class]]) {
        if (controller && [controller isKindOfClass:[UIViewController class]]) {
            [(UINavigationController *)self.rootViewController pushViewController:controller animated:animated];
        }
    }
}

// ----------------------------------------------------------------------
#pragma mark - 私有方法
// ----------------------------------------------------------------------

#pragma mark 控制器栈
- (NSArray *)navigationStack {
    NSArray * stack     = nil;
    if (self.rootViewController && [self.rootViewController isKindOfClass:[UINavigationController class]]) {
        stack           = [(UINavigationController *)self.rootViewController viewControllers];
    }
    _navigationStack    = stack;
    return stack;
}

#pragma mark 检查控制器是否在控制器栈中
- (id)checkIfVcClassExists:(Class)vcClass inStack:(NSArray *)stack{
    id controller           = nil;
    
    if (stack && vcClass) {
        for (int i = 0; i < stack.count; i++) {
            id object       = [stack objectAtIndex:i];
            
            if ([object isKindOfClass:vcClass]) {
                controller   = object;
            }
        }
    }
    return controller;
}

@end


// ----------------------------------------------------------------------
#pragma mark - UIViewController导航分类
// ----------------------------------------------------------------------
@implementation UIViewController (ZCPNavigator)

@dynamic formerViewController, latterViewController, viewJumpModel;

static NSString *formerViewControllerKey    = @"formerViewControllerKey";
static NSString *latterViewControllerKey    = @"latterViewControllerKey";
static NSString *viewJumpModelKey           = @"viewJumpModelKey";

- (UIViewController *)formerViewController {
    return objc_getAssociatedObject(self, &formerViewControllerKey);
}
- (UIViewController *)latterViewController {
    return objc_getAssociatedObject(self, &latterViewControllerKey);
}
- (ZCPViewJumpMode)viewJumpModel {
    return [objc_getAssociatedObject(self, &viewJumpModelKey) integerValue];
}

- (void)setFormerViewController:(UIViewController *)formerViewController {
    objc_setAssociatedObject(self, &formerViewControllerKey, formerViewController, OBJC_ASSOCIATION_ASSIGN);
}
- (void)setLatterViewController:(UIViewController *)latterViewController {
    objc_setAssociatedObject(self, &latterViewControllerKey, latterViewController, OBJC_ASSOCIATION_ASSIGN);
}
- (void)setViewJumpModel:(ZCPViewJumpMode)viewJumpModel {
    objc_setAssociatedObject(self, &viewJumpModelKey, [NSNumber numberWithInteger:viewJumpModel], OBJC_ASSOCIATION_ASSIGN);
}

@end
