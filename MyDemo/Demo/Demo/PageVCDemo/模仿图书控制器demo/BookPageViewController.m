//
//  BookPageViewController.m
//  Demo
//
//  Created by 朱超鹏 on 2017/6/12.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "BookPageViewController.h"

@interface BookPageViewController ()

@property (nonatomic, strong) UIScrollView *scrollContainer;
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation BookPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollContainer.frame  = CGRectMake(0, 64, self.view.width, self.view.height - 64);
    self.textLabel.frame        = CGRectMake(0, 0, self.view.width, self.view.height - 64);
    [self.view addSubview:self.scrollContainer];
    [self.scrollContainer addSubview:self.textLabel];
    
    self.scrollContainer.contentOffset = CGPointMake(0, 0);
}

#pragma mark - public

- (void)setText:(NSString *)text {
    self.textLabel.text     = text;
    CGFloat textHeight      = [self.textLabel.text boundingRectWithSize:CGSizeMake(self.textLabel.width, MAXFLOAT)
                                                                options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                                             attributes:@{NSFontAttributeName: self.textLabel.font}
                                                                context:nil].size.height;
    
    CGRect frame            = self.textLabel.frame;
    frame.size.height       = textHeight;
    self.textLabel.frame    = frame;
    
    self.scrollContainer.contentSize = frame.size;
    self.scrollContainer.contentOffset = CGPointMake(0, 0);
}

#pragma mark - getter / setter

- (UIScrollView *)scrollContainer {
    if (!_scrollContainer) {
        _scrollContainer = [[UIScrollView alloc] init];
        _scrollContainer.showsHorizontalScrollIndicator = NO;
        _scrollContainer.showsVerticalScrollIndicator = NO;
        _scrollContainer.bounces = YES;
    }
    return _scrollContainer;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel                  = [[UILabel alloc] init];
        _textLabel.font             = [UIFont systemFontOfSize:20.0f];
        _textLabel.textColor        = [UIColor blackColor];
        _textLabel.numberOfLines    = 0;
    }
    return _textLabel;
}

@end
