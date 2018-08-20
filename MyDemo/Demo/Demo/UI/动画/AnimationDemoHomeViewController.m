//
//  AnimationDemoHomeViewController.m
//  Demo
//
//  Created by 朱超鹏 on 2018/6/19.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "AnimationDemoHomeViewController.h"

@implementation AnimationDemoHomeViewController

@synthesize infoArr = _infoArr;

- (NSMutableArray *)infoArr {
    if (_infoArr == nil) {
        _infoArr = [NSMutableArray arrayWithObjects:
                    @{@"title": @"CATransform3DDemo"    , @"class": APPURL_VIEW_IDENTIFIER_CATRANSFORM3D},
                    @{@"title": @"波浪线"                , @"class": APPURL_VIEW_IDENTIFIER_WAVELINE},
                    @{@"title": @"爆炸效果"              , @"class": APPURL_VIEW_IDENTIFIER_EXPLODE},
                    @{@"title": @"橡皮筋效果"             , @"class": APPURL_VIEW_IDENTIFIER_ELASTIC},
                    @{@"title": @"钟表"                  , @"class": APPURL_VIEW_IDENTIFIER_CLOCK},
                    @{@"title": @"动画按钮"              , @"class": APPURL_VIEW_IDENTIFIER_ANIMATIONBUTTON},
                    nil];
    }
    return _infoArr;
}

@end
