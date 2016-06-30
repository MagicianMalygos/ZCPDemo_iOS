//
//  ZCPNavigationController.m
//  Apartment
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import "ZCPNavigationController.h"

@interface ZCPNavigationController ()

@end

@implementation ZCPNavigationController

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return (gestureRecognizer == self.interactivePopGestureRecognizer);
}

@end
