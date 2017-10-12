//
//  ZCPMinesweeperViewController.m
//  Demo
//
//  Created by 朱超鹏 on 2017/10/12.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "ZCPMinesweeperViewController.h"
#import "SquareButton.h"
#import "MinesweeperHeader.h"
#import "MinesweeperToolMethod.h"

@interface ZCPMinesweeperViewController () <SquareButtonDelegate>

@property (nonatomic, assign) GameStatus gameStatus;
@property (nonatomic, strong) NSMutableArray<SquareButton *> *squareButtonArr;  // 所有方格数组
@property (nonatomic, strong) NSMutableArray<SquareButton *> *mineButtonArr;    // 地雷数组
@property (nonatomic, strong) NSMutableArray<SquareButton *> *numButtonArr;     // 数字数组

@end

@implementation ZCPMinesweeperViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    mineSide        = (APPLICATIONWIDTH - (LineNum + 1) * MineGap) / LineNum;
    self.gameStatus = GamePrepareStatus;
    
    [self setupUI];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)]];
}

- (void)setupUI {
    for (int i = 0; i < 64; i++) {
        int line        = i / LineNum; // 0~LineNum
        int position    = i % LineNum; // 0~LineNum
        
        SquareButton *button    = self.squareButtonArr[i];
        button.index            = i;
        button.x                = (position + 1) * MineGap + position * mineSide;
        button.y                = (line + 1) * MineGap + line * mineSide;
        button.width            = mineSide;
        button.height           = mineSide;
        [self.mineField addSubview:button];
    }
}

#pragma mark - event response

- (IBAction)clickStartButton:(UIButton *)sender {
    // 获取雷数
    int mineCount = self.mineNumInput.text.intValue;
    // 如果雷数输入有误，则不开始游戏
    if (mineCount < 0 || mineCount > TotalCount) {
        self.gameStatus = GamePrepareStatus;
        return;
    }
    
    // 开启游戏
    self.gameStatus = GameOnStatus;
    
    // 重置所有按钮状态
    [self resetAllSquareButton];
    
    // 根据雷数生成随机index
    int index[100] = {0};
    BOOL success = randomNums(TotalCount - 1, mineCount, index);
    if (!success) {
        NSLog(@"生成地雷失败！！");
    }
    
    // 设置地雷
    for (int i = 0; i < mineCount; i++) {
        int mineIndex = index[i];
        SquareButton *mineButton = self.squareButtonArr[mineIndex];
        mineButton.identity = SquareButtonMineIdentity;
        // 暂存地雷按钮
        [self.mineButtonArr addObject:mineButton];
    }
    
    // 设置数字
    for (int i = 0; i < TotalCount; i++) {
        SquareButton *button = self.squareButtonArr[i];
        // 如果为数字按钮，则根据八方向的雷数设置显示数字
        if (button.identity == SquareButtonNumIdentity) {
            NSArray *eightDirectionButton = [self findAroundEightDirectionButtonWithIndex:button.index];
            int showNum = [self calculateMineCountWithAroundEightDirectionButtonArr:eightDirectionButton];
            button.showNum = showNum;
            
            // 暂存数字按钮
            [self.numButtonArr addObject:button];
        }
    }
}

- (void)squareButtonIsClicked:(SquareButton *)squareButton {
    // 如果游戏结束，则不能再点击方格按钮了
    if (self.gameStatus == GameOverStatus || self.gameStatus == GamePrepareStatus) {
        return;
    }
    
    // 如果被点击的方格已经是正面了，则不处理
    if (squareButton.status == SquareButtonFrontStatus) {
        return;
    }
    
    // 将被点击的方格置为正面
    squareButton.status = SquareButtonFrontStatus;
    
    if (squareButton.identity == SquareButtonNumIdentity) {
        // 如果点到数字，数字为0（意味着8方向均为数字），则继续点击周围四方向的方格按钮
        if (squareButton.showNum == 0) {
            int index = squareButton.index;
            NSArray *fourDirectionButtonArr = [self findAroundFourDirectionButtonWithIndex:index];
            for (SquareButton *fourDirectionButton in fourDirectionButtonArr) {
                [self squareButtonIsClicked:fourDirectionButton];
            }
        }
    } else if (squareButton.identity == SquareButtonMineIdentity) {
        // 如果点到雷，游戏结束
        self.gameStatus = GameOverStatus;
    }
    
    if ([self checkWin]) {
        self.gameStatus = GameWinStatus;
    }
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

#pragma mark -

/**
 找index对应位置四方向的按钮
 */
- (NSArray *)findAroundFourDirectionButtonWithIndex:(int)index {
    NSMutableArray *aroundButtons = [NSMutableArray arrayWithCapacity:LineNum];
    
    int aroundIndexs[4] = {0};
    int indexCount = getMatrixDirectionIndexsWithIndex(4, index, LineNum, aroundIndexs);
    
    for (int i = 0; i < indexCount; i++) {
        int index = aroundIndexs[i];
        if (index >= 0 && index < TotalCount) {
            [aroundButtons addObject:self.squareButtonArr[index]];
        }
    }
    return aroundButtons;
}

/**
 找index对应位置八方向的按钮
 */
- (NSArray *)findAroundEightDirectionButtonWithIndex:(int)index {
    NSMutableArray *aroundButtons = [NSMutableArray arrayWithCapacity:LineNum];
    
    int aroundIndexs[8] = {0};
    int indexCount = getMatrixDirectionIndexsWithIndex(8, index, LineNum, aroundIndexs);
    
    for (int i = 0; i < indexCount; i++) {
        int index = aroundIndexs[i];
        if (index >= 0 && index < TotalCount) {
            [aroundButtons addObject:self.squareButtonArr[index]];
        }
    }
    return aroundButtons;
}

/**
 根据传入的方格数组计算有几个雷
 */
- (int)calculateMineCountWithAroundEightDirectionButtonArr:(NSArray <SquareButton *>*)buttonArr {
    int buttonNum = 0;
    for (SquareButton *button in buttonArr) {
        if (button.identity == SquareButtonMineIdentity) {
            buttonNum ++;
        }
    }
    return buttonNum;
}

/**
 显示所有地雷
 */
- (void)setAllMineButtonToFront {
    for (SquareButton *button in self.mineButtonArr) {
        button.status = SquareButtonFrontStatus;
    }
}

/**
 标记所有地雷
 */
- (void)markAllMineButton {
    for (SquareButton *button in self.mineButtonArr) {
        button.marked = YES;
    }
}

/**
 重置所有按钮状态
 */
- (void)resetAllSquareButton {
    // 重置数组
    [self.mineButtonArr removeAllObjects];
    [self.numButtonArr removeAllObjects];
    
    // 重置所有按钮状态
    for (int i = 0; i < TotalCount; i++) {
        SquareButton *button = self.squareButtonArr[i];
        [button resetup];
    }
}

/**
 检查是否胜利
 */
- (BOOL)checkWin {
    // 如果所有数字按钮均翻转到正面，则游戏胜利
    for (SquareButton *numButton in self.numButtonArr) {
        if (numButton.status == SquareButtonBackStatus) {
            return NO;
        }
    }
    return YES;
}

#pragma mark - getters and setters

- (void)setGameStatus:(GameStatus)gameStatus {
    _gameStatus = gameStatus;
    if (gameStatus == GameOverStatus) {
        self.statusLabel.text = @"游戏结束";
        [self setAllMineButtonToFront];
    } else if (gameStatus == GameOnStatus) {
        self.statusLabel.text = @"游戏中...";
    } else if (gameStatus == GamePrepareStatus) {
        self.statusLabel.text = @"准备开始";
        [self resetAllSquareButton];
    } else if (gameStatus == GameWinStatus) {
        self.statusLabel.text = @"胜利了";
        [self markAllMineButton];
        [self setAllMineButtonToFront];
    }
}

- (NSMutableArray<SquareButton *> *)squareButtonArr {
    if (!_squareButtonArr) {
        _squareButtonArr = [NSMutableArray array];
        for (int i = 0; i < TotalCount; i++) {
            SquareButton *button    = [SquareButton instanceSquareButton];
            button.delegate         = self;
            [_squareButtonArr addObject:button];
        }
    }
    return _squareButtonArr;
}

- (NSMutableArray<SquareButton *> *)mineButtonArr {
    if (!_mineButtonArr) {
        _mineButtonArr = [NSMutableArray array];
    }
    return _mineButtonArr;
}

- (NSMutableArray<SquareButton *> *)numButtonArr {
    if (!_numButtonArr) {
        _numButtonArr = [NSMutableArray array];
    }
    return _numButtonArr;
}

@end
