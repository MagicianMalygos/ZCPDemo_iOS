//
//  PATableViewWithLineCell.h
//  haofang
//
//  Created by shakespeare on 14-4-1.
//  Copyright (c) 2014年 平安好房. All rights reserved.
//

// 直接配置subview block
typedef void(^PACellConfigBlock)(id subview);

// 上下都有自定义边线的Cell
@interface ZCPTableViewWithLineCell : ZCPTableViewCell

@property (nonatomic, strong) UILabel* lineUpper;
@property (nonatomic, strong) UILabel* lineLower;

@end
