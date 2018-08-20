//
//  CASection3Demo.m
//  Demo
//
//  Created by 朱超鹏 on 2018/8/9.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "CASection3Demo.h"
#import "CALayerHelper.h"

@interface CASection3Demo () <CALayerDelegate>

@property (nonatomic, strong) CALayer *redLayer;
@property (nonatomic, strong) CALayer *greenLayer;
@property (nonatomic, strong) CALayer *blueLayer;

@property (nonatomic, strong) CALayer *autoLayoutLayer;

@end

@implementation CASection3Demo

// ----------------------------------------------------------------------
#pragma mark - demo
// ----------------------------------------------------------------------

#pragma mark 布局
- (void)demo1 {
    
    /*
     UIView有三个比较重要的布局属性：frame，bounds和center
     CALayer对应地叫做frame，bounds和position。
     
     frame代表了图层的外部坐标（也就是在父图层上占据的空间，）
     bounds是内部坐标（{0, 0}通常是图层的左上角）
     center和position都代表了相对于父图层anchorPoint所在的位置。
     
     对于视图或者图层来说，frame是一个虚拟属性，它是根据bounds，position和transform计算而来，所以当其中任何一个值发生改变，frame都会变化。相反，改变frame的值同样会影响到他们当中的值
     */
    NSLog(@"Rotation before:");
    {
        UIView *view            = [[UIView alloc] init];
        view.frame              = CGRectMake(50, 50, 100, 120);
        view.backgroundColor    = [UIColor redColor];
        [self addSubview:view];
        
        NSLog(@"view frame  = %@", [self stringValueOfCGRect:view.frame]);
        NSLog(@"view bounds = %@", [self stringValueOfCGRect:view.bounds]);
        NSLog(@"view center = %@", [self stringValueOfCGPoint:view.center]);
        
        NSLog(@"layer frame  = %@", [self stringValueOfCGRect:view.layer.frame]);
        NSLog(@"layer bounds = %@", [self stringValueOfCGRect:view.layer.bounds]);
        NSLog(@"layer center = %@", [self stringValueOfCGPoint:view.layer.center]);
    }
    
    /*
     当对图层做变换的时候，比如旋转或者缩放，frame实际是刚好覆盖图层旋转之后的整个图形且两边与坐标轴平行的矩形。frame的宽高可能和bounds的宽高不再一致，而bounds依旧是图层的实际大小。
     */
    NSLog(@"Rotation after:");
    {
        UIView *view            = [[UIView alloc] init];
        view.frame              = CGRectMake(50, 50, 100, 120);
        view.backgroundColor    = [UIColor greenColor];
        view.layer.transform    = CATransform3DMakeRotation(M_PI/6, 0, 0, 1);
        [self addSubview:view];
        
        NSLog(@"rotation view frame  = %@", [self stringValueOfCGRect:view.frame]);
        NSLog(@"rotation view bounds = %@", [self stringValueOfCGRect:view.bounds]);
        NSLog(@"rotation view center = %@", [self stringValueOfCGPoint:view.center]);
        
        NSLog(@"rotation layer frame  = %@", [self stringValueOfCGRect:view.layer.frame]);
        NSLog(@"rotation layer bounds = %@", [self stringValueOfCGRect:view.layer.bounds]);
        NSLog(@"rotation layer center = %@", [self stringValueOfCGPoint:view.layer.center]);
    }
    
    /*
     子视图的bounds是跟着父视图的bounds走的
     */
    {
        UIView *view            = [[UIView alloc] init];
        view.frame              = CGRectMake(50, 200, 100, 120);
        view.backgroundColor    = [UIColor redColor];
        view.layer.transform    = CATransform3DMakeRotation(M_PI/6, 0, 0, 1);
        [self addSubview:view];
        
        UIView *subView         = [[UIView alloc] init];
        subView.frame           = CGRectMake(25, 35, 50, 50);
        subView.backgroundColor = [UIColor greenColor];
        [view addSubview:subView];
    }
}

#pragma mark 锚点
- (void)demo2 {
    
    /*
     position是视图的锚点在父视图中的位置
     锚点取值范围为{0, 0} ~ {1, 1}，默认为{0.5, 0.5}
     使用场景：
        旋转时是以锚点进行旋转，所以视图需要旋转时可以通过改变锚点来设置旋转中心。
     */
    
    NSLog(@"Before:");
    {
        UIView *view            = [[UIView alloc] init];
        view.frame              = CGRectMake(50, 50, 100, 120);
        view.center             = CGPointMake(self.width / 2, self.height / 2);
        view.backgroundColor    = [UIColor redColor];
        [self addSubview:view];
        
        NSLog(@"layer frame       = %@", [self stringValueOfCGRect:view.layer.frame]);
        NSLog(@"layer bounds      = %@", [self stringValueOfCGRect:view.layer.bounds]);
        NSLog(@"layer position    = %@", [self stringValueOfCGPoint:view.layer.position]);
        NSLog(@"layer anchorPoint = %@", [self stringValueOfCGPoint:view.layer.anchorPoint]);
    }
    
    NSLog(@"After:");
    {
        UIView *view            = [[UIView alloc] init];
        view.frame              = CGRectMake(50, 50, 100, 120);
        view.center             = CGPointMake(self.width / 2, self.height / 2);
        view.backgroundColor    = [UIColor greenColor];
        view.layer.anchorPoint  = CGPointMake(0, 0);
        [self addSubview:view];
        
        NSLog(@"layer frame       = %@", [self stringValueOfCGRect:view.layer.frame]);
        NSLog(@"layer bounds      = %@", [self stringValueOfCGRect:view.layer.bounds]);
        NSLog(@"layer position    = %@", [self stringValueOfCGPoint:view.layer.position]);
        NSLog(@"layer anchorPoint = %@", [self stringValueOfCGPoint:view.layer.anchorPoint]);
    }
}

#pragma mark 坐标系转换
- (void)demo3 {
    // view convert
    {
        UIView *superView = [[UIView alloc] init];
        superView.frame = CGRectMake(100, 100, 100, 100);
        superView.backgroundColor = [UIColor redColor];
        [self addSubview:superView];
        
        UIView *subView = [[UIView alloc] init];
        subView.frame = CGRectMake(0, 0, 50, 50);
        subView.backgroundColor = [UIColor greenColor];
        [superView addSubview:subView];
        
        // view(subView)坐标系中的rect(subView.frame)转换到view(self)上的rect值
        CGRect rect1 = [subView convertRect:subView.frame toView:self];
        CGRect rect2 = [self convertRect:subView.frame fromView:subView];
        // view(subView)坐标系中的point(subView.center)转换到view(self)上的point值
        CGPoint point1 = [subView convertPoint:subView.center toView:self];
        CGPoint point2 = [self convertPoint:subView.center fromView:subView];
        NSLog(@"subView rect: %@ to   view    rect: %@", [self stringValueOfCGRect:subView.frame], [self stringValueOfCGRect:rect1]);
        NSLog(@"view    rect: %@ from subView rect: %@", [self stringValueOfCGRect:rect2], [self stringValueOfCGRect:subView.frame]);
        NSLog(@"subView point:%@ to   view    point:%@", [self stringValueOfCGPoint:subView.center], [self stringValueOfCGPoint:point1]);
        NSLog(@"view    point:%@ from subView point:%@", [self stringValueOfCGPoint:point2], [self stringValueOfCGPoint:subView.center]);
    }
    
    // layer convert
    {
        CALayer *superLayer = [[CALayer alloc] init];
        superLayer.frame = CGRectMake(10, 10, 50, 50);
        superLayer.backgroundColor = [UIColor redColor].CGColor;
        [self.layer addSublayer:superLayer];
        
        CALayer *subLayer = [[CALayer alloc] init];
        subLayer.frame = CGRectMake(20, 20, 30, 30);
        subLayer.backgroundColor = [UIColor greenColor].CGColor;
        [superLayer addSublayer:subLayer];
        
        // view(subView)坐标系中的rect(subView.frame)转换到view(self)上的rect值
        CGRect rect1 = [subLayer convertRect:subLayer.frame toLayer:self.layer];
        CGRect rect2 = [self.layer convertRect:subLayer.frame fromLayer:subLayer];
        // view(subView)坐标系中的point(subView.center)转换到view(self)上的point值
        CGPoint point1 = [subLayer convertPoint:subLayer.position toLayer:self.layer];
        CGPoint point2 = [self.layer convertPoint:subLayer.position fromLayer:subLayer];
        NSLog(@"subLayer rect: %@ to   layer    rect: %@", [self stringValueOfCGRect:subLayer.frame], [self stringValueOfCGRect:rect1]);
        NSLog(@"layer    rect: %@ from subLayer rect: %@", [self stringValueOfCGRect:rect2], [self stringValueOfCGRect:subLayer.frame]);
        NSLog(@"subLayer point:%@ to   layer    point:%@", [self stringValueOfCGPoint:subLayer.position], [self stringValueOfCGPoint:point1]);
        NSLog(@"layer    point:%@ from subLayer point:%@", [self stringValueOfCGPoint:point2], [self stringValueOfCGPoint:subLayer.position]);
    }
}

#pragma mark 坐标系翻转
- (void)demo4 {
    // 在iOS上，一个图层的position位于父图层的左上角，但是在Mac OS上，通常是位于左下角。Core Animation可以通过geometryFlipped属性来适配这两种情况，它决定了一个图层的坐标是否相对于父图层垂直翻转。
    {
        UIView *container = [[UIView alloc] init];
        container.frame = CGRectMake(0, 0, 100, 100);
        container.backgroundColor = [UIColor blackColor];
        [self addSubview:container];
        
        UILabel *upLabel = [[UILabel alloc] init];
        upLabel.backgroundColor = [UIColor redColor];
        upLabel.frame = CGRectMake(0, 0, 100, 20);
        upLabel.text = @"上 UP";
        upLabel.textAlignment = NSTextAlignmentCenter;
        [container addSubview:upLabel];
        
        UILabel *downLabel = [[UILabel alloc] init];
        downLabel.backgroundColor = [UIColor greenColor];
        downLabel.frame = CGRectMake(0, 80, 100, 20);
        downLabel.text = @"下 DOWN";
        downLabel.textAlignment = NSTextAlignmentCenter;
        [container addSubview:downLabel];
    }
    
    {
        UIView *container = [[UIView alloc] init];
        container.frame = CGRectMake(200, 0, 100, 100);
        container.backgroundColor = [UIColor blackColor];
        // 翻转属性
        container.layer.geometryFlipped = YES;
        [self addSubview:container];
        
        UILabel *upLabel = [[UILabel alloc] init];
        upLabel.backgroundColor = [UIColor redColor];
        upLabel.frame = CGRectMake(0, 0, 100, 20);
        upLabel.text = @"上 UP";
        upLabel.textAlignment = NSTextAlignmentCenter;
        [container addSubview:upLabel];
        
        UILabel *downLabel = [[UILabel alloc] init];
        downLabel.backgroundColor = [UIColor greenColor];
        downLabel.frame = CGRectMake(0, 80, 100, 20);
        downLabel.text = @"下 DOWN";
        downLabel.textAlignment = NSTextAlignmentCenter;
        [container addSubview:downLabel];
    }
}

#pragma mark 坐标系z轴
- (void)demo5 {
    {
        UILabel *upLabel = [[UILabel alloc] init];
        upLabel.backgroundColor = [UIColor redColor];
        upLabel.frame = CGRectMake(0, 0, 100, 100);
        upLabel.text = @"后";
        upLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:upLabel];
        
        UILabel *downLabel = [[UILabel alloc] init];
        downLabel.backgroundColor = [UIColor greenColor];
        downLabel.frame = CGRectMake(50, 50, 100, 100);
        downLabel.text = @"前";
        downLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:downLabel];
    }
    
    {
        UILabel *upLabel = [[UILabel alloc] init];
        upLabel.backgroundColor = [UIColor redColor];
        upLabel.frame = CGRectMake(200, 0, 100, 100);
        upLabel.text = @"后";
        upLabel.textAlignment = NSTextAlignmentCenter;
        // 改变了z轴坐标值
        upLabel.layer.zPosition = 0.00001;
        [self addSubview:upLabel];
        
        UILabel *downLabel = [[UILabel alloc] init];
        downLabel.backgroundColor = [UIColor greenColor];
        downLabel.frame = CGRectMake(250, 50, 100, 100);
        downLabel.text = @"前";
        downLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:downLabel];
    }
}

#pragma mark Hit Testing
- (void)demo6 {
    // CALayer并不关心任何响应链事件，所以不能直接处理触摸事件或者手势。但是它有一系列的方法可以辅助帮你处理事件：-containsPoint:和-hitTest:
    self.redLayer = ({
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, 200, 200);
        layer.position = CGPointMake(self.width / 2, self.height / 2);
        layer.backgroundColor = [UIColor redColor].CGColor;
        layer;
    });
    [self.layer addSublayer:self.redLayer];
    
    self.greenLayer = ({
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(25, 25, 100, 100);
        layer.backgroundColor = [UIColor greenColor].CGColor;
        layer.zPosition = 0.00001;
        layer;
    });
    [self.redLayer addSublayer:self.greenLayer];
    
    self.blueLayer = ({
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(75, 75, 100, 100);
        layer.backgroundColor = [UIColor blueColor].CGColor;
        layer;
    });
    [self.redLayer addSublayer:self.blueLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self];
    
    // containsPoint方法
//    point = [self.redLayer convertPoint:point fromLayer:self.layer];
//    if ([self.redLayer containsPoint:point]) {
//        CGPoint point1 = [self.greenLayer convertPoint:point fromLayer:self.redLayer];
//        CGPoint point2 = [self.blueLayer convertPoint:point fromLayer:self.redLayer];
//        BOOL pointInGreen = [self.greenLayer containsPoint:point1];
//        BOOL pointInBlue = [self.blueLayer containsPoint:point2];
//
//        if (pointInGreen && pointInBlue) {
//            NSLog(@"点击蓝色和绿色图层重合部分");
//        } else if (pointInGreen) {
//            NSLog(@"点击绿色图层");
//        } else if (pointInBlue) {
//            NSLog(@"点击蓝色图层");
//        } else {
//            NSLog(@"点击红色图层");
//        }
//    }
    
    // hit test
    // 注意当调用图层的-hitTest:方法时，测算的顺序严格依赖于图层树当中的图层顺序
    // 因此设置zPosition后虽然视觉效果上绿色在前，但是点击两个layer重合的地方，方法返回值是最后add的blueLayer
    CALayer *layer = [self.layer hitTest:point];
    
    if (layer == self.redLayer) {
        NSLog(@"点击红色图层");
    } else if (layer == self.greenLayer) {
        NSLog(@"点击绿色图层");
    } else if (layer == self.blueLayer) {
        NSLog(@"点击蓝色图层");
    }
}

#pragma mark 自动布局
- (void)demo7 {
    /*
     Core Animation对自动调整和自动布局缺乏支持
     屏幕旋转时，只能手动地重新摆放或者重新调整子图层的大小，但是不能像UIView的autoresizingMask和constraints属性做到自适应屏幕旋转
     */
    CALayer *layer          = [CALayer layer];
    layer.frame             = CGRectMake(16, 0, self.width - 32, 20);
    layer.backgroundColor   = [UIColor redColor].CGColor;
    [self.layer addSublayer:layer];
    
    self.autoLayoutLayer                    = [CALayer layer];
    self.autoLayoutLayer.frame              = CGRectMake(16, 20, self.width - 32, 20);
    self.autoLayoutLayer.backgroundColor    = [UIColor greenColor].CGColor;
    [self.layer addSublayer:self.autoLayoutLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.autoLayoutLayer.frame = CGRectMake(16, 20, self.width - 32, 20);
}

// ----------------------------------------------------------------------
#pragma mark - help method
// ----------------------------------------------------------------------

- (NSString *)stringValueOfCGRect:(CGRect)rect {
    return [NSString stringWithFormat:@"{%6.2f, %6.2f, %6.2f, %6.2f}", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height];
}

- (NSString *)stringValueOfCGPoint:(CGPoint)point {
    return [NSString stringWithFormat:@"{%6.2f, %6.2f}", point.x, point.y];
}

- (NSString *)stringValueOfCGSize:(CGSize)size {
    return [NSString stringWithFormat:@"{%6.2f, %6.2f}", size.width, size.height];
}

@end
