//
//  ZCPLDTagView.m
//  Demo
//
//  Created by zcp on 2019/5/14.
//  Copyright © 2019 zcp. All rights reserved.
//

#import "ZCPLDTagView.h"

@implementation ZCPLDTagView

- (instancetype)init {
    if (self = [super init]) {
        self.font = [UIFont systemFontOfSize:14.0f];
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor blackColor];
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
    }
    return self;
}

@end
