//
//  ZCPDemoTabBar.m
//  Demo
//
//  Created by zcp on 2019/3/8.
//  Copyright © 2019 zcp. All rights reserved.
//

#import "ZCPDemoTabBar.h"

@interface ZCPDemoTabBar ()

@property (nonatomic, strong) UILabel *specialTabBarItemTitleView;
@property (nonatomic, strong) UIImageView *specialTabBarItemImageView;
@property (nonatomic, strong) UIImageView *specialView;

@end

@implementation ZCPDemoTabBar

- (void)layoutSubviews {
    [super layoutSubviews];
    int i = 0;
    for (UIControl *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton addTarget:self action:@selector(clickTabBarButton:) forControlEvents:UIControlEventTouchUpInside];
            tabBarButton.tag = i++;
        }
    }
}

- (void)clickTabBarButton:(UIControl *)tabBarButton {
    int index = tabBarButton.tag;
    NSArray *gifArr = @[@"tabbar_home_gif", @"tabbar_job_gif", @"", @"tabbar_top_gif", @"tabbar_my_gif"];
    
    if (index == 2) {
        for (UIImageView *imageView in tabBarButton.subviews) {
            if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
                self.specialTabBarItemImageView = imageView;
                self.specialTabBarItemImageView.hidden = YES;
                
                self.specialView = [[UIImageView alloc] init];
                self.specialView.image = [UIImage imageNamed:@"tabbar_agent_selected"];
                self.specialView.frame = imageView.bounds;
                self.specialView.center = CGPointMake(tabBarButton.width / 2, tabBarButton.height / 2);
                [tabBarButton addSubview:self.specialView];
                
                [UIView animateWithDuration:0.25 animations:^{
                    self.specialView.transform = CGAffineTransformMakeScale(1.5, 1.5);
                }];
            }
            if ([imageView isKindOfClass:NSClassFromString(@"UITabBarButtonLabel")]) {
                self.specialTabBarItemTitleView = imageView;
                self.specialTabBarItemTitleView.hidden = YES;
            }
        }
    } else {
        [self.specialView removeFromSuperview];
        self.specialTabBarItemImageView.hidden = NO;
        self.specialTabBarItemTitleView.hidden = NO;
        
        for (UIImageView *imageView in tabBarButton.subviews) {
            if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
                
                NSMutableArray *frames = [[NSMutableArray alloc] init];
                
//                if (index == 1) {
//                    for (int i = 0; i < 16; i++) {
//                        NSString *imageName = [NSString stringWithFormat:@"职位_000%02d", i];
//                        UIImage *frameImage = [UIImage imageNamed:imageName];
//                        [frames addObject:frameImage];
//                    }
//                } else {
                    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:gifArr[index] withExtension:@"gif"];
                    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef) fileUrl, NULL);
                    size_t frameCout = CGImageSourceGetCount(gifSource);
                    
                    for (size_t i = 0; i < frameCout; i++) {
                        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
                        UIImage *imageName = [UIImage imageWithCGImage:imageRef];
                        [frames addObject:imageName];
                        CGImageRelease(imageRef);
                    }
//                }
                
                UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:imageView.bounds];
                gifImageView.animationImages = frames;
                gifImageView.animationDuration = 0.5;
                gifImageView.animationRepeatCount = 1;
                [gifImageView startAnimating];
                [imageView addSubview:gifImageView];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [gifImageView removeFromSuperview];
                });
            }
        }
    }
}

@end
