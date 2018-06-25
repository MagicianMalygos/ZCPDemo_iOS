//
//  UIView+Explode.h
//  Demo
//
//  Created by 朱超鹏 on 2018/6/25.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UIViewExplodeDelegate;

/// 爆炸效果分类
@interface UIView (Explode)

/// 爆炸回调
@property (nonatomic, weak) id<UIViewExplodeDelegate> explodeDelegate;

#pragma mark - setup

/**
 打开爆炸功能
 */
+ (NSError *)openExplodeFunction;

/**
 关闭爆炸功能
 */
+ (void)closeExplodeFunction;;

#pragma mark - function

/**
 爆炸
 */
- (void)explode;

/**
 恢复到未爆炸的状态
 */
- (void)recoverUnexplodedState;

@end

/// Protocol
@protocol UIViewExplodeDelegate <NSObject>

/**
 爆炸结束
 */
- (void)didFinishExplode:(UIView *)view;

@end
