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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Demo";
}

- (NSMutableArray *)infoArr {
    if (_infoArr == nil) {
        _infoArr = [NSMutableArray arrayWithObjects:
                    @{@"title": @"临时测试"             , @"class": APPURL_VIEW_IDENTIFIER_TEMPTESTHOME},
                    @{@"title": @"UIDemo"               , @"class": APPURL_VIEW_IDENTIFIER_UIHOME},
                    @{@"title": @"WebViewDemo"          , @"class": APPURL_VIEW_IDENTIFIER_WEBHOME},
                    @{@"title": @"AlertViewDemo"        , @"class": APPURL_VIEW_IDENTIFIER_ALERTHOME},
                    @{@"title": @"PageVCDemo"           , @"class": APPURL_VIEW_IDENTIFIER_PAGEVCHOME},
                    @{@"title": @"CameraAndAlbumDemo"   , @"class": APPURL_VIEW_IDENTIFIER_ALBUMHOME},
                    @{@"title": @"OtherDemo"            , @"class": APPURL_VIEW_IDENTIFIER_OTHERHOME},
                    @{@"title": @"PhotoCarouselDemo"    , @"class": APPURL_VIEW_IDENTIFIER_PHOTOCAROUSELHOME},
                    @{@"title": @"ShareDemo"            , @"class": APPURL_VIEW_IDENTIFIER_SHAREHOME},
                    @{@"title": @"PADemo"               , @"class": APPURL_VIEW_IDENTIFIER_PAHOME},
                    @{@"title": @"TabBarDemo"           , @"class": APPURL_VIEW_IDENTIFIER_TABBARHOME},
                    @{@"title": @"NetWorkDemo"          , @"class": APPURL_VIEW_IDENTIFIER_NETWORKHOME},
                    @{@"title": @"二维码扫描"            , @"class": APPURL_VIEW_IDENTIFIER_QRCODEHOME},
                    @{@"title": @"国际化"              , @"class": APPURL_VIEW_IDENTIFIER_INTERNATIONALHOME},
                    @{@"title": @"地图&定位"            , @"class": APPURL_VIEW_IDENTIFIER_MAPHOME},
                    @{@"title": @"广告"               , @"class": APPURL_VIEW_IDENTIFIER_ADHOME},
                    @{@"title": @"扫雷"               , @"class": APPURL_VIEW_IDENTIFIER_MINESWEEPER}, nil];
    }
    return _infoArr;
}

@end
