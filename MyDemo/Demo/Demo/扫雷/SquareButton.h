//
//  SquareButton.h
//  Demo
//
//  Created by 朱超鹏 on 2017/10/11.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MinesweeperHeader.h"

@protocol SquareButtonDelegate;

// 方格按钮类
@interface SquareButton : UIButton

/// 在方格数组中的索引
@property (nonatomic, assign) int index;
/// 身份 数字/地雷
@property (nonatomic, assign) SquareButtonIdentity identity;
/// 状态 正面/反面
@property (nonatomic, assign) SquareButtonStatus status;
/// 展示的数字值
@property (nonatomic, assign) int showNum;
/// 是否被标记
@property (nonatomic, assign, getter=isMarked) BOOL marked;
///
@property (nonatomic, weak) id<SquareButtonDelegate> delegate;

+ (instancetype)instanceSquareButton;
- (void)resetup;

@end

@protocol SquareButtonDelegate <NSObject>

@optional
- (void)squareButtonIsClicked:(SquareButton *)squareButton;
- (void)squareButtonIsLongPressed:(SquareButton *)squareButton;

@end
