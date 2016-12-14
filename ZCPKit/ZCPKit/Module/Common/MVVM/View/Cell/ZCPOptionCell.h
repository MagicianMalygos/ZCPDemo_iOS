//
//  ZCPOptionCell.h
//  Apartment
//
//  Created by apple on 16/1/22.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewWithLineCell.h"
#import "ZCPOptionView.h"

@class ZCPOptionCellItem;

// ----------------------------------------------------------------------
#pragma mark - 选项视图Cell
// ----------------------------------------------------------------------
@interface ZCPOptionCell : ZCPTableViewWithLineCell

@property (nonatomic, strong) ZCPOptionView *optionView;    // 选项视图

@end

// ----------------------------------------------------------------------
#pragma mark - 选项视图CellItem
// ----------------------------------------------------------------------
@interface ZCPOptionCellItem : ZCPCellDataModel

@property (nonatomic, strong) NSArray *attributedStringArr;     // 富文本数组,对应item个数
@property (nonatomic, weak) id<ZCPOptionViewDelegate>delegate;  // delegate

@end
