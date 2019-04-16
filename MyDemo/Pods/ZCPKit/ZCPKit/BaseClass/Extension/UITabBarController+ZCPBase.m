//
//  UITabBarController+ZCPBase.m
//  ZCPKit
//
//  Created by zcp on 2019/1/9.
//  Copyright © 2019 zcp. All rights reserved.
//

#import "UITabBarController+ZCPBase.h"

@implementation UITabBarController (ZCPBase)

- (void)setTabBarItemTitles:(NSArray *)titles normalImages:(NSArray *)normalImages selectedImages:(NSArray *)selectedImages {
    NSArray *viewControllers        = self.viewControllers;
    for (int i = 0; i < viewControllers.count; i++) {
        UIViewController *vc        = [viewControllers objectAtIndex:i];
        NSString *title             = nil;
        UIImage *normalImage        = nil;
        UIImage *selectedImage      = nil;
        
        if (i < titles.count) {
            title                   = [titles objectAtIndex:i];
        }
        if (i < normalImages.count) {
            normalImage             = [normalImages objectAtIndex:i];
        }
        if (i < selectedImages.count) {
            selectedImage           = [normalImages objectAtIndex:i];
        }
        
        if (vc.tabBarItem) {
            vc.tabBarItem.title     = title;
            vc.tabBarItem.image     = normalImage;
            vc.tabBarItem.selectedImage = selectedImage;
            vc.tabBarItem.tag       = i;
        } else {
            vc.tabBarItem           = [[UITabBarItem alloc] initWithTitle:title image:normalImage selectedImage:selectedImage];
        }
    }
    [self setViewControllers:viewControllers];
}

@end
