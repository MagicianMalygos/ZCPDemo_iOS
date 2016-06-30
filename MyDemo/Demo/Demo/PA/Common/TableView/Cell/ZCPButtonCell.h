//
//  ZCPButtonCell.h
//  Apartment
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewCell.h"

@class ZCPButtonCellItem;
@protocol ZCPButtonCellDelegate;

// 按钮初始状态枚举
typedef enum {
    ZCPButtonInitStateNormal=100,   // normal
    ZCPButtonInitStateHighlighted,  // highlighted
    ZCPButtonInitStateDisabled      // disabled
}ZCPButtonInitialize;

// 只有一个Button的Cell
@interface ZCPButtonCell : ZCPTableViewCell

@property (nonatomic, strong) UIButton *button;                             // 按钮
@property (nonatomic, strong) ZCPButtonCellItem *item;                      // item
@property (nonatomic, weak) id<ZCPButtonCellDelegate> delegate;             // delegate

@end

@interface ZCPButtonCellItem : ZCPDataModel

@property (nonatomic, copy) NSString *buttonTitle;                          // 按钮标题
@property (nonatomic, strong) UIColor *titleColorNormal;                    // 按钮标题颜色(正常)
@property (nonatomic, strong) UIColor *titleColorHighlighted;               // 按钮标题颜色(高亮)
@property (nonatomic, strong) UIFont *titleFontNormal;                      // 按钮标题字体(正常)
@property (nonatomic, strong) UIColor *buttonBackgroundColor;               // 按钮背景颜色
@property (nonatomic, strong) UIImage *buttonBackgroundImageNormal;         // 按钮背景图片(正常)
@property (nonatomic, strong) UIImage *buttonBackgroundImageHighlighted;    // 按钮背景图片(高亮)
@property (nonatomic, strong) UIImage *buttonBackgroundImageDisabled;       // 按钮背景图片(不可用)
@property (nonatomic, assign) NSInteger tag;                                // 按钮标识
@property (nonatomic, assign) ZCPButtonInitialize state;                    // 按钮初始状态
@property (nonatomic, weak) id<ZCPButtonCellDelegate> delegate;             // delegate
@property (nonatomic, copy) ZCPButtonConfigBlock buttonConfigBlock;         // 按钮配置块

@end

@protocol ZCPButtonCellDelegate <NSObject>

- (void)cell:(UITableViewCell *)cell buttonClicked:(UIButton *)button;

@end