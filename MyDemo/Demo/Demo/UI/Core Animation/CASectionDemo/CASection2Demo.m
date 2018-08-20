//
//  CASection2Demo.m
//  Demo
//
//  Created by 朱超鹏 on 2018/8/9.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "CASection2Demo.h"
#import "CALayerHelper.h"

@implementation CASection2Demo

// ----------------------------------------------------------------------
#pragma mark - demo
// ----------------------------------------------------------------------

#pragma mark 通过设置寄宿图来显示一张图片
- (void)demo1 {
    CALayer *imageLayer         = [CALayer layer];
    imageLayer.frame            = CGRectMake(0, 0, 200, 200);
    imageLayer.position         = self.center;
    imageLayer.borderWidth      = 0.5;
    imageLayer.borderColor      = [UIColor blueColor].CGColor;
    
    // 设置寄宿图
    // contents是id类型，原因是Mac OS系统上，该属性对CGImage和NSImage类型的值都起作用
    imageLayer.contents         = (__bridge id _Nullable)([UIImage imageNamed:@"earth"].CGImage);
    
    // UIView的contentMode属性与之对应
    imageLayer.contentsGravity  = kCAGravityResize;
    
    // 定义寄宿图的像素尺寸和视图大小的比例
    // 如果contentsGravity设置了Resize相关的属性，则设置了contentsScale也没什么作用
    imageLayer.contentsScale    = [UIScreen mainScreen].scale;
    
    // UIView的clipsToBounds与之对应
    // 当view的clipsToBounds属性设置为YES时，其根layer的masksToBounds也会变成YES
    imageLayer.masksToBounds    = YES;
    
    [self.layer addSublayer:imageLayer];
}

#pragma mark 使用contentRect属性实现图片拼合（image sprites）
- (void)demo2 {
    // read setting
    NSDictionary *settingArr = @{@"name": @"legendary swords",
                                 @"fileName": @"swords",
                                 @"size": @"{650, 674}",
                                 @"sections": @[@{@"begin": @"{93, 0}",
                                                  @"end": @"{193, 674}",
                                                  @"size": @"{100, 674}"},
                                                @{@"begin": @"{192, 0}",
                                                  @"end": @"{304, 674}",
                                                  @"size": @"{112, 674}}"},
                                                @{@"begin": @"{303, 0}",
                                                  @"end": @"{383, 674}",
                                                  @"size": @"{80, 674}"},
                                                @{@"begin": @"{381, 0}",
                                                  @"end": @"{466, 674}",
                                                  @"size": @"{85, 674}"},
                                                @{@"begin": @"{463, 0}",
                                                  @"end": @"{553, 674}",
                                                  @"size": @"{90, 674}"}
                                                ]
                                 };
    
    CGSize imageSize    = CGSizeFromString(settingArr[@"size"]);
    NSArray *sections   = settingArr[@"sections"];
    NSString *fileName  = settingArr[@"fileName"];
    
    // generate and render
    for (int i = 0; i < sections.count; i++) {
        NSDictionary *section   = sections[i];
        CGPoint beginPoint      = CGPointFromString(section[@"begin"]);
        CGSize size             = CGSizeFromString(section[@"size"]);
        
        CGFloat x = beginPoint.x / imageSize.width;
        CGFloat y = beginPoint.y / imageSize.height;
        CGFloat w = size.width / imageSize.width;
        CGFloat h = size.height / imageSize.height;
        
        CALayer *swordLayer         = [CALayer layer];
        swordLayer.frame            = CGRectMake(self.width/sections.count * i, 0, self.width/sections.count, 240);
        swordLayer.contents         = (__bridge id _Nullable)([UIImage imageNamed:fileName].CGImage);
        swordLayer.contentsRect     = CGRectMake(x, y, w, h);
        swordLayer.contentsGravity  = kCAGravityResizeAspect;
        [self.layer addSublayer:swordLayer];
    }
}

#pragma mark 使用contentsCenter属性拉伸图片
- (void)demo3 {
    CALayer *layer          = [CALayer layer];
    layer.frame             = CGRectMake(0, 0, 200, 200);
    layer.position          = self.center;
    layer.contents          = (__bridge id _Nullable)[UIImage imageNamed:@"colorbox"].CGImage;
    layer.contentsGravity   = kCAGravityResize;
    
    // 拉伸图像时，根据如下的矩形范围去拉伸
    // 该矩形范围是一个比例值，每个值取值范围为[0, 1]
    // 它工作起来的效果和UIImage里的resizableImageWithCapInsets: 方法效果非常类似，但是它可以运用到任何寄宿图，甚至包括在Core Graphics运行时绘制的图形。
    // 它可以在Interface Builder里面的stretching里进行配置
    layer.contentsCenter    = CGRectMake(0.25, 0.25, 0.5, 0.5);
    
    [self.layer addSublayer:layer];
}

#pragma mark CALayerDelegate
- (void)demo4 {
    CALayer *layer          = [CALayer layer];
    layer.frame             = CGRectMake(0, 0, 200, 200);
    layer.position          = self.center;
    layer.backgroundColor   = [UIColor blueColor].CGColor;
    
    // 1.当delegate设置为self（也即layer所属的view），会直接crash。原因未知，猜测可能UIView和CALayer之间的代理关系是一对一的关系
    // 2.当delegate设置为ViewController时，在ViewController出栈时会crash。如果在控制器出栈时将此delegate置为nil，则不会crash。原因未知。
    // 所以CALayerDelegate在使用时尽量不要用，如使用要尽量小心。
    layer.delegate          = [CALayerHelper sharedInstance];
    layer.caDemoTag         = @"section2_demo4_tileLayer";
    [self.layer addSublayer:layer];
    
    // 设置需要重绘
    [layer setNeedsDisplay];
}


// ----------------------------------------------------------------------
#pragma mark - CALayerDelegate
// ----------------------------------------------------------------------
/*
// 当需要被重绘时，CALayer会请求它的代理给他一个寄宿图来显示
- (void)displayLayer:(CALayer *)layer {
}

// 如果displayLayer:方法未实现，则会调用该方法
// 此方法调用之前，CALayer创建了一个合适尺寸的空寄宿图（尺寸由bounds和contentsScale决定）和一个Core Graphics的绘制上下文环境，为绘制寄宿图做准备
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    //draw a thick red circle
    CGContextSetLineWidth(ctx, 10.0f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}
 */

@end
