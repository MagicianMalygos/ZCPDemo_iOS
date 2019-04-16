//
//  ZCPSectionCell.h
//  ZCPUIKit
//
//  Created by zcp on 16/1/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewCell.h"

/// 标签文字的位置
typedef NS_ENUM(NSInteger, ZCPSectionTitlePosition) {
    ZCPSectionTitleNonePosition     = 1 << 0, //!< 无
    ZCPSectionTitleMiddlePosition   = 1 << 1, //!< 中
    ZCPSectionTitleTopPosition      = 1 << 2, //!< 上
    ZCPSectionTitleBottomPosition   = 1 << 3, //!< 下
    ZCPSectionTitleLeftPosition     = 1 << 4, //!< 左
    ZCPSectionTitleRightPosition    = 1 << 5  //!< 右
};

/**
 带有一个标题的cell
 */
@interface ZCPSectionCell : ZCPTableViewCell

@property (nonatomic, strong)   UILabel                 *sectionTitleLabel;     // section标题标签

@end

/**
 带有一个标题的cell item
 */
@interface ZCPSectionCellItem : ZCPTableViewCellDataModel

/// section标题
@property (nonatomic, copy)     NSString                *sectionTitle;
/// section字体
@property (nonatomic, strong)   UIFont                  *sectionTitleFont;
/// section富文本标题
@property (nonatomic, strong)   NSAttributedString      *sectionAttrTitle;
/// section标签的边距
@property (nonatomic, assign)   UIEdgeInsets            sectionTitleEdgeInsets;
/// section标签文字的位置
@property (nonatomic, assign)   ZCPSectionTitlePosition sectionTitlePosition;   // section文本位置

@end
