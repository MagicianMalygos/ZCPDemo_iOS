//
//  DashedView.h
//  Demo
//
//  Created by 朱超鹏(外包) on 17/1/12.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DashedModel.h"

@interface DashedView : UIView

+ (UIView *)drawDashed1:(DashedModel *)dashedModel;
+ (UIView *)drawDashed2:(DashedModel *)dashedModel;
+ (UIView *)drawDashed3:(DashedModel *)dashedModel;

@end
