//
//  DashedSettingView.h
//  Demo
//
//  Created by 朱超鹏(外包) on 17/1/12.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DashedSettingViewDelegate;

/**
 虚线配置参数视图
 */
@interface DashedSettingView : UIView

@property (weak, nonatomic) IBOutlet UITextField *phaseTextField;
@property (weak, nonatomic) IBOutlet UITextField *countTextField;
@property (weak, nonatomic) IBOutlet UITextField *lengthsTextField;
@property (weak, nonatomic) IBOutlet UIButton *goButton;
@property (weak, nonatomic) IBOutlet UIButton *moveButton;

@property (nonatomic, weak) id<DashedSettingViewDelegate> delegate;

@end

/**
 虚线配置参数视图代理回调
 */
@protocol DashedSettingViewDelegate <NSObject>

/**
 点击go按钮
 */
- (void)clickGoButton:(UIButton *)button;

/**
 点击move按钮
 */
- (void)clickMoveButton:(UIButton *)button;

@end
