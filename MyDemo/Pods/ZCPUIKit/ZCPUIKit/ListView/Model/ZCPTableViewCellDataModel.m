//
//  ZCPTableViewCellDataModel.m
//  ZCPUIKit
//
//  Created by zhuchaopeng on 16/9/21.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewCellDataModel.h"
#import "ZCPGlobal.h"

@implementation ZCPTableViewCellDataModel

// ----------------------------------------------------------------------
#pragma mark - @synthesize
// ----------------------------------------------------------------------
@synthesize cellClass           = _cellClass;
@synthesize cellType            = _cellType;
@synthesize cellHeight          = _cellHeight;
@synthesize cellSelResponse     = _cellSelResponse;
@synthesize showAccessory       = _showAccessory;
@synthesize showTopLine         = _showTopLine;
@synthesize topLineLength       = _topLineLength;
@synthesize topLineOffset       = _topLineOffset;
@synthesize topLineColor        = _topLineColor;
@synthesize showBottomLine      = _showBottomLine;
@synthesize bottomLineLength    = _bottomLineLength;
@synthesize bottomLineOffset    = _bottomLineOffset;
@synthesize bottomLineColor     = _bottomLineColor;
@synthesize cellBgColor         = _cellBgColor;
@synthesize cellTag             = _cellTag;
@synthesize groupedCellPosition = _groupedCellPosition;
@synthesize eventBlock          = _eventBlock;
@synthesize useNib              = _useNib;

// ----------------------------------------------------------------------
#pragma mark - instancetype
// ----------------------------------------------------------------------

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (instancetype)initWithDefault {
    if (self = [super init]) {
        self.groupedCellPosition    = ZCPGroupedCellPositionNone;
        self.topLineLength          = SCREENWIDTH;
        self.bottomLineLength       = SCREENWIDTH;
        self.cellTag                = INT_MAX;
    }
    return self;
}

+ (instancetype)modelFromDictionary:(NSDictionary *)dictionary {
    return [[self alloc] initWithDictionary:dictionary];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

- (NSDictionary *)dictionaryValue {
    return @{};
}

// ----------------------------------------------------------------------
#pragma mark - copy
// ----------------------------------------------------------------------

- (instancetype)copyWithZone:(NSZone *)zone {
    ZCPTableViewCellDataModel *model    = [[[self class] alloc] init];
    model.idString                      = self.idString;
    model.eventBlock                    = [self.eventBlock copy];
    model.cellClass                     = self.cellClass;
    model.cellHeight                    = self.cellHeight;
    model.cellType                      = self.cellType;
    model.cellSelResponse               = self.cellSelResponse;
    model.cellTag                       = self.cellTag;
    model.groupedCellPosition           = self.groupedCellPosition;
    model.showAccessory                 = self.showAccessory;
    model.topLineLength                 = self.topLineLength;
    model.topLineOffset                 = self.topLineOffset;
    model.topLineColor                  = self.topLineColor;
    model.bottomLineLength              = self.bottomLineLength;
    model.bottomLineOffset              = self.bottomLineOffset;
    model.bottomLineColor               = self.bottomLineColor;
    model.useNib                        = self.useNib;
    return model;
}

@end
