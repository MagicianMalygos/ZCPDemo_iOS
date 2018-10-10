//
//  InternationalizationDemoHomeController.m
//  Demo
//
//  Created by 朱超鹏 on 2017/6/16.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "InternationalizationDemoHomeController.h"

@interface InternationalizationDemoHomeController ()

@end

@implementation InternationalizationDemoHomeController

- (void)loadView {
    [super loadView];
    [self test];
}

- (void)test {
    NSLog(@"%@",NSLocalizedString(@"tabbar_home", nil));
    NSLog(@"%@",NSLocalizedString(@"tabbar_map", nil));
    NSLog(@"%@",NSLocalizedString(@"tabbar_message", nil));
    NSLog(@"%@",NSLocalizedString(@"tabbar_my", nil));
    
    UIImageView *imageView  = [[UIImageView alloc] init];
    imageView.frame         = CGRectMake(100, 100, 72, 48);
    imageView.image         = [UIImage imageNamed:@"flag"];
    [self.view addSubview:imageView];
}

@end
