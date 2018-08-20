//
//  CASection6Demo.m
//  Demo
//
//  Created by 朱超鹏 on 2018/8/16.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "CASection6Demo.h"
#import "CALayerHelper.h"
#import "CAEAGLDemoView.h"
#import <AVFoundation/AVFoundation.h>

@implementation CASection6Demo

// ----------------------------------------------------------------------
#pragma mark - demo
// ----------------------------------------------------------------------

#pragma mark CAShapeLayer
- (void)demo1 {
    /*
     CAShapeLayer是一个通过矢量图形而不是bitmap（如使用寄宿图）来绘制的图层子类
     
     优点：
        渲染快速。使用了硬件加速，绘制同一图形会比用Core Graphics快很多
        高效使用内存。一个CAShapeLayer不需要像普通CALayer一样创建一个寄宿图形，所以无论有多大，都不会占用太多的内存。
        不会被图层边界剪裁掉。一个CAShapeLayer可以在边界之外绘制。你的图层路径不会像在使用Core Graphics的普通CALayer一样被剪裁掉
        不会出现像素化。当你给CAShapeLayer做3D变换时，它不像一个有寄宿图的普通图层一样变得像素化。（因为是矢量图）
     
     缺点：
        属性设置在layer中时全局的，不能针对不同的图形设置不同的颜色或其他属性。
     */
    
    // 画火柴人
    {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(50, 50)];
        [path addArcWithCenter:CGPointMake(50, 25) radius:25 startAngle:M_PI_2 endAngle:M_PI*5/2 clockwise:YES];
        [path addLineToPoint:CGPointMake(50, 100)];
        [path moveToPoint:CGPointMake(0, 75)];
        [path addLineToPoint:CGPointMake(100, 75)];
        [path moveToPoint:CGPointMake(25, 150)];
        [path addLineToPoint:CGPointMake(50, 100)];
        [path addLineToPoint:CGPointMake(75, 150)];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.frame         = CGRectMake(10, 10, 100, 150);
        layer.backgroundColor = [UIColor lightGrayColor].CGColor;
        layer.path          = path.CGPath;
        layer.lineWidth     = 5;
        layer.lineCap       = kCALineCapRound;
        layer.lineJoin      = kCALineJoinRound;
        layer.strokeColor   = [UIColor redColor].CGColor;
        layer.fillColor     = [UIColor clearColor].CGColor;
        
        [self.layer addSublayer:layer];
    }
    
    // 单独指定圆角
    {
        UIRectCorner rectCorner = UIRectCornerTopLeft | UIRectCornerBottomRight;
        CGSize cornerRadii      = CGSizeMake(20, 20);
        UIBezierPath *path      = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(25, 25, 50, 50) byRoundingCorners:rectCorner cornerRadii:cornerRadii];
        
        CAShapeLayer *layer     = [CAShapeLayer layer];
        layer.backgroundColor   = [UIColor greenColor].CGColor;
        layer.frame             = CGRectMake(150, 10, 100, 100);
        layer.path              = path.CGPath;
        layer.lineWidth         = 5;
        layer.strokeColor       = [UIColor redColor].CGColor;
        layer.fillColor         = [UIColor clearColor].CGColor;
        [self.layer addSublayer:layer];
    }
}

#pragma mark CATextLayer
- (void)demo2 {
    // CATextLayer使用了Core text。它要比UILabel渲染得快得多。
    {
        // 创建layer
        CATextLayer *layer = [CATextLayer layer];
        layer.frame = CGRectMake(10, 10, 120, 120);
        layer.contentsScale = [UIScreen mainScreen].scale;
        layer.borderColor = [UIColor redColor].CGColor;
        layer.borderWidth = 1;
        [self.layer addSublayer:layer];
        
        // 设置属性
        layer.foregroundColor = [UIColor blackColor].CGColor;
        layer.alignmentMode = kCAAlignmentJustified;
        layer.wrapped = YES;
        
        UIFont *font = [UIFont systemFontOfSize:15.0f];
        CFStringRef fontName = (__bridge CFStringRef)(font.fontName);
        CGFontRef fontRef = CGFontCreateWithFontName(fontName);
        layer.font = fontRef;
        layer.fontSize = font.pointSize;
        CGFontRelease(fontRef);
        
        // 设置文本
        NSString *text = @"十里平湖霜满天，寸寸青丝愁华年。对月形单望相护，只羡鸳鸯不羡仙。";
        layer.string = text;
    }
    
    {
        // 创建layer
        CATextLayer *layer = [CATextLayer layer];
        layer.frame = CGRectMake(140, 10, 120, 120);
        layer.contentsScale = [UIScreen mainScreen].scale;
        layer.borderColor = [UIColor redColor].CGColor;
        layer.borderWidth = 1;
        [self.layer addSublayer:layer];
        
        // 设置属性
        layer.alignmentMode = kCAAlignmentJustified;
        layer.wrapped = YES;
        
        UIFont *font = [UIFont systemFontOfSize:15.0f];
        NSString *text = @"十里平湖霜满天，寸寸青丝愁华年。对月形单望相护，只羡鸳鸯不羡仙。";
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:text];
        
        CFStringRef fontName = (__bridge CFStringRef)font.fontName;
        CGFloat fontSize = font.pointSize;
        CTFontRef fontRef = CTFontCreateWithName(fontName, fontSize, NULL);
        
        // 设置整体文字属性
        NSDictionary *attr = @{(__bridge id)kCTForegroundColorAttributeName: (__bridge id)[UIColor blackColor].CGColor, (__bridge id)kCTFontAttributeName: (__bridge id)fontRef };
        [attrString setAttributes:attr range:NSMakeRange(0, text.length)];
        
        // 设置首行文字属性
        attr = @{(__bridge id)kCTForegroundColorAttributeName: (__bridge id)[UIColor redColor].CGColor,
                 (__bridge id)kCTFontAttributeName: (__bridge id)fontRef,
                 (__bridge id)kCTUnderlineStyleAttributeName: @(kCTUnderlineStyleSingle)
                 };
        [attrString setAttributes:attr range:NSMakeRange(0, 8)];
        CFRelease(fontRef);
        
        // 设置文本
        layer.string = attrString;
    }
}

#pragma mark CATransformLayer
- (void)demo3 {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / 500;
    self.layer.sublayerTransform = transform;
    
    CATransform3D transform1 = CATransform3DIdentity;
    transform1 = CATransform3DTranslate(transform1, -100, 0, 0);
    CATransformLayer *cube1 = [self cubeWithTransform:transform1];
    [self.layer addSublayer:cube1];
    
    CABasicAnimation *aniX = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    aniX.fromValue = @(0);
    aniX.toValue = @(M_PI * 2);
    aniX.duration = 5;
    aniX.repeatCount = INTMAX_MAX;
    [cube1 addAnimation:aniX forKey:nil];
    
    CABasicAnimation *aniY = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    aniY.fromValue = @(0);
    aniY.toValue = @(M_PI * 2);
    aniY.duration = 5;
    aniY.repeatCount = INTMAX_MAX;
    [cube1 addAnimation:aniY forKey:nil];
    
    CATransform3D transform2 = CATransform3DIdentity;
    CATransformLayer *cube2 = [self cubeWithTransform:transform2];
    [self.layer addSublayer:cube2];
    
    CABasicAnimation *aniMove = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    aniMove.fromValue = @(0);
    aniMove.toValue = @(200);
    aniMove.duration = 4;
    aniMove.repeatCount = INTMAX_MAX;
    [cube2 addAnimation:aniMove forKey:nil];
}

- (CATransformLayer *)cubeWithTransform:(CATransform3D)cubeTransform {
    CATransformLayer *cube = [CATransformLayer layer];
    // face1
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 50);
    [cube addSublayer:[self faceWithTransform:transform]];
    // face2
    transform = CATransform3DMakeTranslation(0, 0, -50);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:transform]];
    // face3
    transform = CATransform3DMakeTranslation(-50, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:transform]];
    // face4
    transform = CATransform3DMakeTranslation(50, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:transform]];
    // face5
    transform = CATransform3DMakeTranslation(0, -50, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:transform]];
    // face6
    transform = CATransform3DMakeTranslation(0, 50, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:transform]];
    
    cube.position = CGPointMake(self.width / 2, self.height / 2);
    cube.transform = cubeTransform;
    return cube;
}

- (CALayer *)faceWithTransform:(CATransform3D)transform {
    CALayer *face           = [CALayer layer];
    face.frame              = CGRectMake(-50, -50, 100, 100);
    face.backgroundColor    = RANDOM_COLOR.CGColor;
    face.transform          = transform;
    return face;
}

#pragma mark CAGradientLayer
- (void)demo4 {
    // 渐变图层
    
    // 基础渐变
    {
        CAGradientLayer *layer = [CAGradientLayer layer];
        layer.frame = CGRectMake(10, 10, 100, 100);
        layer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor blueColor].CGColor];
        layer.startPoint = CGPointMake(0, 0);
        layer.endPoint = CGPointMake(1, 0);
        [self.layer addSublayer:layer];
        
        layer = [CAGradientLayer layer];
        layer.frame = CGRectMake(120, 10, 100, 100);
        layer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor blueColor].CGColor];
        layer.startPoint = CGPointMake(0, 0);
        layer.endPoint = CGPointMake(0, 1);
        [self.layer addSublayer:layer];
        
        layer = [CAGradientLayer layer];
        layer.frame = CGRectMake(230, 10, 100, 100);
        layer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor blueColor].CGColor];
        layer.startPoint = CGPointMake(0, 0);
        layer.endPoint = CGPointMake(1, 1);
        [self.layer addSublayer:layer];
    }
    // 多重渐变
    {
        CAGradientLayer *layer = [CAGradientLayer layer];
        layer.frame = CGRectMake(10, 120, 300, 300);
        layer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                         (__bridge id)[UIColor orangeColor].CGColor,
                         (__bridge id)[UIColor yellowColor].CGColor,
                         (__bridge id)[UIColor greenColor].CGColor,
                         (__bridge id)[UIColor cyanColor].CGColor,
                         (__bridge id)[UIColor blueColor].CGColor,
                         (__bridge id)[UIColor purpleColor].CGColor];
        // 渐变的位置
        layer.locations = @[@0.1, @0.2, @0.3, @0.5, @0.7, @0.8, @0.9];
        layer.startPoint = CGPointMake(0, 0);
        layer.endPoint = CGPointMake(1, 1);
        [self.layer addSublayer:layer];
    }
}

#pragma mark CAReplicatorLayer
- (void)demo5 {
    
    // 重复图层
    {
        CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
        replicatorLayer.frame = CGRectMake(10, 10, 150, 150);
        replicatorLayer.borderColor = [UIColor redColor].CGColor;
        replicatorLayer.borderWidth = 1;
        replicatorLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
        [self.layer addSublayer:replicatorLayer];
        
        replicatorLayer.instanceCount = 8;
        replicatorLayer.instanceBlueOffset = -0.1;
        replicatorLayer.instanceGreenOffset = -0.1;
        
        // 重复生成的图层，每一个都以前一个图层进行变换
        // 很奇怪的是，创建重复图层时旋转的锚点都在replicatorLayer的中心
        CATransform3D transform = CATransform3DIdentity;
        transform = CATransform3DRotate(transform, M_PI_4, 0, 0, 1);
        replicatorLayer.instanceTransform = transform;
        
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, 20, 20);
        layer.center = CGPointMake(replicatorLayer.width / 2, replicatorLayer.height / 2 - 50);
        layer.backgroundColor = [UIColor whiteColor].CGColor;
        [replicatorLayer addSublayer:layer];
    }
    // 倒影效果
    {
        CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
        replicatorLayer.frame = CGRectMake(170, 10, 150, 150);
        replicatorLayer.borderColor = [UIColor redColor].CGColor;
        replicatorLayer.borderWidth = 1;
        [self.layer addSublayer:replicatorLayer];
        
        replicatorLayer.instanceCount = 2;
        replicatorLayer.instanceAlphaOffset = -0.5;
        
        CATransform3D transform = CATransform3DIdentity;
        transform = CATransform3DRotate(transform, M_PI, 0, 0, 1);
        replicatorLayer.instanceTransform = transform;
        
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, 50, 50);
        layer.center = CGPointMake(replicatorLayer.width / 2, replicatorLayer.height / 2 - 25);
        layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"panda"].CGImage);
        [replicatorLayer addSublayer:layer];
    }
}

#pragma mark CAScrollLayer
- (void)demo6 {
    
    // 滑动图层
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, 200, 200);
    view.layer.borderWidth = 1;
    view.layer.borderColor = [UIColor redColor].CGColor;
    [self addSubview:view];
    
    CAScrollLayer *scrollLayer = [CAScrollLayer layer];
    scrollLayer.frame = view.bounds;
    [view.layer addSublayer:scrollLayer];
    
    [view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer *)sender;
        CGPoint offset = self.bounds.origin;
        offset.x -= [panGesture translationInView:self].x;
        offset.y -= [panGesture translationInView:self].y;
        // 滑动到指定点的位置
        [scrollLayer scrollToPoint:offset];
    }]];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 50, 50);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [scrollLayer addSublayer:layer];
}

#pragma mark CATiledLayer
- (void)demo7 {
    // 当图片很大的时候（比如地图），载入会非常的慢，在主线程调用UIImage的-imageNamed:方法或者-imageWithContentsOfFile:方法，将会阻塞用户界面。
    // 所有显示在屏幕上的图片最终都会被转化为OpenGL纹理，同时OpenGL有一个最大的纹理尺寸。如果你想在单个纹理中显示一个比这大的图，即便图片已经存在于内存中了，你仍然会遇到很大的性能问题，因为Core Animation强制用CPU处理图片而不是更快的GPU
    // 可以将大图分解成小片然后将他们单独按需载入
    
    // 瓦片图层
    
    CATiledLayer *tileLayer = [CATiledLayer layer];
    tileLayer.frame         = CGRectMake(0, 0, 7180, 4783);
    tileLayer.delegate      = [CALayerHelper sharedInstance];
    tileLayer.caDemoTag     = @"section6_demo7_tileLayer";
    // 滚动视图
    UIScrollView *scrollView        = [[UIScrollView alloc] init];
    scrollView.frame                = CGRectMake(0, 0, 350, 350);
    scrollView.center               = CGPointMake(self.width / 2, self.height / 2);
    scrollView.layer.borderColor    = [UIColor redColor].CGColor;
    scrollView.layer.borderWidth    = 1;
    scrollView.contentSize          = tileLayer.frame.size;
    [self addSubview:scrollView];
    [scrollView.layer addSublayer:tileLayer];
    
    [tileLayer setNeedsDisplay];
}

#pragma mark CAEmitterLayer
- (void)demo8 {
    // 创建一个粒子图层
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    emitterLayer.frame = CGRectMake(0, 0, 300, 300);
    emitterLayer.center = CGPointMake(self.width / 2, self.height / 2);
    emitterLayer.borderColor = [UIColor redColor].CGColor;
    emitterLayer.borderWidth = 1;
    [self.layer addSublayer:emitterLayer];
    
    // 配置粒子图层
    emitterLayer.renderMode = kCAEmitterLayerAdditive;
    emitterLayer.emitterPosition = CGPointMake(emitterLayer.frame.size.width / 2.0f, emitterLayer.frame.size.height / 2);

    // 创建一个粒子模型
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"starMask"].CGImage);
    cell.birthRate = 10;
    cell.lifetime = 5.0f;
    cell.color = [UIColor colorWithRed:1.0 green:0.5 blue:0.1 alpha:1.0].CGColor;
    cell.alphaSpeed = -0.4;
    cell.velocity = 50;
    cell.velocityRange = 50;
    cell.emissionRange = M_PI * 2.0f;

    // 将粒子模型添加到粒子图层中
    emitterLayer.emitterCells = @[cell];
}

#pragma mark CAEAGLLayer
- (void)demo9 {
    // 在iOS 5中，苹果引入了一个新的框架叫做GLKit，它去掉了一些设置OpenGL的复杂性，提供了一个叫做CLKView的UIView的子类，帮你处理大部分的设置和绘制工作
    // 前提是各种各样的OpenGL绘图缓冲的底层可配置项仍然需要你用CAEAGLLayer完成，它是CALayer的一个子类，用来显示任意的OpenGL图形
    
    CAEAGLDemoView *view = [[CAEAGLDemoView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    view.center = CGPointMake(self.width / 2, self.height / 2);
    [self addSubview:view];
}

#pragma mark AVPlayerLayer
- (void)demo10 {
    // AVPlayerLayer是用来在iOS上播放视频的。他是高级接口例如MPMoivePlayer的底层实现，提供了显示视频的底层控制
    
    NSURL *url = [NSURL URLWithString:@"http://flv2.bn.netease.com/videolib3/1604/28/fVobI0704/SD/fVobI0704-mobile.mp4"];
    
    AVPlayer *player = [AVPlayer playerWithURL:url];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = CGRectMake(0, 0, 300, 300);
    playerLayer.center = CGPointMake(self.width / 2, self.height / 2);
    [self.layer addSublayer:playerLayer];
    
    [player play];
    
    // 因为AVPlayerLayer是CALayer的子类，所以我们可以给它加一些效果
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / 500.0f;
    transform = CATransform3DRotate(transform, M_PI_4, 1, 1, 0);
    playerLayer.transform = transform;
    
    playerLayer.masksToBounds = YES;
    playerLayer.cornerRadius = 20.0f;
    playerLayer.borderColor = [UIColor redColor].CGColor;
    playerLayer.borderWidth = 5.0f;
}

// ----------------------------------------------------------------------
#pragma mark - help method
// ----------------------------------------------------------------------
// 将大图拆分成小图
- (void)splitBigImageToSmaller {
    // 输入图片路径
    NSString *inputFile = [[NSBundle mainBundle] pathForResource:@"Azeroth" ofType:@"jpg"];
    // 输出图片路径
    NSString *outputPath = [inputFile stringByDeletingPathExtension];
    
    // 输入图片
    UIImage *inputImage = [UIImage imageWithContentsOfFile:inputFile];
    CGImageRef inputImageRef = inputImage.CGImage;
    // 输入图片大小
    CGSize inputImageSize = inputImage.size;
    
    // 碎片图片大小
    CGSize tileImageSize = CGSizeMake(256, 256);
    // 计算碎片图的行数和列数
    NSInteger rows = ceil(inputImageSize.height / tileImageSize.height);
    NSInteger cols = ceil(inputImageSize.width / tileImageSize.width);

    // 剪切出每一块碎片图并保存
    for (int row = 0; row < rows; row++) {
        for (int col = 0; col < cols; col++) {
            // 生成碎片图
            CGRect tileRect = CGRectMake(col * tileImageSize.width, row * tileImageSize.height, tileImageSize.width, tileImageSize.height);
            CGImageRef tileImage = CGImageCreateWithImageInRect(inputImageRef, tileRect);
            NSData *imageData = UIImageJPEGRepresentation([UIImage imageWithCGImage:tileImage], 1.0);
            CGImageRelease(tileImage);
            // 保存碎片图
            NSString *path = [outputPath stringByAppendingFormat:@"_%02i_%02i.jpg", row, col];
            [imageData writeToFile:path atomically:NO];
        }
    }
}

@end
