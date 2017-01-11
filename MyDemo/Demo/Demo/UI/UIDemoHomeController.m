//
//  UIDemoHomeController.m
//  Demo
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "UIDemoHomeController.h"

@implementation UIDemoHomeController

@synthesize infoArr = _infoArr;

- (NSMutableArray *)infoArr {
    if (_infoArr == nil) {
        _infoArr = [NSMutableArray arrayWithObjects:
                    @{@"title": @"SizeToFitDemo", @"class": @"SizeToFitDemoHomeController"},
                    @{@"title": @"FontDemo", @"class": @"FontDemoHomeControllerViewController"},
                    @{@"title": @"SetFilletDemo", @"class": @"SetFilletDemoHomeController"},
                    @{@"title": @"Palette", @"class": @"PaletteDemoHomeController"},
                    @{@"title": @"QiPaoDemo", @"class": @"QiPaoDemoHomeController"}, nil];
    }
    return _infoArr;
}

@end
