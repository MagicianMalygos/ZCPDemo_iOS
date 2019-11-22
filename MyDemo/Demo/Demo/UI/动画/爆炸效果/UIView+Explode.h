//
//  UIView+Explode.h
//  Demo
//
//  Created by 朱超鹏 on 2018/6/25.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UIViewExplodeDelegate;

/// 视图爆炸效果分类
@interface UIView (Explode)

/// 爆炸回调
@property (nonatomic, weak) id<UIViewExplodeDelegate> explodeDelegate;

/// 打开爆炸功能
+ (NSError *)openExplodeFunction;
/// 关闭爆炸功能
+ (void)closeExplodeFunction;;
/// 爆炸
- (void)explode;
/// 恢复到未爆炸的状态
- (void)recoverUnexplodedState;

@end

/// 爆炸回调协议
@protocol UIViewExplodeDelegate <NSObject>

/// 爆炸结束
- (void)didFinishExplode:(UIView *)view;

@end
