//
//  ZCPRoundCell.m
//  Apartment
//
//  Created by apple on 16/4/15.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRoundCell.h"

@implementation ZCPRoundCell

// ----------------------------------------------------------------------
#pragma mark - synthesize
// ----------------------------------------------------------------------
@synthesize roundContentView = _roundContentView;

// ----------------------------------------------------------------------
#pragma mark - 返回cell高度
// ----------------------------------------------------------------------
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id<ZCPTableViewCellItemBasicProtocol>)object {
    return 100;
}

// ----------------------------------------------------------------------
#pragma mark - setup cell
// ----------------------------------------------------------------------
- (void)setupContentView {
    self.roundContentView = [[UIView alloc] init];
    
    self.roundContentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.roundContentView];
}

- (void)setObject:(ZCPCellDataModel *)object {
    if (object) {
        self.object = (ZCPCellDataModel *)object;
    }
}

// ----------------------------------------------------------------------
#pragma mark - layout
// ----------------------------------------------------------------------
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.roundContentView.frame = CGRectMake(8, 8, APPLICATIONWIDTH - 8 * 2, self.contentView.height - 8 * 2);
    self.roundContentView.layer.masksToBounds = YES;
    self.roundContentView.layer.cornerRadius = 5.0;
}

@end
