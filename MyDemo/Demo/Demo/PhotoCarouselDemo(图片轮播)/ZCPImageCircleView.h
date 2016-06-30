//
//  ZCPImageCircleView.h
//  Demo
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZCPImageCircleViewDelegate;

#pragma mark - ZCPImageCircleView
@interface ZCPImageCircleView : UIView

@property (nonatomic, strong) NSArray *imageNameArray;                  // 图片名数组
@property (nonatomic, assign, readonly) NSUInteger pageCount;           // 页数
@property (nonatomic, assign, readonly) NSUInteger currentPage;         // 当前页
@property (nonatomic, assign) BOOL disableCycle;                        // 禁止循环
@property (nonatomic, weak) id<ZCPImageCircleViewDelegate> delegate;    // delegate

- (void)reloadData;

@end

#pragma mark - collection cell
typedef void(^ZCPImageViewClickBlock)(UIImageView *imageView);
@interface ZCPImageCircleCollectionCell : UICollectionViewCell

@property (nonatomic, copy) ZCPImageViewClickBlock imageViewClickBlock;

// cell重用标识
+ (NSString *)cellReuseIdentifier;
// 使用imageURLString更新ImageView
- (void)updateImageViewWithImageURLString:(NSString *)URLString imageViewClickBlock:(ZCPImageViewClickBlock) imageViewClickBlock;

@end

#pragma mark - Delegate
@protocol ZCPImageCircleViewDelegate <NSObject>

@optional
/** 图片点击事件 */
- (void)pageView:(ZCPImageCircleView *)imageCircleView didSelectedPageAtIndex:(NSUInteger)index;
/** 页面切换时调用 */
- (void)pageView:(ZCPImageCircleView *)imageCircleView didChangeToIndex:(NSUInteger)index;

@end

