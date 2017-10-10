//
//  ZCPDemoHomeViewController.m
//  Demo
//
//  Created by 朱超鹏 on 2017/10/10.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "ZCPDemoHomeViewController.h"

@implementation ZCPDemoHomeViewController

@synthesize infoArr = _infoArr;

- (NSMutableArray *)infoArr {
    if (_infoArr == nil) {
        _infoArr = [NSMutableArray arrayWithObjects:
                    @{@"title": @"临时测试"             , @"class": APPURL_VIEW_IDENTIFIER_TEMPTEST},
                    @{@"title": @"UIDemo"               , @"class": APPURL_VIEW_IDENTIFIER_UIHOME},
                    @{@"title": @"WebViewDemo"          , @"class": @"WebViewDemoHomeController"},
                    @{@"title": @"AlertViewDemo"        , @"class": @"AlertViewDemoHomeController"},
                    @{@"title": @"PageVCDemo"           , @"class": @"PageVCDemoHomeController"},
                    @{@"title": @"CameraAndAlbumDemo"   , @"class": @"CameraAndAlbumDemoHomeController"},
                    @{@"title": @"OtherDemo"            , @"class": @"OtherDemoHomeController"},
                    @{@"title": @"PhotoCarouselDemo"    , @"class": @"PhotoCarouselDemoHomeController"},
                    @{@"title": @"ShareDemo"            , @"class": @"ShareDemoHomeController"},
                    @{@"title": @"PADemo"               , @"class": @"PADemoHomeController"},
                    @{@"title": @"TabBarDemo"           , @"class": @"TabBarDemoHomeController"},
                    @{@"title": @"NetWorkDemo"          , @"class": @"NetWorkDemoHomeController"},
                    @{@"title": @"二维码扫描"            , @"class": @"QRCodeDemoHomeController"},
                    @{@"title": @"国际化"              , @"class": @"InternationalizationDemoHomeController"},
                    @{@"title": @"地图&定位"            , @"class": @"MapDemoHomeViewController"},
                    @{@"title": @"广告"               , @"class": @"ADDemoHomeViewController"}, nil];
    }
    return _infoArr;
}

@end
