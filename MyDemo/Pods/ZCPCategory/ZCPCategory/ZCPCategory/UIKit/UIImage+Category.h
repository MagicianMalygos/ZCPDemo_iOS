//
//  UIImage+Category.h
//  ZCPCategory
//
//  Created by zcp on 2019/5/16.
//  Copyright © 2019 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Category)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color radiu:(CGFloat)radiu;

@end

NS_ASSUME_NONNULL_END
