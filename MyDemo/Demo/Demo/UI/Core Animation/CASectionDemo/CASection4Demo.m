//
//  CASection4Demo.m
//  Demo
//
//  Created by 朱超鹏 on 2018/8/9.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "CASection4Demo.h"

@interface CASection4Demo ()

@property (nonatomic, weak) CALayer *maskLayer;
@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation CASection4Demo

// ----------------------------------------------------------------------
#pragma mark - demo
// ----------------------------------------------------------------------

#pragma mark 圆角

- (void)demo1 {
    self.backgroundColor = [UIColor grayColor];
    
    // layer圆角
    CALayer *layer          = [CALayer layer];
    layer.frame             = CGRectMake(10, 10, 50, 50);
    layer.backgroundColor   = [UIColor greenColor].CGColor;
    layer.cornerRadius      = 10;
    [self.layer addSublayer:layer];
    
    // view圆角
    /*
     label:
     必须设置masksToBounds为YES才有圆角效果
     
     imageView:
     当未设置图片时不用设置masksToBounds为YES就有圆角效果
     当设置图片时必须设置masksToBounds为YES才有圆角效果
     */
    {
        // 不设置内容的情况下，未设置masksToBounds为YES
        UIView *view                = [[UIView alloc] init];
        UILabel *label              = [[UILabel alloc] init];
        UIImageView *imageView      = [[UIImageView alloc] init];
        UIButton *button            = [UIButton buttonWithType:UIButtonTypeCustom];
        UITextField *textField      = [[UITextField alloc] init];
        UITextView *textView        = [[UITextView alloc] init];
        
        NSArray *viewArr            = @[view, label, imageView, button, textField, textView];
        for (int i = 0; i < viewArr.count; i++) {
            UIView *view            = viewArr[i];
            view.frame              = CGRectMake(i*50 + (i+1)*10, 70, 50, 50);
            view.layer.cornerRadius = 10;
            view.backgroundColor    = [UIColor greenColor];
            [self addSubview:view];
        }
    }
    {
        // 设置内容的情况下，未设置masksToBounds为YES
        UIView *view                = [[UIView alloc] init];
        UILabel *label              = [[UILabel alloc] init];
        label.text = @"A";
        UIImageView *imageView      = [[UIImageView alloc] init];
        imageView.image             = [UIImage imageNamed:@"taiji"];
        UIButton *button            = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"A" forState:UIControlStateNormal];
        UITextField *textField      = [[UITextField alloc] init];
        textField.text              = @"A";
        UITextView *textView        = [[UITextView alloc] init];
        textView.text               = @"A";
        
        NSArray *viewArr            = @[view, label, imageView, button, textField, textView];
        for (int i = 0; i < viewArr.count; i++) {
            UIView *view            = viewArr[i];
            view.frame              = CGRectMake(i*50 + (i+1)*10, 130, 50, 50);
            view.layer.cornerRadius = 10;
            view.backgroundColor    = [UIColor greenColor];
            [self addSubview:view];
        }
    }
}

#pragma mark 图层边框

- (void)demo2 {
    
    /*
     图层边框只与图层当前的bounds有关，与它的寄宿图无关，与它的子图层无关
     */
    CALayer *layer          = [CALayer layer];
    layer.frame             = CGRectMake(0, 0, 100, 100);
    layer.position          = CGPointMake(self.width / 2, self.height / 2);
    // 边框颜色
    layer.borderColor       = [UIColor redColor].CGColor;
    // 边框宽度
    layer.borderWidth       = 5;
    layer.contents          = (__bridge id _Nullable)([UIImage imageNamed:@"panda"].CGImage);
    layer.contentsGravity   = kCAGravityCenter;
    layer.transform         = CATransform3DMakeRotation(M_PI / 4, 0, 0, 1);
    
    CALayer *subLayer       = [CALayer layer];
    subLayer.frame          = CGRectMake(0, 0, 50, 50);
    subLayer.position       = CGPointZero;
    subLayer.backgroundColor = [UIColor greenColor].CGColor;
    
    [self.layer addSublayer:layer];
    [layer addSublayer:subLayer];
}

#pragma mark 阴影

- (void)demo3 {
    {
        CALayer *layer          = [CALayer layer];
        layer.frame             = CGRectMake(50, 50, 100, 100);
        layer.backgroundColor   = [UIColor redColor].CGColor;
        // 阴影颜色，默认为黑色
        layer.shadowColor       = [UIColor blackColor].CGColor;
        // 阴影透明度，取值[0, 1]，0完全透明，1完全不透明。默认为0，
        layer.shadowOpacity     = 1.0f;
        // 阴影偏移量，宽度为阴影的横向偏移量，高度为阴影的纵向偏移量。默认为(0, -3)
        layer.shadowOffset      = CGSizeMake(0, 3);
        // 阴影的模糊度，值越大阴影越醒目。默认为3
        layer.shadowRadius      = 10;
        [self.layer addSublayer:layer];
    }
    
    {
        CALayer *layer          = [CALayer layer];
        layer.frame             = CGRectMake(200, 50, 100, 100);
        // 阴影会将寄宿图的轮廓考虑在内
        layer.contents          = (__bridge id _Nullable)([UIImage imageNamed:@"panda"].CGImage);
        layer.shadowOpacity     = 1.0f;
        layer.shadowRadius      = 10.0f;
        layer.shadowOffset      = CGSizeMake(0, 3);
        [self.layer addSublayer:layer];
    }
    
    {
        /*
         当设置layer的masksToBounds为YES时，阴影也会被裁减掉
         */
        CALayer *layer          = [CALayer layer];
        layer.frame             = CGRectMake(50, 200, 100, 100);
        layer.backgroundColor   = [UIColor redColor].CGColor;
        layer.shadowOpacity     = 1.0f;
        layer.shadowRadius      = 10.0f;
        layer.shadowOffset      = CGSizeMake(0, 3);
        layer.masksToBounds     = YES;
        [self.layer addSublayer:layer];
        
        CALayer *subLayer       = [CALayer layer];
        subLayer.frame          = CGRectMake(-25, -25, 50, 50);
        subLayer.backgroundColor= [UIColor greenColor].CGColor;
        [layer addSublayer:subLayer];
    }
    
    {
        /*
         通过一个辅助的子图层可以解决阴影被裁剪的问题
         */
        CALayer *layer          = [CALayer layer];
        layer.frame             = CGRectMake(200, 200, 100, 100);
        layer.backgroundColor   = [UIColor redColor].CGColor;
        layer.shadowOpacity     = 1.0f;
        layer.shadowRadius      = 10.0f;
        layer.shadowOffset      = CGSizeMake(0, 3);
        [self.layer addSublayer:layer];
        
        CALayer *containerLayer         = [CALayer layer];
        containerLayer.bounds           = layer.bounds;
        containerLayer.anchorPoint      = CGPointZero;
        containerLayer.backgroundColor  = [UIColor clearColor].CGColor;
        containerLayer.masksToBounds    = YES;
        [layer addSublayer:containerLayer];
        
        CALayer *subLayer       = [CALayer layer];
        subLayer.frame          = CGRectMake(-25, -25, 50, 50);
        subLayer.backgroundColor= [UIColor greenColor].CGColor;
        [containerLayer addSublayer:subLayer];
    }
    
    {
        // 通过shadowPath创建一个任意形状的阴影，path组成的图形是实心的
        CALayer *layer          = [CALayer layer];
        layer.frame             = CGRectMake(50, 350, 100, 100);
        layer.backgroundColor   = [UIColor clearColor].CGColor;
        layer.shadowOpacity     = 1.0f;
        layer.shadowOffset      = CGSizeMake(0, 3);
        layer.shadowRadius      = 2;
        layer.borderColor       = [UIColor redColor].CGColor;
        layer.borderWidth       = 1.0f;
        
        // Core Graphics
        CGMutablePathRef path   = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 50, 0);
        CGPathAddLineToPoint(path, NULL, 100, 100);
        CGPathAddLineToPoint(path, NULL, 0, 100);
        CGPathAddLineToPoint(path, NULL, 50, 0);
        layer.shadowPath = path;
        CGPathRelease(path);
        
        // UIKit
//        UIBezierPath *path      = [UIBezierPath bezierPath];
//        [path moveToPoint:CGPointMake(50, 0)];
//        [path addLineToPoint:CGPointMake(100, 100)];
//        [path addLineToPoint:CGPointMake(0, 100)];
//        [path addLineToPoint:CGPointMake(50, 0)];
//        layer.shadowPath = path.CGPath;
        
        [self.layer addSublayer:layer];
    }
}

#pragma mark 图层蒙版

- (void)demo4 {
    // mask图层的Color属性是无关紧要的，真正重要的是图层的轮廓，mask图层实心的部分会被保留下来，其他的则会被抛弃
    CALayer *bgLayer        = [CALayer layer];
    bgLayer.frame           = CGRectMake(0, 0, self.layer.width, self.layer.height);
    bgLayer.position        = CGPointMake(self.width / 2, self.height / 2);
    bgLayer.contents        = (__bridge id _Nullable)([UIImage imageNamed:@"gradientColorBackground"].CGImage);
    bgLayer.masksToBounds   = YES;
    [self.layer addSublayer:bgLayer];
    
    CALayer *maskLayer      = [CALayer layer];
    maskLayer.frame         = CGRectMake(0, 0, 120, 120);
    maskLayer.contents      = (__bridge id _Nullable)([UIImage imageNamed:@"starMask"].CGImage);
    bgLayer.mask            = maskLayer;
    self.maskLayer          = maskLayer;
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(moveStarMask)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)moveStarMask {
    self.maskLayer.left += 1;
    if (self.maskLayer.right > self.width) {
        self.maskLayer.left = 0;
        self.maskLayer.top += self.maskLayer.height;
    }
    if (self.maskLayer.bottom > self.height) {
        [_displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        [_displayLink invalidate];
    }
}

#pragma mark 拉伸过滤

- (void)demo5 {
    /*
     当显示图片需要缩放时，就会根据拉伸过滤算法来进行计算，最终得出缩放后的图像。
     缩小是根据minificationFilter(缩小过滤算法)来处理
     放大是根据magnificationFilter(放大过滤算法)来处理
     
     算法有3种：
        kCAFilterLinear：双线性滤波算法（默认）
        kCAFilterTrilinear：三线性滤波算法
        kCAFilterNearest：最近过滤算法
     
     kCAFilterLinear：通过对多个像素取样最终生成新的值，得到一个平滑的表现不错的拉伸。缩放后图像比较平滑，适用于不规则的图像。
     kCAFilterTrilinear：存储了多个大小情况下的图片（也叫多重贴图），并三维取样，同时结合大图和小图的存储进而得到最后的结果。缩放后图像比较平滑，适用于不规则的图像。
     kCAFilterNearest：取样最近的单像素点而不管其他的颜色，速度快，图像清晰，但是对于斜线多不规则的图像马赛克严重。适用于没有斜线的小图。
     */
    
    // 没有斜线规则的图像，比较适合用最近过滤算法，图像会较为清晰
    {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 20, self.width / 2, self.width / 2);
        layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"number"].CGImage);
        layer.magnificationFilter = kCAFilterLinear;
        [self.layer addSublayer:layer];
    }
    
    {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(self.width / 2, 20, self.width / 2, self.width / 2);
        layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"number"].CGImage);
        layer.magnificationFilter = kCAFilterNearest;
        [self.layer addSublayer:layer];
    }
    
    // 不规则的图像，比较适合用线性滤波算法，图像会较为平滑
    {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, self.width / 2 + 40, self.width / 2, self.width / 2);
        layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"sex"].CGImage);
        layer.magnificationFilter = kCAFilterLinear;
        [self.layer addSublayer:layer];
    }
    
    {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(self.width / 2, self.width / 2 + 40, self.width / 2, self.width / 2);
        layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"sex"].CGImage);
        layer.magnificationFilter = kCAFilterNearest;
        [self.layer addSublayer:layer];
    }
}

@end
