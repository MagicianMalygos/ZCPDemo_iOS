//
//  UIScrollView+ExtraMethod.h
//  haofang
//
//  Created by leo on 14-9-10.
//  Copyright (c) 2014年 平安好房. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (ExtraMethod)

- (BOOL)reachToEnd;

// below two convient method can apply to UICollectionView
- (NSInteger)calculatedIndex;
- (CGRect)visibleRect;
@end
