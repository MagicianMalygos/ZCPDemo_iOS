//
//  ZCPLDFrameEntranceView.m
//  Demo
//
//  Created by zcp on 2019/5/14.
//  Copyright © 2019 zcp. All rights reserved.
//

#import "ZCPLDFrameEntranceView.h"
#import "ZCPLDCommon.h"

@implementation ZCPLDFrameEntranceView

- (void)setEntranceArr:(NSArray *)entranceArr {
    _entranceArr = entranceArr;
    [self updateView];
}

- (void)updateView {
    [self removeAllSubviews];
}

@end
