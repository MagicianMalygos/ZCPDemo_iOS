//
//  DashedView.h
//  Demo
//
//  Created by 朱超鹏(外包) on 17/1/12.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashedView : UIView

@property (nonatomic, assign) float phase;
@property (nonatomic, assign) CGFloat *lengths;
@property (nonatomic, assign) float count;

@end
