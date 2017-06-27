//
//  MapDemoHomeViewController.m
//  Demo
//
//  Created by 朱超鹏 on 2017/6/21.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "MapDemoHomeViewController.h"

@implementation MapDemoHomeViewController

@synthesize infoArr = _infoArr;

- (NSMutableArray *)infoArr {
    if (!_infoArr) {
        _infoArr = @[@{@"title": @"定位", @"class": @"LocationViewController"},
                     @{@"title": @"地图", @"class": @"MapViewController"}].mutableCopy;
    }
    return _infoArr;
}

@end
