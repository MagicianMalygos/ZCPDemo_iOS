//
//  ZCPMinesweeperViewController.h
//  Demo
//
//  Created by 朱超鹏 on 2017/10/12.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import <ZCPKit/ZCPKit.h>

@interface ZCPMinesweeperViewController : UIViewController

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
