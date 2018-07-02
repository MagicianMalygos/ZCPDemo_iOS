//
//  FoldClockView.m
//  Demo
//
//  Created by 朱超鹏 on 2018/6/28.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "FoldClockView.h"
#import "FoldClockItemView.h"

@interface FoldClockView ()

@property (nonatomic, strong) FoldClockItemView *hourItem;
@property (nonatomic, strong) FoldClockItemView *minuteItem;
@property (nonatomic, strong) FoldClockItemView *secondItem;

@end

@implementation FoldClockView

#pragma mark - life cycle

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.hourItem];
        [self addSubview:self.minuteItem];
        [self addSubview:self.secondItem];
        self.backgroundColor = [UIColor blackColor];
        self.hourItem.backgroundColor = [UIColor grayColor];
        self.minuteItem.backgroundColor = [UIColor grayColor];
        self.secondItem.backgroundColor = [UIColor grayColor];
        self.itemInsets = UIEdgeInsetsMake(20, 20, 20, 20);
        self.itemSpacing = 20;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat itemWidth       = (self.width - self.itemInsets.left - self.itemInsets.right - 2*self.itemSpacing) / 3;
    CGFloat itemHeight      = self.height - self.itemInsets.top - self.itemInsets.bottom;
    
    self.hourItem.frame     = CGRectMake(self.itemInsets.left, self.itemInsets.top, itemWidth, itemHeight);
    self.minuteItem.frame   = CGRectMake(self.hourItem.right + self.itemSpacing, self.itemInsets.top, itemWidth, itemHeight);
    self.secondItem.frame   = CGRectMake(self.minuteItem.right + self.itemSpacing, self.itemInsets.top, itemWidth, itemHeight);
}

#pragma mark - setters

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    // 缺省font值
    if (!self.font) {
        CGFloat itemWidth       = (self.width - self.itemInsets.left - self.itemInsets.right - 2*self.itemSpacing) / 3;
        self.hourItem.font = [UIFont systemFontOfSize:itemWidth / 2];
        self.minuteItem.font = [UIFont systemFontOfSize:itemWidth / 2];
        self.secondItem.font = [UIFont systemFontOfSize:itemWidth / 2];
    }
}

- (void)setFont:(UIFont *)font {
    _font = font;
    self.hourItem.font = font;
    self.minuteItem.font = font;
    self.secondItem.font = font;
}

- (void)setDate:(NSDate *)date {
    _date = date;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    
    [self.hourItem updateTime:dateComponent.hour];
    [self.minuteItem updateTime:dateComponent.minute];
    [self.secondItem updateTime:dateComponent.second];
}

#pragma mark - getters and setters

- (FoldClockItemView *)hourItem {
    if (!_hourItem) {
        _hourItem = [[FoldClockItemView alloc] initWithTime:0];
    }
    return _hourItem;
}

- (FoldClockItemView *)minuteItem {
    if (!_minuteItem) {
        _minuteItem = [[FoldClockItemView alloc] initWithTime:0];
    }
    return _minuteItem;
}

- (FoldClockItemView *)secondItem {
    if (!_secondItem) {
        _secondItem = [[FoldClockItemView alloc] initWithTime:0];
    }
    return _secondItem;
}

@end
