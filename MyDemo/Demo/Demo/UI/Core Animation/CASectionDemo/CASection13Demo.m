//
//  CASection13Demo.m
//  Demo
//
//  Created by 朱超鹏 on 2018/8/28.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "CASection13Demo.h"

#define BRUSH_SIZE  10

@interface CASection13Demo ()

@property (nonatomic, strong) UIBezierPath *bezierPath1;
@property (nonatomic, strong) UIBezierPath *bezierPath2;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, strong) NSMutableArray *strokes;

@end

@implementation CASection13Demo

// ----------------------------------------------------------------------
#pragma mark - demo
// ----------------------------------------------------------------------

/*
 软件绘图：
 
 在iOS中，软件绘图通常是由Core Graphics框架完成来完成。但是，在一些必要的情况下，相比Core Animation和OpenGL，Core Graphics要慢了不少。
 软件绘图不仅效率低，还会消耗可观的内存。CALayer只需要一些与自己相关的内存：只有它的寄宿图会消耗一定的内存空间。即使直接赋给contents属性一张图片，也不需要增加额外的照片存储大小。如果相同的一张图片被多个图层作为contents属性，那么他们将会共用同一块内存，而不是复制内存块。
 但是一旦你实现了CALayerDelegate协议中的-drawLayer:inContext:方法或者UIView中的-drawRect:方法（其实就是前者的包装方法），图层就创建了一个绘制上下文，这个上下文需要的大小的内存可从这个算式得出：图层宽*图层高*4字节，宽高的单位均为像素。对于一个在Retina iPad上的全屏图层来说，这个内存量就是 2048*1526*4字节，相当于12MB内存，图层每次重绘的时候都需要重新抹掉内存然后重新分配。
 
 1.使用设置设置图片会重用。
 2.使用drawRect:每次重绘都会创建绘制上下文，浪费内存。
 */

#pragma mark 绘制矢量图形的2种方法
- (void)demo1 {
    self.backgroundColor            = [UIColor whiteColor];
    self.tag                        = 1;
    
    self.bezierPath1                = [UIBezierPath bezierPath];
    self.bezierPath1.lineCapStyle   = kCGLineCapRound;
    self.bezierPath1.lineJoinStyle  = kCGLineJoinRound;
    self.bezierPath1.lineWidth      = 5;
    
    self.bezierPath2                = [UIBezierPath bezierPath];
    self.bezierPath2.lineCapStyle   = kCGLineCapRound;
    self.bezierPath2.lineJoinStyle  = kCGLineJoinRound;
    self.bezierPath2.lineWidth      = 5;
    
    self.shapeLayer                 = [CAShapeLayer layer];
    self.shapeLayer.frame           = CGRectMake(0, self.height / 2, self.width, self.height / 2);
    self.shapeLayer.strokeColor     = [UIColor redColor].CGColor;
    self.shapeLayer.fillColor       = nil;
    self.shapeLayer.lineJoin        = kCALineJoinRound;
    self.shapeLayer.lineCap         = kCALineCapRound;
    self.shapeLayer.lineWidth       = 5;
    self.shapeLayer.borderColor     = [UIColor greenColor].CGColor;
    self.shapeLayer.borderWidth     = 1;
    [self.layer addSublayer:self.shapeLayer];
}

#pragma mark 脏矩阵
- (void)demo2 {
    /*
     有时候用CAShapeLayer或者其他矢量图形图层替代Core Graphics并不是那么切实可行。比如我们绘图来的线条是一个个小星星贴图。
     我们可以给每个贴图创建一个独立的图层，但是实现起来有很大的问题。屏幕上允许同时出现图层上线数量大约是几百，那样我们很快就会超出的。这种情况下只能使用Core Graphics了。
     
     为了减少不必要的绘制，Mac OS和iOS设备将会把屏幕区分为需要重绘的区域和不需要重绘的区域。那些需要重绘的部分被称作『脏区域』。在实际应用中，鉴于非矩形区域边界裁剪和混合的复杂性，通常会区分出包含指定视图的矩形位置，而这个位置就是『脏矩形』。
     可以使用-setNeedsDisplayInRect:方法来标记脏矩形
     */
    self.backgroundColor    = [UIColor whiteColor];
    self.tag                = 2;
    
    self.strokes            = [NSMutableArray array];
}

// ----------------------------------------------------------------------
#pragma mark - help method
// ----------------------------------------------------------------------

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.tag == 1) {
        // demo1
        CGPoint point = [[touches anyObject] locationInView:self];
        CGPoint pointInShapeLayer = [self.layer convertPoint:point toLayer:self.shapeLayer];
        
        if ([self.shapeLayer containsPoint:pointInShapeLayer]) {
            [self.bezierPath2 moveToPoint:pointInShapeLayer];
        } else {
            [self.bezierPath1 moveToPoint:point];
        }
    } else if (self.tag == 2) {
        // demo2
        CGPoint point = [[touches anyObject] locationInView:self];
        [self.strokes addObject:@(point)];
        // 只绘制画刷附近的矩形区域
        CGRect dirtyRect = [self brushRectForPoint:point];
        [self setNeedsDisplayInRect:dirtyRect];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.tag == 1) {
        // demo1
        CGPoint point = [[touches anyObject] locationInView:self];
        CGPoint pointInShapeLayer = [self.layer convertPoint:point toLayer:self.shapeLayer];
        
        if ([self.shapeLayer containsPoint:pointInShapeLayer]) {
            [self.bezierPath2 addLineToPoint:pointInShapeLayer];
            // 使用Core Animation（性能较高）
            self.shapeLayer.path = self.bezierPath2.CGPath;
        } else {
            [self.bezierPath1 addLineToPoint:point];
            // 使用Core Graphics（性能较低）
            [self setNeedsDisplayInRect:CGRectMake(0, 0, self.width, self.height / 2)];
        }
    } else if (self.tag == 2) {
        // demo2
        CGPoint point = [[touches anyObject] locationInView:self];
        [self.strokes addObject:@(point)];
        // 只绘制画刷附近的矩形区域
        CGRect dirtyRect = [self brushRectForPoint:point];
        [self setNeedsDisplayInRect:dirtyRect];
    }
}

- (void)drawRect:(CGRect)rect {
    if (self.tag == 1) {
        // demo1
        [[UIColor clearColor] setFill];
        [[UIColor redColor] setStroke];
        [self.bezierPath1 stroke];
    } else if (self.tag == 2) {
        // demo2
        for (NSValue *pointValue in self.strokes) {
            CGPoint point       = pointValue.CGPointValue;
            CGRect brushRect    = [self brushRectForPoint:point];
            if (CGRectContainsRect(rect, brushRect)) {
                [[UIImage imageNamed:@"gear"] drawInRect:brushRect];
            }
        }
    }
}

- (CGRect)brushRectForPoint:(CGPoint)point {
    // 由于存在浮点数失精的情况，所以保留小数点后两位，以确保脏矩形的范围与贴图的矩形范围相等
    // 此demo2仍旧存在一些不太好的效果。因为如果新贴图与老贴图有重合部分，进行绘制时会将新贴图位置的矩形中的内容擦除，此时即使新贴图有部分透明的区域，老贴图也会缺失一部分内容。
    NSString *x = [NSString stringWithFormat:@"%.2f", point.x - BRUSH_SIZE / 2];
    NSString *y = [NSString stringWithFormat:@"%.2f", point.y - BRUSH_SIZE / 2];
    CGRect rect = CGRectMake(x.floatValue, y.floatValue, BRUSH_SIZE, BRUSH_SIZE);
    return rect;
}

@end
