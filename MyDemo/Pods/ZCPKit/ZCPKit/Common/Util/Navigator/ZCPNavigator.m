//
//  ZCPNavigator.m
//  Apartment
//
//  Created by apple on 15/12/28.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import "ZCPNavigator.h"
#import "ZCPControllerFactory.h"
#import "ZCPVCDataModel.h"

// ----------------------------------------------------------------------
#pragma mark - 自定义导航器
// ----------------------------------------------------------------------
@implementation ZCPNavigator

@synthesize rootViewController  = _rootViewController;
@synthesize topViewController   = _topViewController;

IMP_SINGLETON(ZCPNavigator)

- (void)setupRootViewController:(UIViewController *)rootViewController {
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)rootViewController;
        _rootViewController         = nav;
        _topViewController          = nav.topViewController;
    } else {
        _rootViewController         = rootViewController;
        _topViewController          = nil;
    }
}

- (void)gotoViewWithIdentifier:(NSString *)identifier
                  queryForInit:(NSDictionary *)initParams
            propertyDictionary:(NSDictionary *)propertyDictionary {
    if (identifier) {
        ZCPVCDataModel * viewDataModel      = [[ZCPControllerFactory sharedInstance] generateVCModelWithIdentifier:identifier];
        viewDataModel.paramsForInitMethod   = [NSMutableDictionary dictionaryWithDictionary:initParams];
        viewDataModel.propertyDictionary    = propertyDictionary;
        [self pushViewControllerWithViewDataModel:viewDataModel animated:YES];
    }
}

- (void)gotoViewWithIdentifier:(NSString *)identifier
                  queryForInit:(NSDictionary *)initParams
            propertyDictionary:(NSDictionary *)propertyDictionary
                    retrospect:(BOOL)retrospect
                      animated:(BOOL)animated {
    if (identifier) {
        ZCPVCDataModel * viewDataModel      = [[ZCPControllerFactory sharedInstance] generateVCModelWithIdentifier:identifier];
        viewDataModel.paramsForInitMethod   = [NSMutableDictionary dictionaryWithDictionary:initParams];
        viewDataModel.propertyDictionary    = propertyDictionary;
        [self pushViewControllerWithViewDataModel:viewDataModel retrospect:retrospect animated:animated];
    }
}

@end
