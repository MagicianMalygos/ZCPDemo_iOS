//
//  UITabBarController+ZCPBase.h
//  ZCPKit
//
//  Created by zcp on 2019/1/9.
//  Copyright © 2019 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 UITabBarController基类扩展
 */
@interface UITabBarController (ZCPBase)

/**
 设置TabBarItem的title、NormalImage、SelectedImage
 
 @param titles         标题数组
 @param normalImages   正常显示图数组
 @param selectedImages 选中显示图数组
 */
- (void)setTabBarItemTitles:(NSArray *)titles normalImages:(NSArray *)normalImages selectedImages:(NSArray *)selectedImages;

@end

NS_ASSUME_NONNULL_END
