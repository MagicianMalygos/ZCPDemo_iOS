//
//  ZCPDemoHomeController.m
//  Demo
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPDemoHomeController.h"

@implementation ZCPDemoHomeController

@synthesize infoArr = _infoArr;

- (NSMutableArray *)infoArr {
    if (_infoArr == nil) {
        _infoArr = [NSMutableArray arrayWithObjects:
                    @{@"title": @"WebViewDemo", @"class": @"WebViewDemoHomeController"},
                    @{@"title": @"AlertViewDemo", @"class": @"AlertViewDemoHomeController"},
                    @{@"title": @"PageVCDemo", @"class": @"PageVCDemoHomeController"},
                    @{@"title": @"CameraAndAlbumDemo", @"class": @"CameraAndAlbumDemoHomeController"},
                    @{@"title": @"OtherDemo", @"class": @"OtherDemoHomeController"},
                    @{@"title": @"PhotoCarouselDemo", @"class": @"PhotoCarouselDemoHomeController"},
                    @{@"title": @"CollectionViewDemo", @"class": @"CollectionViewDemoHomeController"},
                    @{@"title": @"ShareDemo", @"class": @"ShareDemoHomeController"},
                    @{@"title": @"PADemo", @"class": @"PADemoHomeController"},
                    @{@"title": @"TabBarDemo", @"class": @"TabBarDemoHomeController"},
                    @{@"title": @"NetWorkDemo", @"class": @"NetWorkDemoHomeController"},
                    @{@"title": @"二维码扫描", @"class": @"QRCodeDemoHomeController"},
                    @{@"title": @"UIDemo", @"class": @"UIDemoHomeController"}, nil];
    }
    return _infoArr;
}

@end
