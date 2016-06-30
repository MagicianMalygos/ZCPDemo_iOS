//
//  UIButton+Category.h
//  Apartment
//
//  Created by apple on 16/2/2.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Category)

// 设置圆形，要在设置frame之后设置
- (void)changeToRound;
// 设置圆角，要在设置frame之后设置
- (void)changeToFillet;

@end
