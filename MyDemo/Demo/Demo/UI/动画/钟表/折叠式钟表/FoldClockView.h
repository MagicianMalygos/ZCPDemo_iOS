//
//  FoldClockView.h
//  Demo
//
//  Created by 朱超鹏 on 2018/6/28.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoldClockItemView.h"

/**
 折叠式钟表
 */
@interface FoldClockView : UIView

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *clockItemBackgroundColor;

@property (nonatomic, assign) UIEdgeInsets itemInsets;
@property (nonatomic, assign) CGFloat itemSpacing;

@end
