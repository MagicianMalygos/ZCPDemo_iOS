//
//  UIButton+Category.h
//  UnitTestDemo
//
//  Created by apple on 16/4/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Category)

- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType;

- (void)verticalImageAndTitle:(CGFloat)spacing;

@end
