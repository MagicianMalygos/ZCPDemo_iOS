//
//  SetFilletTestCell.h
//  Demo
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetFilletTestCell : UITableViewCell

@property (nonatomic, strong) UILabel *testLabel;
@property (nonatomic, strong) UIButton *testButton;
@property (nonatomic, strong) UIImageView *testImageView;

- (void)setFillet;
+ (NSString *)cellIdentifier;

@end
