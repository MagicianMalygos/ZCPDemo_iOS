//
//  ZCPSectionCell.h
//  Apartment
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewCell.h"
#import "ZCPLineCell.h"

@class ZCPSectionCellItem;

#pragma mark - Section Cell
// 用作Section的Cell
@interface ZCPSectionCell : ZCPLineCell

@property (nonatomic, strong) UILabel *sectionTitleLabel;               // section标题标签

@end

#pragma mark - Section CellItem
@interface ZCPSectionCellItem : ZCPLineCellItem <NSCopying>

@property (nonatomic, copy) NSString *sectionTitle;                     // section标题
@property (nonatomic, strong) NSAttributedString *sectionAttrTitle;     // section富文本标题
@property (nonatomic, strong) UIFont *font;                             // section字体
@property (nonatomic, assign) UIEdgeInsets titleEdgeInset;              // section标题边距

@end
