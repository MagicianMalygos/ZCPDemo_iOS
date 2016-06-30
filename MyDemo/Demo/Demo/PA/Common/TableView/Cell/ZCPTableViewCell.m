//
//  ZCPTableViewCell.m
//  Apartment
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewCell.h"

@implementation ZCPTableViewCell

#pragma mark - synthesize
@synthesize object  = _object;

#pragma mark - instancetype
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //设置空白透明
        [self clearBackgroundColor];
        
        [self setupContentView];
    }
    return self;
}

#pragma mark - Setup Cell
- (void)setupContentView {
}
- (void)setObject:(NSObject *)object {
    _object = object;
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    return 44.0f;
}

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

@end
