//
//  ZCPBlankCell.m
//  Apartment
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPBlankCell.h"

@implementation ZCPBlankCell

// ----------------------------------------------------------------------
#define mark - layout
// ----------------------------------------------------------------------
- (void)layoutSubviews {
    [super layoutSubviews];
    ZCPCellDataModel *item = (ZCPCellDataModel *)self.object;
    
    // 设置cell背景颜色
    UIColor *bgColor = item.cellBgColor ? item.cellBgColor : [UIColor clearColor];
    [self setCustomBackgroundColor:bgColor];
}

@end
