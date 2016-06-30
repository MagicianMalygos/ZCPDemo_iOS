//
//  MyNavigator.m
//  JumpToVC
//
//  Created by apple on 15/12/4.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MyNavigator.h"
#import "MyViewDataModel.h"

@implementation MyNavigator

IMP_SINGLETON
//+ (instancetype)sharedInstance {
//    static id sharedInstance = nil;
//    static dispatch_once_t onceToken = 0;
//    dispatch_once(&onceToken, ^{
//        sharedInstance = [[self alloc] init];
//    });
//    return sharedInstance;
//}

/**
 *  跳转方法
 *
 *  @param identifier 视图标识
 */
- (void)gotoViewWithIdentifier:(NSString *)identifier paramDictForInit:(NSDictionary *)paramDictForInit {
    // 通过identifier获取viewDataModel
    MyViewDataModel *viewDataModel = [self viewDataModelForIdentifier:identifier];
    viewDataModel.paramDictForInit = [NSMutableDictionary dictionaryWithDictionary:paramDictForInit];
    // 通过viewDataModel参数进行跳转
    [self pushViewControllerWithViewDataModel:viewDataModel animated:YES];
}

@end









