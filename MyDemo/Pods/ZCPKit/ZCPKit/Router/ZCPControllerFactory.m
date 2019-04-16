//
//  ZCPControlingCenter.m
//  Apartment
//
//  Created by apple on 15/12/28.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import "ZCPControllerFactory.h"
#import "ZCPVCDataModel.h"
#import "ZCPViewMap.h"
#import "ZCPBaseNavigator.h"

@interface ZCPControllerFactory ()

@property (nonatomic, strong) NSMutableDictionary *vcDataModelDict;

@end

@implementation ZCPControllerFactory

@synthesize vcDataModelDict = _vcDataModelDict;

IMP_SINGLETON

// ----------------------------------------------------------------------
#pragma mark - generate
// ----------------------------------------------------------------------

// 通过控制器标识 生成 控制器模型
- (ZCPVCDataModel *)generateVCModelWithIdentifier:(NSString *)identifier {
    if (!identifier) {
        return nil;
    }
    ZCPVCDataModel *vcDataModel = [self.vcDataModelDict objectForKey:identifier];
    return vcDataModel;
}

// 通过控制器模型 生成 控制器对象
- (UIViewController *)generateVCWithVCModel:(ZCPVCDataModel *)vcDataModel {
    if (!vcDataModel) {
        return nil;
    }
    UIViewController    *viewController         = nil;
    Class               vcClass                 = vcDataModel.vcClass;
    NSObject            *vc                     = nil;
    
    if (vcClass && (vc = [vcClass alloc]) && [vc isKindOfClass:[UIViewController class]]) {
        viewController = (UIViewController *)vc;
    }
    return viewController;
}

// 通过控制器标识 生成 控制器对象
- (UIViewController *)generateVCWithIdentifier:(NSString *)identifier {
    ZCPVCDataModel      *vcDataModel    = [self generateVCModelWithIdentifier:identifier];
    UIViewController    *vc             = [self generateVCWithVCModel:vcDataModel];
    return vc;
}

// 根据一组id生成一组vc对象
- (NSArray *)generateVCsWithIdentifiers:(NSArray *)identifiers {
    NSMutableArray *vcs             = [NSMutableArray arrayWithCapacity:5];
    for (int i = 0; i < identifiers.count; i++) {
        if (i > 5) {
            break;
        }
        NSString *vcIdentifier      = [identifiers objectAtIndex:i];
        ZCPVCDataModel *vcDataModel = [[ZCPControllerFactory sharedInstance] generateVCModelWithIdentifier:vcIdentifier];
        UIViewController *vc        = [[ZCPControllerFactory sharedInstance] generateVCWithVCModel:vcDataModel];
        if (vc && [vc isKindOfClass:[UIViewController class]]) {
            [[ZCPControllerFactory sharedInstance] configController:vc withVCDataModel:vcDataModel shouldCallInitMethod:YES];
            [vcs addObject:vc];
        }
    }
    return vcs;
}

// ----------------------------------------------------------------------
#pragma mark - private method
// ----------------------------------------------------------------------

// 根据控制器模型去设置控制器对象
- (void)configController:(UIViewController *)controller withVCDataModel:(ZCPVCDataModel *)vcDataModel shouldCallInitMethod:(BOOL)shouldCallInitMethod {
    if (controller && vcDataModel) {
        // 获取相关参数
        Class           viewClass           = vcDataModel.vcClass;
        SEL             initMethod          = [vcDataModel.vcInitMethod pointerValue];
        SEL             instanceMethod      = [vcDataModel.vcInstanceMethod pointerValue];
        NSDictionary    *queryForInitM      = vcDataModel.queryForInitMethod;
        NSDictionary    *queryForInstanceM  = vcDataModel.queryForInstanceMethod;
        NSDictionary    *propertyDict       = vcDataModel.propertyDictionary;
        
        if (viewClass && initMethod) {
            // 初始化方法
            if ([controller respondsToSelector:initMethod] && shouldCallInitMethod) {
                if ([controller respondsToSelector:initMethod]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                    [controller performSelector:initMethod withObject:queryForInitM];
#pragma clang diagnostic pop
                }
            }
            // 属性设置
            if (propertyDict) {
                for (NSString * key in propertyDict.allKeys) {
                    id value                = [propertyDict objectForKey:key];
                    SEL getMethod           = NSSelectorFromString(key);
                    if ([controller respondsToSelector:getMethod]) {
                        [controller setValue:value forKey:key];
                    }
                }
            }
            // 实例方法
            if (queryForInstanceM && [controller respondsToSelector:instanceMethod]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [controller performSelector:instanceMethod withObject:queryForInstanceM];
#pragma clang diagnostic pop
            }
        }
    }
}

// ----------------------------------------------------------------------
#pragma mark - viewcontroller stack
// ----------------------------------------------------------------------

/**
 生成 Nav - Tab - VCs 控制器栈。
 该方法只是一个参考，项目中可在ZCPControllerFactory分类中生成自定义的控制器栈

 @return 导航控制器
 */
- (UINavigationController *)generate_Nav_Tab_VCs_Stack {
    /*
     iOS 7 设置UIImage的渲染模式：UIImageRenderingMode
     UIImageRenderingModeAutomatic           // 根据图片的使用环境和所处的绘图上下文自动调整渲染模式。
     UIImageRenderingModeAlwaysOriginal      // 始终绘制图片原始状态，不使用Tint Color。
     UIImageRenderingModeAlwaysTemplate      // 始终根据Tint Color绘制图片，忽略图片的颜色信息
     */
    
    NSArray *vcIdentifiers  = @[APPURL_VIEW_IDENTIFIER_TABLEVIEW,
                                APPURL_VIEW_IDENTIFIER_WEBVIEW];
    NSArray *titles         = @[@"tableview", @"webview"];
    NSArray *normalImages   = @[];
    NSArray *selectedImages = @[];
    
    /**
     此处会有一个初始化先后顺序的问题：
     tabbar上的vc，在viewDidLoad方法中获取到的navigationController是nil。
     
     这是由于初始化循序：viewControllers > tabBarController > navigationController
     所以要注意，tabbar上的vc，在使用viewDidLoad方法时要注意这个情况。
     navBarTitle要记得在viewWillAppear:方法中设置
     */
    
    // 初始化Tab
    UITabBarController *tabbarController = [[UITabBarController alloc] init];
    NSArray *viewControllers = [self generateVCsWithIdentifiers:vcIdentifiers];
    for (int i = 0; i < viewControllers.count; i++) {
        UIViewController *vc        = [viewControllers objectAtIndex:i];
        NSString *title             = nil;
        UIImage *normalImage        = nil;
        UIImage *selectedImage      = nil;
        
        if (i < titles.count) {
            title = [titles objectAtIndex:i];
        }
        if (i < normalImages.count) {
            normalImage = [normalImages objectAtIndex:i];
        }
        if (i < selectedImages.count) {
            selectedImage = [normalImages objectAtIndex:i];
        }
        vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:normalImage selectedImage:selectedImage];
        vc.tabBarItem.tag = i;
    }
    [tabbarController setViewControllers:viewControllers];
    
    // 初始化Nav
    // ps：initWithRootViewController方法会调用pushViewController方法
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tabbarController];
    // 设置navigation的颜色与样式
    // 取消半透明效果，解决界面跳转的时候能看到导航栏的颜色发生变化
    navigationController.navigationBar.translucent = NO;
    
    // 设置状态栏样式
    [navigationController preferredStatusBarStyle];
    
    // 返回导航控制器
    return navigationController;
}

#pragma mark - getters and setters

- (void)setVCDataModelDict:(NSMutableDictionary *)vcDataModelDict {
    if (!vcDataModelDict) {
        return;
    }
    _vcDataModelDict = vcDataModelDict;
}

- (NSMutableDictionary *)vcDataModelDict {
    if (!_vcDataModelDict) {
        _vcDataModelDict = [NSMutableDictionary dictionary];
    }
    return _vcDataModelDict;
}

@end

