//
//  UIView+Elastic.m
//  Demo
//
//  Created by 朱超鹏 on 2018/6/27.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "UIView+Elastic.h"
#import <objc/runtime.h>

@implementation UIView (Elastic)

- (UIViewElasticHelper *)elasticHelper {
    UIViewElasticHelper *elasticHelper = objc_getAssociatedObject(self, @selector(elasticHelper));
    return elasticHelper;
}

- (void)setElasticHelper:(UIViewElasticHelper *)elasticHelper {
    if (elasticHelper.view && elasticHelper.view != self) {
        elasticHelper.view.elasticHelper = nil;
    }
    elasticHelper.view = self;
    objc_setAssociatedObject(self, @selector(elasticHelper), elasticHelper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
