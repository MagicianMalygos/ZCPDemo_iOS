//
//  ZCPOptionCell.m
//  Apartment
//
//  Created by apple on 16/1/22.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPOptionCell.h"

@implementation ZCPOptionCell

// ----------------------------------------------------------------------
#pragma mark - synthesize
// ----------------------------------------------------------------------
@synthesize optionView  = _optionView;

// ----------------------------------------------------------------------
#pragma mark - setup
// ----------------------------------------------------------------------
- (void)setupContentView {
    [super setupContentView];
    self.optionView = [[ZCPOptionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self addSubview:self.optionView];
}

- (void)setObject:(id<ZCPTableViewCellItemBasicProtocol>)object {
    if (object && [object isKindOfClass:[ZCPOptionCellItem class]]) {
        [super setObject:object];
        
        ZCPOptionCellItem *item = (ZCPOptionCellItem *)object;
        
        // 设置frame
        self.optionView.frame  = CGRectMake(0, 0, self.width, [item.cellHeight floatValue]);
        
        // 设置属性
        [self.optionView setLabelArrWithAttributeStringArr:item.attributedStringArr];
        self.optionView.delegate = item.delegate;
        
        [self.optionView hideMarkView];
        [self.optionView hideLineView];
    }
}

@end

@implementation ZCPOptionCellItem

// ----------------------------------------------------------------------
#pragma mark - synthesize
// ----------------------------------------------------------------------
@synthesize attributedStringArr     = _attributedStringArr;
@synthesize delegate                = _delegate;

// ----------------------------------------------------------------------
#pragma mark - instancetype
// ----------------------------------------------------------------------
- (instancetype)init {
    if (self = [super init]) {
        self.cellClass  = [ZCPOptionCell class];
        self.cellType   = [ZCPOptionCell cellIdentifier];
    }
    return self;
}
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass  = [ZCPOptionCell class];
        self.cellType   = [ZCPOptionCell cellIdentifier];
        self.cellHeight = @30;
    }
    return self;
}

@end
