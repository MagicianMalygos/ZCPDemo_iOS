//
//  UIViewElasticHelper.h
//  Demo
//
//  Created by 朱超鹏 on 2018/6/27.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 橡皮筋效果辅助类
 */
@interface UIViewElasticHelper : NSObject

/// 需要施加橡皮筋效果的view
@property (nonatomic, weak) UIView *view;

/// 橡皮筋的颜色，默认为红色
@property (nonatomic, strong) UIColor *elasticColor;
/// 生命区域，最后松手时离开该区域就会remove掉，该区域是superview所处坐标系的值，默认为superview的bounds
@property (nonatomic, assign) CGRect lifeArea;
/// 最大的拉伸长度，默认值为5倍的圆周长
@property (nonatomic, assign) CGFloat maximumStretchDistance;

@end
