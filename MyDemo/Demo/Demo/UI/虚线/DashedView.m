//
//  DashedView.m
//  Demo
//
//  Created by 朱超鹏(外包) on 17/1/12.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "DashedView.h"

@implementation DashedView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 2);
    CGContextSetLineDash(context, self.phase, self.lengths, self.count);
    
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, rect.size.width / 2, 0);
    CGContextAddLineToPoint(context, rect.size.width / 2, 50);
    CGContextAddLineToPoint(context, rect.size.width, 50);
    CGContextStrokePath(context);
    
    CGContextClosePath(context);
}

@end
