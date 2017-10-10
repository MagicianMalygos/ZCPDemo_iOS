//
//  ZCPControlingCenter.m
//  Apartment
//
//  Created by apple on 15/12/28.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import "ZCPControllerFactory.h"
#import "ZCPTabBarController.h"
#import "ZCPNavigationController.h"
#import "ZCPVCDataModel.h"
#import "ZCPViewMap.h"
#import "ZCPBaseNavigator.h"

static NSString *viewMapFileName = @"viewMap";

@interface ZCPControllerFactory ()

@property (nonatomic, strong) NSMutableDictionary *viewModelDict;

@end

@implementation ZCPControllerFactory

IMP_SINGLETON(ZCPControllerFactory)

// ----------------------------------------------------------------------
#pragma mark - init
// ----------------------------------------------------------------------

+ (void)setViewMap:(NSString *)viewMap {
    viewMapFileName = viewMap;
}

- (instancetype)init {
    if (self = [super init]) {
        [self readViewControllerMap];
    }
    return self;
}

// ----------------------------------------------------------------------
#pragma mark - 生成控制器方法
// ----------------------------------------------------------------------

#pragma mark 通过控制器标识 生成 控制器模型
- (nullable ZCPVCDataModel *)generateVCModelWithIdentifier:(nonnull NSString *)identifier {
    if (!identifier) {
        return nil;
    }
    ZCPVCDataModel *vcDataModel = [self.viewModelDict objectForKey:identifier];
    return vcDataModel;
}
#pragma mark 通过控制器模型 生成 控制器对象
- (nullable UIViewController *)generateVCWithVCModel:(nonnull ZCPVCDataModel *)vcDataModel {
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
#pragma mark 通过控制器标识 生成 控制器对象
- (nullable UIViewController *)generateVCWithIdentifier:(nonnull NSString *)identifier {
    ZCPVCDataModel      *vcDataModel    = [self generateVCModelWithIdentifier:identifier];
    UIViewController    *vc             = [self generateVCWithVCModel:vcDataModel];
    return vc;
}

// ----------------------------------------------------------------------
#pragma mark - 控制器配置方法
// ----------------------------------------------------------------------

- (void)configController:(UIViewController *)controller withVCDataModel:(ZCPVCDataModel *)vcDataModel shouldCallInitMethod:(BOOL)shouldCallInitMethod {
    if (controller && vcDataModel) {
        // 获取相关参数
        Class           viewClass           = vcDataModel.vcClass;
        SEL             initMethod          = [vcDataModel.vcInitMethod pointerValue];
        NSDictionary    *paramsForInit      = vcDataModel.paramsForInitMethod;
        NSDictionary    *propertyDict       = vcDataModel.propertyDictionary;
        
        if (viewClass && initMethod) {
            // 初始化方法
            if ([controller respondsToSelector:initMethod] && shouldCallInitMethod) {
                if ([controller respondsToSelector:initMethod]) {
                    SuppressPerformSelectorLeakWarning(
                                                       [controller performSelector:initMethod withObject:paramsForInit];
                                                       );
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
        }
    }
}

// ----------------------------------------------------------------------
#pragma mark - 私有方法
// ----------------------------------------------------------------------

#pragma mark 从viewmap中读取控制器信息
-  (void)readViewControllerMap {
    
    NSString *viewMapPath   = [[NSBundle mainBundle] pathForResource:viewMapFileName ofType:@"plist"];
    NSArray *viewMaps       = [NSArray arrayWithContentsOfFile:viewMapPath];
    
    if (viewMapPath && viewMaps.count) {
        for (NSDictionary *viewMap in viewMaps) {
            NSString *className                 = [viewMap objectForKey:@"className"];
            NSString *identifier                = [viewMap objectForKey:@"identifier"];
            
            // 生成identifier:viewDataModel键值对，并加入视图模型字典
            if (className && className.length && identifier && identifier.length) {
                Class vcClass                   = NSClassFromString(className);
                SEL initMethod                  = @selector(initWithParams:);
                
                // 创建ViewController 配置对象
                ZCPVCDataModel *viewDataModel   = [[ZCPVCDataModel alloc] init];
                viewDataModel.vcClass           = vcClass;
                viewDataModel.vcInitMethod      = [NSValue valueWithPointer:initMethod];
                
                [self.viewModelDict setObject:viewDataModel forKey:identifier];
            }
        }
    }
}

// ----------------------------------------------------------------------
#pragma mark - 自定义生成控制器栈方法
// ----------------------------------------------------------------------

#pragma mark 生成 Nav - Tab - VCs 控制器栈
- (nonnull UINavigationController *)generate_Nav_Tab_VCs_Stack {
    
    /*
     iOS 7 设置UIImage的渲染模式：UIImageRenderingMode
     UIImageRenderingModeAutomatic           // 根据图片的使用环境和所处的绘图上下文自动调整渲染模式。
     UIImageRenderingModeAlwaysOriginal      // 始终绘制图片原始状态，不使用Tint Color。
     UIImageRenderingModeAlwaysTemplate      // 始终根据Tint Color绘制图片，忽略图片的颜色信息
     */
    
    NSArray *vcIdentifiers = @[APPURL_VIEW_IDENTIFIER_VIEW,
                               APPURL_VIEW_IDENTIFIER_TABLEVIEW,
                               APPURL_VIEW_IDENTIFIER_WEBVIEW];
    NSArray *titles = @[@"view", @"tableview", @"webview"];
    NSArray *images = @[];
    NSArray *selectedImages = @[];
    
    /**
     *  此处会有一个执行的先后顺序问题
     *  之前的tabBarController方法中会设置TabBarController的各tab
     *  然后才初始化NavigationController
     *  问题：在viewDidLoad方法中获取到的NavigationController是空
     */
    
    // 初始化Tab
    ZCPTabBarController *tabbarController = [[ZCPTabBarController alloc] initWithVCIdentifier:vcIdentifiers tabBarItemTitles:titles normalImages:images selectedImages:selectedImages];
    
    // 初始化Nav
    // ps：initWithRootViewController方法会调用pushViewController方法
    ZCPNavigationController *navigationController = [[ZCPNavigationController alloc] initWithRootViewController:tabbarController];
    // 设置navigation的颜色与样式
    // 取消半透明效果，解决界面跳转的时候能看到导航栏的颜色发生变化
    navigationController.navigationBar.translucent = NO;
    
    // 设置状态栏样式
    if (iOS9Upper) {
        [navigationController preferredStatusBarStyle];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
#pragma clang diagnostic pop
    }
    
    // 组成栈
    return navigationController;
}

// ----------------------------------------------------------------------
#pragma mark - getter / setter
// ----------------------------------------------------------------------
- (NSMutableDictionary *)viewModelDict {
    if (!_viewModelDict) {
        _viewModelDict = [NSMutableDictionary dictionary];
    }
    return _viewModelDict;
}

@end

