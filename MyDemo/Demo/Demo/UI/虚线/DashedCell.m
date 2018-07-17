//
//  DashedCell.m
//  Demo
//
//  Created by 朱超鹏 on 2017/10/10.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "DashedCell.h"

@implementation DashedCell

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id<ZCPTableViewCellItemBasicProtocol>)object {
    return 150;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        
        _dashedView = [[DashedView alloc] init];
        [self.contentView addSubview:_dashedView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.dashedView.frame = self.bounds;
}

- (void)setObject:(DashedCellItem *)object {
    if (object && self.object != object) {
        [super setObject:object];
        [self.dashedView configureWithModel:object.model];
    }
}

@end

@implementation DashedCellItem

- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [DashedCell class];
        self.cellType = @"DashedCell";
    }
    return self;
}

@end
