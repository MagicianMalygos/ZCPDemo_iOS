//
//  ZCPDataModel.m
//  Apartment
//
//  Created by apple on 15/12/28.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import "ZCPDataModel.h"

@implementation ZCPDataModel

#pragma mark - synthesize
@synthesize idString                = _idString;
// protocol synthesize
@synthesize eventBlock              = _eventBlock;
@synthesize cellClass               = _cellClass;
@synthesize cellType                = _cellType;
@synthesize cellHeight              = _cellHeight;
@synthesize cellSelResponse         = _cellSelResponse;
@synthesize cellTag                 = _cellTag;
@synthesize groupedCellPosition     = _groupedCellPosition;
@synthesize lineIndent              = _lineIndent;
@synthesize useNib                  = _useNib;

#pragma mark - instancetype
+ (instancetype)modelFromDictionary:(NSDictionary *)dictionary {
    ZCPDataModel *instance = [[self alloc] initWithDictionary:dictionary];
    if (instance) {
    }
    return instance;
}
- (instancetype)init {
    if (self = [super init]) {
        self.groupedCellPosition = ZCPGroupedCellPositionNone;
        self.lineIndent = @10;
        self.cellTag = INT_MAX;
    }
    return self;
}
- (instancetype)initWithDefault {
    if (self = [super init]) {
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
    ZCPDataModel *model = [[[self class] alloc] init];
    model.idString              = self.idString;
    model.eventBlock            = [self.eventBlock copy];
    model.cellClass             = self.cellClass;
    model.cellHeight            = self.cellHeight;
    model.cellType              = self.cellType;
    model.cellSelResponse       = self.cellSelResponse;
    model.cellTag               = self.cellTag;
    model.groupedCellPosition   = self.groupedCellPosition;
    model.lineIndent            = self.lineIndent;
    model.useNib                = self.useNib;
    return model;
}

@end
