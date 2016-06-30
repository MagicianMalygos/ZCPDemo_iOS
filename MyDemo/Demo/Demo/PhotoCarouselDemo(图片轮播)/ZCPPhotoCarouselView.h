//
//  ZCPPhotoCarouselView.h
//  Demo
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>

//点击图片的Block回调，参数当前图片的索引，也就是当前页数
typedef void(^TapImageViewBlock)(NSInteger imageIndex);

@interface ZCPPhotoCarouselView : UIView

@property (nonatomic, strong) NSArray *imageNameArray;              // 图片数组
@property (nonatomic, assign) CGFloat scrollInterval;               // 切换图片的时间间隔，可选，默认为3s
@property (nonatomic, assign) CGFloat animationInterval;            // 图片移动的时间,可选，默认为0.7s
@property (nonatomic, copy) NSString *placeholderImageName;         // 默认图片

#pragma mark - instancetype
+ (instancetype)photoCarouselViewWithFrame: (CGRect) frame;
- (instancetype)initWithFrame: (CGRect)frame;

#pragma mark - Image Config
// 为每个图片添加点击事件
- (void) addTapEventForImageWithBlock:(TapImageViewBlock) block;

@end
