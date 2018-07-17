//
//  DashedModel.h
//  Demo
//
//  Created by 朱超鹏 on 2017/10/10.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

// 虚线类型
typedef NS_ENUM(NSInteger, DashedType) {
    DashedType1 = 1,
    DashedType2 = 2,
};

/**
 虚线模型
 */
@interface DashedModel : ZCPDataModel <NSCopying>

// 虚线参数
/// 虚线起始偏移量 -值为向右偏移，+值为向左偏移
@property (nonatomic, assign) CGFloat phaseV;
/// 虚线虚实部分的长度参数，"实部长度,虚部长度,实部长度,..."
@property (nonatomic, strong) NSArray *lengthsV;
/// 限制长度参数中仅前count个参数生效
@property (nonatomic, assign) CGFloat countV;

// 配置参数
/// 线宽
@property (nonatomic, assign) CGFloat lineWidth;
/// 线颜色
@property (nonatomic, strong) UIColor *lineColor;

// 类型参数
/// 虚线类型
@property (nonatomic, assign) DashedType type;

@end
