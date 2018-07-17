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


#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor greenColor].CGColor;
        self.layer.borderWidth = 1;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self draw];
}

#pragma mark - public

- (void)configureWithModel:(DashedModel *)model {
    self.dashedModel = model.copy;
    [self draw];
}

#pragma mark - Draw Dashed

- (void)draw {
    if (self.dashedModel.type == DashedType1) {
        [self drawDashed1];
    } else if (self.dashedModel.type == DashedType2) {
        [self drawDashed2];
    }
}

- (void)drawDashed1 {
    [self.layer removeAllSublayers];
    
    CAShapeLayer *dashedLayer   = [CAShapeLayer layer];
    dashedLayer.frame           = self.bounds;
    dashedLayer.anchorPoint     = CGPointZero;
    dashedLayer.position        = CGPointZero;
    
    // 线宽
    dashedLayer.lineWidth       = self.dashedModel.lineWidth;
    // 填充色
    dashedLayer.fillColor       = NULL;
    // 画笔颜色
    dashedLayer.strokeColor     = self.dashedModel.lineColor.CGColor;
    // 首尾样式
    dashedLayer.lineCap         = kCALineCapRound;
    // 线段连接方式
    // kCALineJoinMiter 菱角
    // kCALineJoinRound 平滑
    // kCALineJoinBevel 折线
    dashedLayer.lineJoin        = kCALineJoinRound;
    
    // 设置虚线参数，设置后绘制出来的线都会变成虚线，没有count参数
    // 虚线起始偏移量 -值为向右偏移，+值为向左偏移
    dashedLayer.lineDashPhase   = self.dashedModel.phaseV;
    // 虚线虚实部分的长度参数
    dashedLayer.lineDashPattern = self.dashedModel.lengthsV;
    
    CGMutablePathRef path = CGPathCreateMutable();
    // 画直线
    CGPathMoveToPoint(path, NULL, 0, 15);
    CGPathAddLineToPoint(path, NULL, dashedLayer.width - 10, 15);
    // 画方形
    CGPathAddLineToPoint(path, NULL, dashedLayer.width - 10, dashedLayer.height - 10);
    CGPathAddLineToPoint(path, NULL, dashedLayer.width * 7/8, dashedLayer.height - 10);
    CGPathAddLineToPoint(path, NULL, dashedLayer.width * 7/8, 40);
    CGPathAddLineToPoint(path, NULL, dashedLayer.width * 5/8, 40);
    CGPathAddLineToPoint(path, NULL, dashedLayer.width * 5/8, dashedLayer.height - 10);
    // 画圆形
    CGPathAddLineToPoint(path, NULL, dashedLayer.width / 4, dashedLayer.height - 10);
    CGFloat radius = (dashedLayer.height - 50)/2;
    CGPoint center = CGPointMake(dashedLayer.width / 4, 40 + radius);
    CGPathAddArc(path, NULL, center.x, center.y, radius, M_PI_2, -M_PI, true);
    CGPathAddLineToPoint(path, NULL, 0, center.y);
    
    dashedLayer.path = path;
    [self.layer addSublayer:dashedLayer];
    
    CGPathRelease(path);
}

- (void)drawDashed2 {
    [self setNeedsDisplay];
}

#pragma mark - draw rect

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (self.dashedModel.type == DashedType2) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        // 线宽
        CGContextSetLineWidth(context, self.dashedModel.lineWidth);
        // 填充色
        CGContextSetFillColorWithColor(context, NULL);
        // 画笔颜色
        CGContextSetStrokeColorWithColor(context, self.dashedModel.lineColor.CGColor);
        // 首尾样式
        CGContextSetLineCap(context, kCGLineCapRound);
        // 线段连接方式
        // kCALineJoinMiter 菱角
        // kCALineJoinRound 平滑
        // kCALineJoinBevel 折线
        CGContextSetLineJoin(context, kCGLineJoinRound);
        
        CGFloat lengthsV[10] = {EOF};
        for (int i = 0; i < self.dashedModel.lengthsV.count; i++) {
            lengthsV[i] = [self.dashedModel.lengthsV[i] floatValue];
        }
        
        /*
         设置虚线参数，设置后绘制出来的线都会变成虚线
         phase: 虚线起始偏移量 -值为向右偏移，+值为向左偏移
         lengths: 虚线虚实部分的长度参数
         count: 限制长度参数中仅前count个参数生效
         */
        CGContextSetLineDash(context, self.dashedModel.phaseV, lengthsV, self.dashedModel.countV);
        
        // 画直线
        CGContextMoveToPoint(context, 0, 15);
        CGContextAddLineToPoint(context, rect.size.width - 10, 15);
        // 画方形
        CGContextAddLineToPoint(context, rect.size.width - 10, rect.size.height - 10);
        CGContextAddLineToPoint(context, rect.size.width * 7/8, rect.size.height - 10);
        CGContextAddLineToPoint(context, rect.size.width * 7/8, 40);
        CGContextAddLineToPoint(context, rect.size.width * 5/8, 40);
        CGContextAddLineToPoint(context, rect.size.width * 5/8, rect.size.height - 10);
        // 画圆形
        CGFloat radius = (rect.size.height - 50)/2;
        CGPoint center = CGPointMake(rect.size.width / 4, 40 + radius);
        CGContextAddLineToPoint(context, rect.size.width / 4, rect.size.height - 10);
        CGContextAddArc(context, center.x, center.y, radius, M_PI_2, -M_PI, 1);
        CGContextAddLineToPoint(context, 0, center.y);
        
        CGContextStrokePath(context);
    }
}

@end
