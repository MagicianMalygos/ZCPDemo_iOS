//
//  ZCPTableViewCellItemBasicProtocol.h
//  ZCPKit
//
//  Created by zhuchaopeng on 16/9/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

// 用于标识cell上下边线显示
typedef NS_ENUM(NSUInteger, ZCPGroupedCellPosition) {
    ZCPGroupedCellPositionNone,
    ZCPGroupedCellPositionFirst,
    ZCPGroupedCellPositionMiddle,
    ZCPGroupedCellPositionLast
};

typedef void(^ZCPEventBlock)(id object);

// ----------------------------------------------------------------------
#pragma mark - cellitem 均需要实现此协议，以此来建立适配关系
// ----------------------------------------------------------------------
@protocol ZCPTableViewCellItemBasicProtocol <NSObject>

// cell Class
@property (nonatomic, strong)   Class           cellClass;
// cell Type
@property (nonatomic, copy)     NSString        *cellType;
// cell Height
@property (nonatomic, strong)   NSNumber        *cellHeight;
// cell响应对象
@property (nonatomic, weak)     id              cellSelResponse;
// 显示 右边指示图标
@property (nonatomic, assign)   BOOL            showIndicate;
// 上边线尺寸，默认为0
@property (nonatomic, assign)   CGFloat         topLinewidth;
@property (nonatomic, assign)   CGFloat         topLineLeftInset;
@property (nonatomic, strong)   UIColor         *topLineColor;
// 下边线尺寸，默认为0
@property (nonatomic, assign)   CGFloat         bottomLineWidth;
@property (nonatomic, assign)   CGFloat         bottomLineLeftInset;
@property (nonatomic, strong)   UIColor         *bottomLineColor;
// cell背景颜色
@property (nonatomic, strong)   UIColor         *cellBgColor;
// cell数据源tag标识
@property (nonatomic, assign)   int             cellTag;
// cell的位置
@property (nonatomic, assign)   ZCPGroupedCellPosition groupedCellPosition;
// event block
@property (nonatomic, copy)     ZCPEventBlock   eventBlock;
// 是否使用nib
@property (nonatomic, assign)   BOOL            useNib;

@end
