//
//  DashedView.h
//  Demo
//
//  Created by 朱超鹏(外包) on 17/1/12.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DashedModel.h"

/**
 虚线view
 */
@interface DashedView : UIView

/**
 配置虚线view

 @param model 虚线模型
 */
- (void)configureWithModel:(DashedModel *)model;

@end
