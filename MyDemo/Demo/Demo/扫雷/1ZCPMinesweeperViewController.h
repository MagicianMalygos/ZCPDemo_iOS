//
//  ZCPMinesweeperViewController.h
//  Demo
//
//  Created by 朱超鹏 on 2017/6/19.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCPMinesweeperViewController : ZCPViewController

// 雷区
@property (weak, nonatomic) IBOutlet UIView *mineField;
// 输入雷数
@property (weak, nonatomic) IBOutlet UITextField *mineNumInput;
// 开始
@property (weak, nonatomic) IBOutlet UIButton *startButton;
// 总雷数
@property (weak, nonatomic) IBOutlet UILabel *totalNumLabel;
// 剩余数
@property (weak, nonatomic) IBOutlet UILabel *remainNumLabel;
// 状态板
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end
