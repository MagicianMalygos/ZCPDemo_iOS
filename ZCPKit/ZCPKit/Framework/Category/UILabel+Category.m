//
//  UILabel+Icon.m
//  haofang
//
//  Created by DengJinlong on 4/8/14.
//  Copyright (c) 2014 平安好房. All rights reserved.
//

#import "UILabel+Category.h"
#import "UIView+EasyFrame.h"
#import "ZCPMacros.h"

@implementation UILabel (Category)

//6.0及其以上系统调用 自定义行间距过大需要重新调整label高度
- (void)setLineSpace:(CGFloat)height{
    if (SYSTEM_VERSION < 6.0) {
        return;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:height];
    
    NSMutableAttributedString *attributedString = nil;
    if (self.attributedText != nil) {
        attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.text.length)];
        self.attributedText = attributedString;
        [self sizeToFit];
        return;
    }
    if (self.text.length > 0) {
        attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.text.length)];
        self.attributedText = attributedString;
        [self sizeToFit];
    }
}

- (void)sizeToFitWithEdge:(UIEdgeInsets)edgeInsets {
    [self sizeToFit];
    self.width = self.width + edgeInsets.right + edgeInsets.left;
    self.height = self.height + edgeInsets.top + edgeInsets.bottom;
}

@end
