//
//  ZCPCellDataModel.m
//  ZCPKit
//
//  Created by zhuchaopeng on 16/9/21.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPCellDataModel.h"

@implementation ZCPCellDataModel


// ----------------------------------------------------------------------
#pragma mark - instancetype
// ----------------------------------------------------------------------
+ (instancetype)modelFromDictionary:(NSDictionary *)dictionary {
    return [[self alloc] initWithDictionary:dictionary];
}
- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}
- (instancetype)initWithDefault {
    if (self = [super init]) {
        self.groupedCellPosition    = ZCPGroupedCellPositionNone;
        self.topLinewidth           = APPLICATIONWIDTH;
        self.bottomLineWidth        = APPLICATIONWIDTH;
        self.cellTag                = INT_MAX;
    }
    return self;
}
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}
- (NSDictionary *)dictionaryValue {
    return nil;
}
- (instancetype)copyWithZone:(NSZone *)zone {
    ZCPCellDataModel *model     = [[[self class] alloc] init];
    model.idString              = self.idString;
    model.eventBlock            = [self.eventBlock copy];
    model.cellClass             = self.cellClass;
    model.cellHeight            = self.cellHeight;
    model.cellType              = self.cellType;
    model.cellSelResponse       = self.cellSelResponse;
    model.cellTag               = self.cellTag;
    model.groupedCellPosition   = self.groupedCellPosition;
    model.showIndicate          = self.showIndicate;
    model.topLinewidth          = self.topLinewidth;
    model.topLineLeftInset      = self.topLineLeftInset;
    model.bottomLineWidth       = self.bottomLineWidth;
    model.bottomLineLeftInset   = self.bottomLineLeftInset;
    model.topLineColor          = self.topLineColor;
    model.bottomLineColor       = self.bottomLineColor;
    model.useNib                = self.useNib;
    return model;
}


@end
