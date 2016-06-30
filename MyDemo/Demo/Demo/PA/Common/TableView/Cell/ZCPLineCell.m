//
//  ZCPLineCell.m
//  Apartment
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPLineCell.h"

@implementation ZCPLineCell

#pragma mark - synthesize
@synthesize item    = _item;

#pragma mark - Setup Cell
- (void)setupContentView {
    self.backgroundColor = [UIColor clearColor];
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPLineCellItem class]] && self.item != object) {
        self.item = (ZCPLineCellItem *)object;
        ZCPLineCellItem *item = (ZCPLineCellItem *)object;
        
        self.backgroundColor = item.backgroundColor;
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPLineCellItem *item = (ZCPLineCellItem *)object;
    return [item.cellHeight floatValue];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
}

@end

@implementation ZCPLineCellItem

#pragma mark - synthesize
@synthesize backgroundColor     = _backgroundColor;

#pragma mark - instancetype
- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [ZCPLineCell class];
        self.cellType = [ZCPLineCell cellIdentifier];
    }
    return self;
}
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPLineCell class];
        self.cellType = [ZCPLineCell cellIdentifier];
        self.cellHeight = @20;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end