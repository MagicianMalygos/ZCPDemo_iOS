//
//  UIScrollView+ExtraMethod.m
//  haofang
//
//  Created by leo on 14-9-10.
//  Copyright (c) 2014年 平安好房. All rights reserved.
//

#import "UIScrollView+ExtraMethod.h"

@implementation UIScrollView (ExtraMethod)

- (BOOL)reachToEnd
{
    if (self.contentOffset.y + CGRectGetHeight(self.bounds) >= self.contentSize.height) {
        return YES;
    } else {
        return NO;
    }
}

/**
 *  Calculates the index based on the offset and the visible rect.
 */

- (NSInteger)calculatedIndex
{
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat offset = self.contentOffset.x;
    CGFloat index = offset/width;
    return index;
}

/**
 *  Calculates the visible rectangle of the collection view.
 */

- (CGRect)visibleRect
{
    CGRect visibleRect =  CGRectZero;
    visibleRect.size = self.bounds.size;
    visibleRect.origin = self.contentOffset;
    
    return visibleRect;
}

@end
