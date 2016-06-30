//
//  ZCPTableViewCellItemBasicProtocol.h
//  Apartment
//
//  Created by apple on 16/1/14.
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

@protocol ZCPTableViewCellItemBasicProtocol <NSObject>

// event block
@property (nonatomic, copy) ZCPEventBlock eventBlock;
// cell Class
@property (nonatomic, strong) Class cellClass;
// cell Type
@property (nonatomic, copy) NSString * cellType;
// cell Height
@property (nonatomic, strong) NSNumber *cellHeight;
// cell响应对象
@property (nonatomic, weak) id cellSelResponse;
// cell数据源tag标识
@property (nonatomic, assign) int cellTag;
// cell的位置
@property (nonatomic, assign) ZCPGroupedCellPosition groupedCellPosition;
// cell上下边线的缩进值
@property (nonatomic, strong) NSNumber *lineIndent;
// 是否使用nib
@property (nonatomic, assign) BOOL useNib;

@end