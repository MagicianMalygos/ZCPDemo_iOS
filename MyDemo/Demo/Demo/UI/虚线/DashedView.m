//
//  DashedView.m
//  Demo
//
//  Created by 朱超鹏(外包) on 17/1/12.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "DashedView.h"

@interface DashedView ()

@property (nonatomic, strong) DashedModel *dashedModel;

@end

@implementation DashedView

#pragma mark - Draw Dashed
/*
 1.可设置线条首尾样式；有模糊，水平方向线宽不对
 2.可设置线条首尾样式，无模糊；水平方向线宽不对
 3.可设置连接处样式，无线宽异常
 
 参考：
 画虚线几种方法：http://www.jianshu.com/p/d64b0abef349
 CoreAnimation部分api解读：http://www.cnblogs.com/Free-Thinker/p/5117624.html
 */

// 通过 Quartz 2D 生成UIImage虚线
+ (UIView *)drawDashed1:(DashedModel *)dashedModel {
    
    /* - - - View - - - */
    UIImageView *imageView  = [[UIImageView alloc] init];
    imageView.frame         = dashedModel.dashedViewFrame;
    
    /* - - - Draw Dashed - - - */
    // 设置frame
    UIGraphicsBeginImageContext(imageView.frame.size);
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    
    // 获取当前上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 设置线条颜色
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    // 设置线宽
    CGContextSetLineWidth(context, 2);
    
    //  设置线条首尾样式()
    //  kCGLineCapButt,  无形状
    //  kCGLineCapRound, 矩形首尾样式
    //  kCGLineCapSquare 圆角首尾样式
    CGContextSetLineCap(context, kCGLineCapRound);
    
    /*
     // 虚线长度参数
     CGFloat lengths[] = {5, 10, 50, 20};
     // 设置虚线参数
     // p1：上下文；p2：在开始跳过多少长度；p3：虚线参数；p4：实虚交替使用lengths中前count个参数
     CGContextSetLineDash(context, 0, lengths, 3);
     */
    CGContextSetLineDash(context, dashedModel.phaseV, dashedModel->lengthsV, dashedModel.countV);
    
    // 起始点
    CGContextMoveToPoint(context, 0, 0);
    // 设置线的落点
    CGContextAddLineToPoint(context, imageView.width / 2, 0);
    CGContextAddLineToPoint(context, imageView.width / 2, 50);
    CGContextAddLineToPoint(context, imageView.width, 50);
    // 画线
    CGContextStrokePath(context); // CGContextDrawPath(context, kCGPathStroke);
    
    // 输出image
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束
    UIGraphicsEndImageContext();
    
    
    /* - - - Return - - - */
    imageView.image = outputImage;
    return imageView;
}

+ (UIView *)drawDashed2:(DashedModel *)dashedModel {
    
    /* - - - View - - - */
    DashedView *view        = [[DashedView alloc] initWithFrame:dashedModel.dashedViewFrame];
    view.backgroundColor    = [UIColor whiteColor];
    view.dashedModel        = dashedModel;
    
    /* - - - Draw Dashed - - - */
    [view setNeedsDisplay];
    
    /* - - - Return - - - */
    
    return view;
}
+ (UIView *)drawDashed3:(DashedModel *)dashedModel {
    
    /* - - - View - - - */
    UIView *view        = [[UIView alloc] init];
    view.frame          = dashedModel.dashedViewFrame;
    
    /* - - - Draw Dashed - - - */
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:view.bounds];
    [shapeLayer setPosition:CGPointMake(shapeLayer.bounds.size.width / 2, shapeLayer.bounds.size.height / 2)];
    // 填充颜色
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    // 画笔颜色
    [shapeLayer setStrokeColor:[UIColor redColor].CGColor];
    // 首尾样式
    [shapeLayer setLineCap:kCALineCapRound];
    // 虚线宽度
    [shapeLayer setLineWidth:5];
    // 线段连接方式
    // kCALineJoinMiter 菱角
    // kCALineJoinRound 平滑
    // kCALineJoinBevel 折线
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    NSMutableArray *pattern = @[].mutableCopy;
    int  length = sizeof(dashedModel->lengthsV) / sizeof(dashedModel->lengthsV[0]);
    for (int i = 0; i < length; i++) {
        if (dashedModel->lengthsV[i] == EOF) {
            break;
        }
        [pattern addObject:@(dashedModel->lengthsV[i])];
    }
    [shapeLayer setLineDashPattern:pattern];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, shapeLayer.bounds.size.width / 2, 0);
    CGPathAddLineToPoint(path, NULL, shapeLayer.bounds.size.width / 2, 50);
    CGPathAddLineToPoint(path, NULL, shapeLayer.bounds.size.width, 50);
    
    [shapeLayer setPath:path];
    [view.layer addSublayer:shapeLayer];
    
    CGPathRelease(path);
    /* - - - Return - - - */
    
    return view;
}

#pragma mark -

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
    CGContextSetLineDash(context, self.dashedModel.phaseV, self.dashedModel->lengthsV, self.dashedModel.countV);
    
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, rect.size.width / 2, 0);
    CGContextAddLineToPoint(context, rect.size.width / 2, 50);
    CGContextAddLineToPoint(context, rect.size.width, 50);
    CGContextStrokePath(context);
    
    CGContextClosePath(context);
}

@end
