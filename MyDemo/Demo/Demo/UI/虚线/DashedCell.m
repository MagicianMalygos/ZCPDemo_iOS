//
//  DashedCell.m
//  Demo
//
//  Created by 朱超鹏 on 2017/10/10.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "DashedCell.h"

@implementation DashedCell

@end

@implementation DashedCellItem

- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [DashedCell class];
        self.cellType = @"DashedCell";
    }
    return self;
}

@end
