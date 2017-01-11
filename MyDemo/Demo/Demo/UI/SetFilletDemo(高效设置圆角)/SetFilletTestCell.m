//
//  SetFilletTestCell.m
//  Demo
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "SetFilletTestCell.h"
#import "AYViewCorner.h"

@implementation SetFilletTestCell

#pragma mark - synthesize
@synthesize testLabel = _testLabel;
@synthesize testButton = _testButton;
@synthesize testImageView = _testImageView;

#pragma mark - instancetype
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupContentView];
    }
    return self;
}
+ (NSString *)cellIdentifier {
    return NSStringFromClass(self);
}

#pragma mark - setup
- (void)setupContentView {
    [self.contentView addSubview:self.testLabel];
    [self.contentView addSubview:self.testButton];
    [self.contentView addSubview:self.testImageView];
}

- (void)setFillet {
    // 不触发离屏渲染的情况下设置圆角
    // http://ayjkdev.top/2016/04/05/corner-radius-with-out-offscreen-rendered/
    // https://github.com/AYJk/AYViewCorner
    // 在设置前必须先设置好backgroundColor，或需使用下面的方法同时设置颜色和圆角；imageView要使用下面的方法同时设置image和圆角。
    // 当需要改变backgroundColor或image时需要重新使用下面的方法设置一遍，方法使用有一定的局限性。
    [self.testLabel ay_setCornerRadius:AYRadiusMake(10, 10, 10, 10) backgroundColor:[UIColor orangeColor]];
    [self.testButton ay_setCornerRadius:AYRadiusMake(10, 10, 10, 10) backgroundColor:[UIColor orangeColor]];
    [self.testImageView ay_setCornerRadius:AYRadiusMake(10, 10, 10, 10) backgroundColor:[UIColor orangeColor]];
}

#pragma mark - getter / setter
- (UILabel *)testLabel {
    if (_testLabel == nil) {
        _testLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 50, 34)];
    }
    return _testLabel;
}
- (UIButton *)testButton {
    if (_testButton == nil) {
        _testButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _testButton.frame = CGRectMake(100, 8, 100, 34);
    }
    return _testButton;
}
- (UIImageView *)testImageView {
    if (_testImageView == nil) {
        _testImageView = [[UIImageView alloc] initWithFrame:CGRectMake(250, 8, 34, 34)];
    }
    return _testImageView;
}

@end
