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
                    @{@"title": @"Core Animation"       , @"class": APPURL_VIEW_IDENTIFIER_COREANIMATION},
                    @{@"title": @"临时测试"              , @"class": APPURL_VIEW_IDENTIFIER_TEMPTESTHOME},
                    @{@"title": @"UIDemo"               , @"class": APPURL_VIEW_IDENTIFIER_UIHOME},
                    @{@"title": @"CameraAndAlbumDemo"   , @"class": APPURL_VIEW_IDENTIFIER_ALBUMHOME},
                    @{@"title": @"OtherDemo"            , @"class": APPURL_VIEW_IDENTIFIER_OTHERHOME},
                    @{@"title": @"二维码扫描"             , @"class": APPURL_VIEW_IDENTIFIER_QRCODEHOME},
                    @{@"title": @"扫雷"                  , @"class": APPURL_VIEW_IDENTIFIER_MINESWEEPER},
                    
                    @{@"title": @"锁"                    , @"class": APPURL_VIEW_IDENTIFIER_LOCK},
        
                    @{@"title": @"NetWorkDemo"          , @"class": APPURL_VIEW_IDENTIFIER_NETWORKHOME},
                    @{@"title": @"WebViewDemo"          , @"class": APPURL_VIEW_IDENTIFIER_WEBHOME},
                    @{@"title": @"PageVCDemo"           , @"class": APPURL_VIEW_IDENTIFIER_PAGEVCHOME},
                    
                    
                    @{@"title": @"PhotoCarouselDemo"    , @"class": APPURL_VIEW_IDENTIFIER_PHOTOCAROUSELHOME},
                    @{@"title": @"ShareDemo"            , @"class": APPURL_VIEW_IDENTIFIER_SHAREHOME},
                    @{@"title": @"TabBarDemo"           , @"class": APPURL_VIEW_IDENTIFIER_TABBARHOME},
                    
                    @{@"title": @"国际化"                , @"class": APPURL_VIEW_IDENTIFIER_INTERNATIONALHOME},
                    @{@"title": @"地图&定位"             , @"class": APPURL_VIEW_IDENTIFIER_MAPHOME},
                    @{@"title": @"广告"                  , @"class": APPURL_VIEW_IDENTIFIER_ADHOME},
                    
                    @{@"title": @"日志"                  , @"class": APPURL_VIEW_IDENTIFIER_LOG}, nil];
    }
    return _infoArr;
}

@end
