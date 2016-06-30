//
//  SetFilletTestCell.m
//  Demo
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "SetFilletTestCell.h"

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
    
    // 设置圆角
    [self setLabelFillet:self.testLabel];
    [self setButtonFillet:self.testButton];
    [self setImageViewFillet:self.testImageView];
}

#pragma mark - getter / setter
- (UILabel *)testLabel {
    if (_testLabel == nil) {
        _testLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 50, 34)];
        _testLabel.backgroundColor = [UIColor redColor];
    }
    return _testLabel;
}
- (UIButton *)testButton {
    if (_testButton == nil) {
        _testButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _testButton.frame = CGRectMake(100, 8, 100, 34);
        _testButton.backgroundColor = [UIColor greenColor];
    }
    return _testButton;
}
- (UIImageView *)testImageView {
    if (_testImageView == nil) {
        _testImageView = [[UIImageView alloc] initWithFrame:CGRectMake(250, 8, 34, 34)];
        _testImageView.backgroundColor = [UIColor blueColor];
    }
    return _testImageView;
}




#pragma mark - Set Fillet
#define Radius    10
- (void)setLabelFillet:(UILabel *)label {
    // 低效
//    label.layer.cornerRadius = Radius;
//    label.layer.masksToBounds = YES;
    
    // 高效
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(0, 0), NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 0, 0);
//    CGContextAddArcToPoint(context, <#CGFloat x1#>, <#CGFloat y1#>, <#CGFloat x2#>, <#CGFloat y2#>, Radius);
    
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *filletBGView = [[UIImageView alloc] initWithImage:output];
    [label insertSubview:filletBGView atIndex:0];
}
- (void)setButtonFillet:(UIButton *)button {
    button.layer.cornerRadius = Radius;
}
- (void)setImageViewFillet:(UIImageView *)imageView {
    imageView.layer.cornerRadius = Radius;
    imageView.layer.masksToBounds = YES;
}

@end
