//
//  ZCPSectionCell.m
//  Apartment
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPSectionCell.h"

#pragma mark - Section Cell
@implementation ZCPSectionCell

#pragma mark - synthesize
@synthesize sectionTitleLabel   = _sectionTitleLabel;

/**
 *  cell的初始化方法
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setCustomBackgroundColor:[UIColor clearColor]];
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _sectionTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, SCREENWIDTH - 20, 0)];
        _sectionTitleLabel.textColor = [UIColor blackColor];
        _sectionTitleLabel.backgroundColor = [UIColor clearColor];
        _sectionTitleLabel.numberOfLines = 1;
        [self.contentView addSubview:_sectionTitleLabel];
    }
    return self;
}

#pragma mark - getter / setter
- (void)setObject:(id)object {
    if ([object isKindOfClass:[ZCPSectionCellItem class]] && self.item != object) {
        
        self.item = (ZCPSectionCellItem *)object;
        ZCPSectionCellItem *item = (ZCPSectionCellItem *)object;
        
        // 更新数据
        if (![item.sectionAttrTitle length]) {
            _sectionTitleLabel.font = item.font;
            _sectionTitleLabel.text = item.sectionTitle;
            CGSize size = [item.sectionTitle boundingRectWithSize:CGSizeMake(SCREENWIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil].size;
            _sectionTitleLabel.frame = CGRectMake(_sectionTitleLabel.origin.x, _sectionTitleLabel.origin.y, _sectionTitleLabel.frame.size.width, size.height);
        }
        else {
            _sectionTitleLabel.attributedText = item.sectionAttrTitle;
            CGSize size = [item.sectionAttrTitle boundingRectWithSize:CGSizeMake(SCREENWIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            _sectionTitleLabel.frame = CGRectMake(_sectionTitleLabel.origin.x, _sectionTitleLabel.origin.y, _sectionTitleLabel.width, size.height);
        }
        
    }
}
/**
 *  获取cell高度
 */
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    CGFloat height = 0;
    if ([object conformsToProtocol:@protocol(ZCPTableViewCellItemBasicProtocol)]
        && [object respondsToSelector:@selector(cellHeight)]) {
        if ([(ZCPDataModel *)object cellHeight]) {
            height = [[(ZCPDataModel *)object cellHeight] floatValue];
        }
        else {
            ZCPSectionCellItem *item = (ZCPSectionCellItem *)object;
            CGSize size = [item.sectionTitle boundingRectWithSize:CGSizeMake(SCREENWIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil].size;
            return size.height + 20;
        }
    }
    return height;
}
#pragma mark - layoutSubviews
- (void)layoutSubviews {
    [super layoutSubviews];
    UIEdgeInsets insets = [(ZCPSectionCellItem *)self.item titleEdgeInset];
    if (UIEdgeInsetsEqualToEdgeInsets(insets, UIEdgeInsetsZero)) {
        self.sectionTitleLabel.frame = CGRectMake(8, insets.top, self.width - 8 * 2, self.height - insets.top - insets.bottom);
    }
    else {
        self.sectionTitleLabel.frame = CGRectMake(insets.left, insets.top, self.width - insets.left - insets.right, self.height - insets.top - insets.bottom);
    }
    
    self.backgroundColor = [UIColor clearColor];
}

@end

#pragma mark - Section CellItem
@implementation ZCPSectionCellItem

#pragma mark - synthesize
@synthesize sectionTitle        = _sectionTitle;
@synthesize sectionAttrTitle    = _sectionAttrTitle;
@synthesize font                = _font;
@synthesize titleEdgeInset      = _titleEdgeInset;

#pragma mark - instancetype
- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [ZCPSectionCell class];
        self.cellType = [ZCPSectionCell cellIdentifier];
        self.font = [UIFont defaultFontWithSize:14.0f];
        self.titleEdgeInset = UIEdgeInsetsZero;
    }
    return self;
}
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPSectionCell class];
        self.cellType = [ZCPSectionCell cellIdentifier];
        self.font = [UIFont defaultFontWithSize:14.0f];
        self.titleEdgeInset = UIEdgeInsetsZero;
        self.cellHeight = @20;
    }
    return self;
}
- (instancetype)copyWithZone:(NSZone *)zone {
    ZCPSectionCellItem *item = [[ZCPSectionCellItem alloc] init];
    item.cellClass = [self cellClass];
    item.cellHeight = [self cellHeight];
    item.cellType = [self cellType];
    item.sectionTitle = self.sectionTitle;
    item.titleEdgeInset = self.titleEdgeInset;
    item.font = self.font;
    return item;
}

@end
