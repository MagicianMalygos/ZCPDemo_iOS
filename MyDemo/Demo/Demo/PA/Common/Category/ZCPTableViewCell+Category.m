//
//  ZCPTableViewCell+Category.m
//  Apartment
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewCell+Category.h"

@implementation ZCPTableViewCell (Category)

- (void)clearBackgroundColor {
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    backgroundView.backgroundColor = [UIColor clearColor];
    
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView = backgroundView;
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setCustomBackgroundColor:(UIColor *)color {
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    backgroundView.backgroundColor = color;
    self.backgroundColor = color;
    self.backgroundView = backgroundView;
    self.contentView.backgroundColor = color;
}

@end
