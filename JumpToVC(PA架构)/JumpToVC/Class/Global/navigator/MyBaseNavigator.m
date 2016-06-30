//
//  MyBaseNavigator.m
//  JumpToVC
//
//  Created by apple on 15/12/4.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MyBaseNavigator.h"
#import "MyViewDataModel.h"

@interface MyBaseNavigator ()

// 存放viewController的相关信息
// key是viewController对象的identifier，value是MyViewDataModel对象
@property (nonatomic, strong) NSMutableDictionary *viewModelDict;
@property (nonatomic, strong) UIViewController *rootViewController;

@end

@implementation MyBaseNavigator

#pragma mark - synthesize
@synthesize viewModelDict = _viewModelDict;
@synthesize window = _window;

#pragma mark - 初始化
/**
 *  初始化方法
 *
 *  @return instance
 */
- (instancetype)init {
    if (self = [super init]) {
        [self readViewControllerConfigurations];
    }
    return self;
}
#pragma mark - getter / setter
- (NSMutableDictionary *)viewModelDict {
    if (_viewModelDict == nil) {
        _viewModelDict = [NSMutableDictionary dictionary];
    }
    return _viewModelDict;
}
- (UIWindow *)window {
    if (_window == nil) {
        _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    return _window;
}
- (void)setupRootViewController {
    self.rootViewController = [[MyControlingCenter sharedInstance] generateRootViewController];
    self.window.rootViewController = self.rootViewController;
}


#pragma mark - 私有方法
/**
 *  读取控制器配置信息
 */
- (void)readViewControllerConfigurations {
    NSString *viewMapPath = [[NSBundle mainBundle] pathForResource:@"viewMap" ofType:@"plist"];
    NSArray *viewMaps = [NSArray arrayWithContentsOfFile:viewMapPath];
    
    if (viewMaps && viewMaps.count) {
        for (NSDictionary *viewMap in viewMaps) {
            NSString *className = [viewMap objectForKey:@"className"];
            NSString *identifier = [viewMap objectForKey:@"identifier"];
            
            if (className && className.length && identifier && identifier.length) {
                Class viewControllerClass = NSClassFromString(className);
                // 生成identifier:viewDataModel键值对，并加入视图模型字典
                SEL initMethod = @selector(initWithParams:);
                SEL instanceMethod = @selector(doInitializeWithParams:);
                
                // 创建viewcontroller 配置对象
                MyViewDataModel *viewDataModel = [[MyViewDataModel alloc] init];
                viewDataModel.viewControllerClass = viewControllerClass;
                viewDataModel.viewControllerInitMethod = [NSValue valueWithPointer:initMethod];
                viewDataModel.viewControllerInstanceMethod = [NSValue valueWithPointer:instanceMethod];
                
                [self.viewModelDict setObject:viewDataModel forKey:identifier];
            }
        }
    }
}
/**
 *  配置Object
 *
 *  @param object               （控制器对象）
 *  @param viewDataModel        视图数据模型对象
 *  @param shouldCallInitMethod 是否回调初始化方法
 */
- (void)configObject:(NSObject *)object withViewDataModel:(MyViewDataModel *)viewDataModel shouldCallInitMethod:(BOOL)shouldCallInitMethod {
    if (object && viewDataModel) {
        // 获取相关参数
        Class viewControllerClass = viewDataModel.viewControllerClass;
        SEL initMethod = [viewDataModel.viewControllerInitMethod pointerValue];
        SEL instanceMethod = [viewDataModel.viewControllerInstanceMethod pointerValue];
        NSDictionary * paramDictForInit = viewDataModel.paramDictForInit;
        NSDictionary * paramDictForInstance = viewDataModel.paramDictForInstance;
        
        if (viewControllerClass && initMethod) {
            // 初始化
            if ([object respondsToSelector:initMethod] && shouldCallInitMethod) {
                NSArray * params = nil;
                if (paramDictForInit) {
                    params = @[paramDictForInit];
                }
                [object performSelector:initMethod withObject:params];
            }
            // 实例化方法
            if ([object respondsToSelector:instanceMethod]) {
                NSArray *params = nil;
                if (paramDictForInstance) {
                    params = @[paramDictForInstance];
                }
                [object performSelector:instanceMethod withObject:params];
            }
        }
    }
}


#pragma mark - 公有方法
/**
 *  通过identifier获取视图模型
 *
 *  @param identifier 控制器标识
 *
 *  @return 视图数据模型对象
 */
- (MyViewDataModel *)viewDataModelForIdentifier:(NSString *)identifier {
    MyViewDataModel *viewDataModel = nil;
    viewDataModel = [self.viewModelDict objectForKey:identifier];
    return viewDataModel;
}
/**
 *  根据ViewDataModel获得控制器对象，并进行跳转
 *
 *  @param viewDataModel 视图数据模型对象
 *  @param animated      是否使用动画
 *
 *  @return 控制器对象
 */
- (UIViewController *)pushViewControllerWithViewDataModel:(MyViewDataModel *)viewDataModel animated:(BOOL)animated {
    UIViewController *controller = nil;
    if (viewDataModel) {
        // 获取相关参数
        Class       viewControllerClass     = viewDataModel.viewControllerClass;
        SEL         initMethod              = [viewDataModel.viewControllerInitMethod pointerValue];
        NSObject    *object                 = nil;
        
        // 判断并进行跳转
        if (viewControllerClass && initMethod) {
            object                          = [viewControllerClass alloc];
            // 配置object
            [self configObject:object withViewDataModel:viewDataModel shouldCallInitMethod:YES];
            // 跳转
            if ([object isKindOfClass:[UIViewController class]]) {
                controller = (UIViewController *)object;
                [self pushViewController:controller animated:animated];
                viewDataModel.paramDictForInit = nil;
            }
        }
    }
    return controller;
}

#pragma mark - 基础跳转方法
- (void)pushViewController:(UIViewController *)controller animated:(BOOL)animated {
    if (self.rootViewController && [self.rootViewController isKindOfClass:[UINavigationController class]]) {
        if (controller && [controller isKindOfClass:[UIViewController class]]) {
            [(UINavigationController *)self.rootViewController pushViewController:controller animated:animated];
        }
    }
}


@end