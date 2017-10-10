//
//  DashedCell.h
//  Demo
//
//  Created by 朱超鹏 on 2017/10/10.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import <ZCPKit/ZCPKit.h>

@interface DashedCellItem : ZCPCellDataModel

@property (nonatomic, strong) NSValue *drawDashedMethod;

@end

@interface DashedCell : ZCPBlankCell

@property (nonatomic, strong) DashedCellItem *item;

@end
