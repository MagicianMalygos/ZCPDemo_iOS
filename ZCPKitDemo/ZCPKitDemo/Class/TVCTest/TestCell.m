//
//  TestCell.m
//  ZCPKitDemo
//
//  Created by 朱超鹏 on 2017/9/11.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "TestCell.h"

@implementation TestCell

- (void)setupContentView {
    [self.contentView addSubview:self.testTitleLabel];
    [self.contentView addSubview:self.testSubTitleLabel];
}

- (void)setObject:(TestCellItem *)object {
    if (!object || self.object == object) {
        return;
    }
    [super setObject:object];
    
    self.testTitleLabel.text    = object.title;
    self.testSubTitleLabel.text = object.subTitle;
    if (object.showAccessory) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.testTitleLabel.frame       = CGRectMake(0, 0, 100, 50);
    self.testSubTitleLabel.frame    = CGRectMake(100, 0, APPLICATIONWIDTH - 130, 50);
}

- (UILabel *)testTitleLabel {
    if (!_testTitleLabel) {
        _testTitleLabel = [[UILabel alloc] init];
        _testTitleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        _testTitleLabel.textColor = [UIColor redColor];
    }
    return _testTitleLabel;
}

- (UILabel *)testSubTitleLabel {
    if (!_testSubTitleLabel) {
        _testSubTitleLabel = [[UILabel alloc] init];
        _testSubTitleLabel.font = [UIFont systemFontOfSize:14.0f];
        _testSubTitleLabel.textColor = [UIColor redColor];
        _testSubTitleLabel.textAlignment = NSTextAlignmentRight;
    }
    return _testSubTitleLabel;
}

@end

@implementation TestCellItem

- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass      = [TestCell class];
        self.cellHeight     = @(50);
        self.cellType       = @"TestCell";
        self.cellBgColor    = [UIColor colorFromHexRGB:@"a3a3a3"];
    }
    return self;
}

@end
