//
//  CALayerHelper.m
//  Demo
//
//  Created by 朱超鹏 on 2018/8/19.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "CALayerHelper.h"

@implementation CALayerHelper

IMP_SINGLETON

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    if ([layer.caDemoTag isEqualToString:@"section2_demo4_tileLayer"]) {
        //draw a thick red circle
        CGContextSetLineWidth(ctx, 10.0f);
        CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
        CGContextStrokeEllipseInRect(ctx, layer.bounds);
        
    } else if ([layer.caDemoTag isEqualToString:@"section6_demo7_tileLayer"]) {
        CATiledLayer *tileLayer = (CATiledLayer *)layer;
        
        // 从上下文获取显示区域
        CGRect bounds = CGContextGetClipBoundingBox(ctx);
        
        // 创建碎片图
        // 因为浮点值精度缺失的问题，如果使用floor下取整，会出现计算有误的情况
        // row = floor(bounds.origin.y / (tileLayer.tileSize.height / scale))
        // col = floor(bounds.origin.x / (tileLayer.tileSize.width / scale))
        CGFloat scale               = [UIScreen mainScreen].scale;
        NSDecimalNumber *boundsX    = [NSDecimalNumber decimalNumberWithString:[@(bounds.origin.x) stringValue]];
        NSDecimalNumber *boundsY    = [NSDecimalNumber decimalNumberWithString:[@(bounds.origin.y) stringValue]];
        NSDecimalNumber *width      = [NSDecimalNumber decimalNumberWithString:[@(tileLayer.tileSize.width / scale) stringValue]];
        NSDecimalNumber *height     = [NSDecimalNumber decimalNumberWithString:[@(tileLayer.tileSize.height / scale) stringValue]];
        
        NSDecimalNumber *rowNum     = [boundsY decimalNumberByDividingBy:height];
        NSDecimalNumber *colNum     = [boundsX decimalNumberByDividingBy:width];
        
        NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:0 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
        NSInteger row       = [rowNum decimalNumberByRoundingAccordingToBehavior:handler].integerValue;
        NSInteger col       = [colNum decimalNumberByRoundingAccordingToBehavior:handler].integerValue;
        
        NSString *imageName = [NSString stringWithFormat:@"Azeroth_%02li_%02li", row, col];
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"];
        UIImage *tileImage  = [UIImage imageWithContentsOfFile:imagePath];
        
        // 显示碎片图
        UIGraphicsPushContext(ctx);
        [tileImage drawInRect:bounds];
        UIGraphicsPopContext();
    } else if ([layer.caDemoTag isEqualToString:@"section14_demo1_tileLayer"]) {
        // load tile image
        NSString *imagePath     = [[NSBundle mainBundle] pathForResource:@"Azeroth" ofType:@"jpg"];
        UIImage *tileImage      = [UIImage imageWithContentsOfFile:imagePath];
        
        // draw tile
        UIGraphicsPushContext(ctx);
        [tileImage drawInRect:layer.bounds];
        UIGraphicsPopContext();
    }
}

@end

/// layer标记分类
@implementation CALayer (CADemoTag)

- (NSString *)caDemoTag {
    NSString *caDemoTag = objc_getAssociatedObject(self, "caDemoTag");
    return caDemoTag;
}

- (void)setCaDemoTag:(NSString *)caDemoTag {
    objc_setAssociatedObject(self, "caDemoTag", caDemoTag, OBJC_ASSOCIATION_COPY);
}

@end
