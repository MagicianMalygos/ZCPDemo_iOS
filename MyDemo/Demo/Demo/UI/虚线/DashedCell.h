//
//  DashedCell.h
//  Demo
//
//  Created by 朱超鹏 on 2017/10/10.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DashedView.h"

/**
 虚线cell
 */
@interface DashedCell : ZCPTableViewCell

@property (nonatomic, strong) DashedView *dashedView;

@end

/**
 虚线cell item
 */
@interface DashedCellItem : ZCPTableViewCellDataModel

@property (nonatomic, strong) DashedModel *model;

@end
