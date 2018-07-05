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
                    @{@"title": @"动画"                  , @"class": APPURL_VIEW_IDENTIFIER_ANIMATION},
                    @{@"title": @"SizeToFitDemo"        , @"class": APPURL_VIEW_IDENTIFIER_SIZETOFIT},
                    @{@"title": @"FontDemo"             , @"class": APPURL_VIEW_IDENTIFIER_FONT},
                    @{@"title": @"SetFilletDemo"        , @"class": APPURL_VIEW_IDENTIFIER_SETFILLET},
                    @{@"title": @"Palette"              , @"class": APPURL_VIEW_IDENTIFIER_PALETTE},
                    @{@"title": @"QiPaoDemo"            , @"class": APPURL_VIEW_IDENTIFIER_QIPAO},
                    @{@"title": @"虚线"                  , @"class": APPURL_VIEW_IDENTIFIER_DASHED},
                    @{@"title": @"CollectionViewDemo"   , @"class":APPURL_VIEW_IDENTIFIER_COLLECTION},
                    nil];
    }
    return _infoArr;
}

@end
