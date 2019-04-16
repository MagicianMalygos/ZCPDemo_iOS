//
//  ZCPTableViewCell.m
//  ZCPUIKit
//
//  Created by zcp on 16/1/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewCell.h"
#import "ZCPCategory.h"
#import "ZCPGlobal.h"

/*
    方法执行顺序 tableView:rowHeightForObject: -> setupContentView -> setObject: ->layoutSubViews
               返回cell高度                       初始化子视图         设置属性       设置frame
 */

@interface ZCPTableViewCell ()

/// 上边线
@property (nonatomic, strong) UIView *topLine;
/// 下边线
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation ZCPTableViewCell

// ----------------------------------------------------------------------
#pragma mark - 返回cell高度
// ----------------------------------------------------------------------
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id<ZCPTableViewCellItemBasicProtocol>)object {
    if (object && [object conformsToProtocol:@protocol(ZCPTableViewCellItemBasicProtocol)] && [object respondsToSelector:@selector(cellHeight)]) {
        return [object.cellHeight floatValue];
    }
    return 0;
}

// ----------------------------------------------------------------------
#pragma mark - instancetype
// ----------------------------------------------------------------------
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType  = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 设置默认背景色为透明
        [self clearBackgroundColor];
        
        // 初始化contentView
        [self setupContentView];
    }
    return self;
}

// ----------------------------------------------------------------------
#pragma mark - setup
// ----------------------------------------------------------------------
- (void)setupContentView {
    // setup pro
    self.accessoryType              = UITableViewCellAccessoryNone;
    self.selectionStyle             = UITableViewCellSelectionStyleNone;
    self.clipsToBounds              = NO;
    self.contentView.clipsToBounds  = NO;
    
    // 清除背景色
    [self clearBackgroundColor];
    
    // 添加上下边线
    [self addSubview:self.topLine];
    [self addSubview:self.bottomLine];
}

- (void)setObject:(id<ZCPTableViewCellItemBasicProtocol>)object {
    _object = object;
}

// ----------------------------------------------------------------------
#pragma mark - layout
// ----------------------------------------------------------------------
- (void)layoutSubviews {
    [super layoutSubviews];
    // 设置cell背景颜色
    if (self.object.cellBgColor) {
        self.customBackgroundColor = self.object.cellBgColor;
    }
    
    // 设置上边线
    self.topLine.hidden = !self.object.showTopLine;
    if (self.object.showTopLine) {
        self.topLine.frame = CGRectMake(self.object.topLineOffset, 0, self.object.topLineLength, OnePixel);
        if (self.object.topLineColor) {
            self.topLine.backgroundColor = self.object.topLineColor;
        }
        [self bringSubviewToFront:self.topLine];
    }
    // 设置下边线
    self.bottomLine.hidden = !self.object.showBottomLine;
    if (self.object.showBottomLine) {
        self.bottomLine.frame = CGRectMake(self.object.bottomLineOffset, self.height - OnePixel, self.object.bottomLineLength, OnePixel);
        if (self.object.bottomLineColor) {
            self.bottomLine.backgroundColor = self.object.bottomLineColor;
        }
        [self bringSubviewToFront:self.bottomLine];
    }
    
    // 设置bgView frame
    self.selectedBackgroundView.frame = self.bounds;
}

// ----------------------------------------------------------------------
#pragma mark - 返回cell的重用标识
// ----------------------------------------------------------------------
+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

// ----------------------------------------------------------------------
#pragma mark - getters and setters
// ----------------------------------------------------------------------

- (UIView *)topLine {
    if (!_topLine) {
        _topLine = [[UIView alloc] init];
        _topLine.backgroundColor = [UIColor colorFromHexRGB:@"dfdfdf"];
    }
    return _topLine;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor colorFromHexRGB:@"dfdfdf"];
    }
    return _bottomLine;
}

@end
