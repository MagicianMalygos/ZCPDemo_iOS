//
//  TipsView.h
//  Demo
//
//  Created by apple on 16/6/2.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipsView : UIView

@property (nonatomic, strong) UIView *firstTipView;
@property (nonatomic, strong) UIView *secondTipView;

- (instancetype)initWithFrame:(CGRect)frame circleFrame:(CGRect)circleRect;

@end
