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
        NSInteger row = floor(bounds.origin.y / tileLayer.tileSize.height);
        NSInteger col = floor(bounds.origin.x / tileLayer.tileSize.width);
        
        NSString *imageName = [NSString stringWithFormat:@"Azeroth_%02li_%02li", row, col];
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"];
        UIImage *tileImage = [UIImage imageWithContentsOfFile:imagePath];
        
        // 显示碎片图
        UIGraphicsPushContext(ctx);
        [tileImage drawInRect:bounds];
        UIGraphicsPopContext();
        
        NSLog(@"Darw: Azeroth_%02li_%02li", row, col);
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
