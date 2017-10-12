//
//  MinesweeperHeader.h
//  Demo
//
//  Created by 朱超鹏 on 2017/10/11.
//  Copyright © 2017年 zcp. All rights reserved.
//

#ifndef MinesweeperHeader_h
#define MinesweeperHeader_h

#define LineNum         8                   // 行数
#define TotalCount      LineNum * LineNum   // 总数
#define BackColor       @"ff8343"           // 反面颜色
#define MineColor       @"ff2ce7"           // 炸弹颜色
#define NumColor        @"ffffff"           // 数字颜色
#define MineGap         8                   // 按钮间隙
static CGFloat mineSide;                    // 按钮宽度

// 游戏状态
typedef NS_ENUM(NSInteger, GameStatus) {
    GamePrepareStatus           = 0,    // 准备
    GameOnStatus                = 1,    // 进行
    GameOverStatus              = 2,    // 结束
    GameWinStatus               = 3     // 胜利
};

// 方格按钮状态
typedef NS_ENUM(NSInteger, SquareButtonStatus) {
    SquareButtonBackStatus      = 0,    // 背面状态
    SquareButtonFrontStatus     = 1     // 正面状态
};

// 方格按钮身份
typedef NS_ENUM(NSInteger, SquareButtonIdentity) {
    SquareButtonNumIdentity     = 0,    // 数字
    SquareButtonMineIdentity    = 1     // 地雷
};


#endif /* MinesweeperHeader_h */
