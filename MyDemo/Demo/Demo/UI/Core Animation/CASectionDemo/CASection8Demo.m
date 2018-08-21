//
//  CASection8Demo.m
//  Demo
//
//  Created by 朱超鹏 on 2018/8/20.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "CASection8Demo.h"

#define kAnimationTag   @"kAnimationTag"

@interface CASection8Demo () <CAAnimationDelegate, UITabBarDelegate>

@property (nonatomic, strong) CALayer *colorLayer1;
@property (nonatomic, strong) CALayer *colorLayer2;
@property (nonatomic, strong) CALayer *moveLayer;
@property (nonatomic, strong) CAShapeLayer *trackLayer;

@property (nonatomic, strong) UITabBar *tabBar1;
@property (nonatomic, strong) UITabBar *tabBar2;

@property (nonatomic, strong) CALayer *rotateLayer1;
@property (nonatomic, strong) CALayer *rotateLayer2;

@end

@implementation CASection8Demo

// ----------------------------------------------------------------------
#pragma mark - demo
// ----------------------------------------------------------------------

#pragma mark 属性动画
- (void)demo1 {
    self.colorLayer1 = ({
        CALayer *layer = [CALayer layer];
        layer.frame             = CGRectMake(10, 100, 100, 100);
        layer.backgroundColor   = [UIColor redColor].CGColor;
        layer;
    });
    [self.layer addSublayer:self.colorLayer1];
    
    self.colorLayer2 = ({
        CALayer *layer          = [CALayer layer];
        layer.frame             = CGRectMake(120, 100, 100, 100);
        layer.backgroundColor   = [UIColor redColor].CGColor;
        layer;
    });
    [self.layer addSublayer:self.colorLayer2];
    
    self.moveLayer = ({
        CALayer *layer          = [CALayer layer];
        layer.frame             = CGRectMake(0, 0, 100, 100);
        layer.position          = CGPointMake(50, 320);
        layer.contents          = (__bridge id _Nullable)([UIImage imageNamed:@"plane"].CGImage);
        layer;
    });
    [self.layer addSublayer:self.moveLayer];
    
    UIButton *button            = [self getButton];
    button.tag                  = 1;
    [self addSubview:button];
    
    // 虚拟属性，比如transform.rotation、transform.scale。我们实际上并不能获取到他们，不能直接使用。
    // 但是在做动画时我们可以使用他们，并且只对某个属性做动画而不影响其他属性。
    // 特别的，如果对transform做旋转动画，旋转360度是没有任何效果的。
}

#pragma mark 动画组
- (void)demo2 {
    UIBezierPath *bezierPath        = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(50, 150)];
    [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(125, 0) controlPoint2:CGPointMake(225, 300)];
    
    // 轨道
    self.trackLayer                 = [CAShapeLayer layer];
    self.trackLayer.fillColor       = nil;
    self.trackLayer.strokeColor     = [UIColor redColor].CGColor;
    self.trackLayer.lineWidth       = 5;
    self.trackLayer.path            = bezierPath.CGPath;
    [self.layer addSublayer:self.trackLayer];
    
    // 色块layer
    self.colorLayer1                = [CALayer layer];
    self.colorLayer1.frame          = CGRectMake(0, 0, 64, 64);
    self.colorLayer1.position       = CGPointMake(50, 150);
    self.colorLayer1.backgroundColor = [UIColor greenColor].CGColor;
    [self.layer addSublayer:self.colorLayer1];
    
    // 动画1 设置位置
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
    animation1.keyPath              = @"position";
    animation1.path                 = bezierPath.CGPath;
    animation1.rotationMode         = kCAAnimationRotateAuto;
    // 动画2 设置背景色
    CABasicAnimation *animation2    = [CABasicAnimation animation];
    animation2.keyPath              = @"backgroundColor";
    animation2.toValue              = (__bridge id)[UIColor redColor].CGColor;
    // 动画组
    CAAnimationGroup *group         = [CAAnimationGroup animation];
    group.animations                = @[animation1, animation2];
    group.duration                  = 4.0f;
    group.repeatCount               = INTMAX_MAX;
    [self.colorLayer1 addAnimation:group forKey:nil];
}

#pragma mark 过渡
- (void)demo3 {
    /*
     对比较难做动画的布局进行改变，比如交换图片和文本，就不能用普通的属性动画来做，可以使用过渡。
     过渡动画首先展示之前的图层外观，然后通过一个交换过渡到新的外观。
     
     过渡有一下四种类型，type属性：
     kCATransitionFade          淡入淡出（默认）
     kCATransitionMoveIn        定向滑动，新图层滑入，遮盖老图层
     kCATransitionPush          定向滑动，新图层滑入，将老图层推出
     kCATransitionReveal        定向滑动，老图层滑出，显示新图层
     
     对于定向滑动有下面几个子类型，subType属性：
     kCATransitionFromRight     向右滑动
     kCATransitionFromLeft      向左滑动
     kCATransitionFromTop       向上滑动
     kCATransitionFromBottom    向下滑动
     */
    
    CATransition *transition1   = [CATransition animation];
    transition1.type            = kCATransitionFade;
    UIImageView *imageView1     = [self getImageViewWithTransition:transition1];
    imageView1.frame            = CGRectMake(self.width / 2 - 120, 10, 100, 100);
    [self addSubview:imageView1];
    
    CATransition *transition2   = [CATransition animation];
    transition2.type            = kCATransitionMoveIn;
    UIImageView *imageView2     = [self getImageViewWithTransition:transition2];
    imageView2.frame            = CGRectMake(self.width / 2 + 20, 10, 100, 100);
    [self addSubview:imageView2];
    
    CATransition *transition3   = [CATransition animation];
    transition3.type            = kCATransitionPush;
    UIImageView *imageView3     = [self getImageViewWithTransition:transition3];
    imageView3.frame            = CGRectMake(self.width / 2 - 120, 120, 100, 100);
    [self addSubview:imageView3];
    
    CATransition *transition4   = [CATransition animation];
    transition4.type            = kCATransitionReveal;
    UIImageView *imageView4     = [self getImageViewWithTransition:transition4];
    imageView4.frame            = CGRectMake(self.width / 2 + 20, 120, 100, 100);
    [self addSubview:imageView4];
}

#pragma mark 对图层树的动画
- (void)demo4 {
    {
        UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"文案1" image:[UIImage imageNamed:@"fire"] tag:0];
        UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"文案2" image:[UIImage imageNamed:@"fire"] tag:1];
        UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"文案3" image:[UIImage imageNamed:@"fire"] tag:2];
        UITabBar *tabBar    = [[UITabBar alloc] init];
        tabBar.frame        = CGRectMake(0, 50, self.width, 49);
        tabBar.items        = @[item1, item2, item3];
        tabBar.delegate     = self;
        [self addSubview:tabBar];
        self.tabBar1 = tabBar;
    }
    {
        UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"文案1" image:[UIImage imageNamed:@"fire"] tag:0];
        UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"文案2" image:[UIImage imageNamed:@"fire"] tag:1];
        UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"文案3" image:[UIImage imageNamed:@"fire"] tag:2];
        UITabBar *tabBar    = [[UITabBar alloc] init];
        tabBar.frame        = CGRectMake(0, 150, self.width, 49);
        tabBar.items        = @[item1, item2, item3];
        tabBar.delegate     = self;
        [self addSubview:tabBar];
        self.tabBar2 = tabBar;
    }
}

#pragma mark 自定义过渡动画
- (void)demo5 {
    self.userInteractionEnabled = YES;
    @weakify(self);
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        @strongify(self);
        UIGraphicsBeginImageContextWithOptions(self.size, YES, 0.0);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *coverImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIView *coverView = [[UIImageView alloc] initWithImage:coverImage];
        coverView.frame = self.bounds;
        [self addSubview:coverView];
        
        self.backgroundColor = RANDOM_COLOR;
        
        [UIView animateWithDuration:1.0f animations:^{
            CGAffineTransform transform = CGAffineTransformMakeScale(0.01, 0.01);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            coverView.transform = transform;
            coverView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [coverView removeFromSuperview];
        }];
    }]];
}

#pragma mark 在动画过程中取消动画
- (void)demo6 {
    UIButton *startButton       = [UIButton buttonWithType:UIButtonTypeCustom];
    startButton.frame           = CGRectMake(self.width / 2 - 100, 10, 50, 50);
    startButton.backgroundColor = [UIColor redColor];
    startButton.tag             = 61;
    [startButton setTitle:@"开始" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:startButton];
    
    UIButton *endButton         = [UIButton buttonWithType:UIButtonTypeCustom];
    endButton.frame             = CGRectMake(self.width / 2 + 50, 10, 50, 50);
    endButton.backgroundColor   = [UIColor redColor];
    endButton.tag             = 62;
    [endButton setTitle:@"结束" forState:UIControlStateNormal];
    [endButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:endButton];
    {
        CALayer *planeLayer     = [CALayer layer];
        planeLayer.frame        = CGRectMake(0, 0, 100, 100);
        planeLayer.position     = CGPointMake(self.width / 2 - 100, self.height / 2);
        planeLayer.contents     = (__bridge id)[UIImage imageNamed:@"plane"].CGImage;
        [self.layer addSublayer:planeLayer];
        self.rotateLayer1       = planeLayer;
    }
    {
        CALayer *planeLayer     = [CALayer layer];
        planeLayer.frame        = CGRectMake(0, 0, 100, 100);
        planeLayer.position     = CGPointMake(self.width / 2 + 100, self.height / 2);
        planeLayer.contents     = (__bridge id)[UIImage imageNamed:@"plane"].CGImage;
        [self.layer addSublayer:planeLayer];
        self.rotateLayer2       = planeLayer;
    }
}

// ----------------------------------------------------------------------
#pragma mark - event response
// ----------------------------------------------------------------------

- (void)clickButton:(UIButton *)button {
    
    if (button.tag == 1) {
        // 1_1
        UIColor *color              = RANDOM_COLOR;
        
        CABasicAnimation *ani1      = [CABasicAnimation animation];
        ani1.keyPath                = @"backgroundColor";
        ani1.toValue                = (__bridge id _Nullable)(color.CGColor);
        ani1.duration               = 2;
        ani1.delegate               = self;
        [ani1 setValue:@(11) forKey:kAnimationTag];
        [self.colorLayer1 addAnimation:ani1 forKey:nil];
        
        // 1_2
        CAKeyframeAnimation *ani2   = [CAKeyframeAnimation animation];
        ani2.keyPath                = @"backgroundColor";
        ani2.duration               = 4;
        ani2.values                 = @[(__bridge id)[UIColor blueColor].CGColor,
                                        (__bridge id)[UIColor redColor].CGColor,
                                        (__bridge id)[UIColor greenColor].CGColor,
                                        (__bridge id)[UIColor blueColor].CGColor];
        [ani2 setValue:@(12) forKey:kAnimationTag];
        [self.colorLayer2 addAnimation:ani2 forKey:nil];
        
        // 1_3
        UIBezierPath *path          = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(50, 320)];
        [path addCurveToPoint:CGPointMake(300, 320) controlPoint1:CGPointMake(125, 120) controlPoint2:CGPointMake(225, 520)];
        CAKeyframeAnimation *ani3   = [CAKeyframeAnimation animation];
        ani3.keyPath                = @"position";
        ani3.path                   = path.CGPath;
        ani3.duration               = 4.0f;
        ani3.rotationMode           = kCAAnimationRotateAuto;
        ani3.delegate               = self;
        [ani3 setValue:@"13" forKey:kAnimationTag];
        [self.moveLayer addAnimation:ani3 forKey:nil];
        // 轨迹layer
        self.trackLayer             = [CAShapeLayer layer];
        self.trackLayer.path        = path.CGPath;
        self.trackLayer.fillColor   = [UIColor clearColor].CGColor;
        self.trackLayer.strokeColor = [UIColor redColor].CGColor;
        self.trackLayer.lineWidth   = 5;
        [self.layer addSublayer:self.trackLayer];
    } else if (button.tag == 61) {
        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.keyPath = @"transform.rotation";
        animation.duration = 2.0f;
        animation.byValue = @(M_PI * 2);
        [self.rotateLayer1 addAnimation:animation forKey:@"rotateAnimation"];
        [self.rotateLayer2 addAnimation:animation forKey:@"rotateAnimation"];
    } else if (button.tag == 62) {
        self.rotateLayer2.transform = self.rotateLayer2.presentationLayer.transform;
        [self.rotateLayer1 removeAnimationForKey:@"rotateAnimation"];
        [self.rotateLayer2 removeAnimationForKey:@"rotateAnimation"];
    }
}

// ----------------------------------------------------------------------
#pragma mark - CAAnimationDelegate
// ----------------------------------------------------------------------

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    // anim对象是最初创建出的动画对象的深拷贝
    NSInteger tag = [[anim valueForKey:kAnimationTag] integerValue];
    
    if (tag == 11) {
        CABasicAnimation *animation = (CABasicAnimation *)anim;
        // 此处需要禁用隐式动画，否则会执行两次动画。
        // 或者使用view的layer让系统帮助取消隐式动画
        [CATransaction begin];
        // 禁用隐式动画，在当前事务中禁用所有行为
        [CATransaction setDisableActions:YES];
        self.colorLayer1.backgroundColor = (__bridge CGColorRef _Nullable)(animation.toValue);
        [CATransaction commit];
    } else if (tag == 12) {
        // 帧动画不会将图层当前的状态作为首帧
    } else if (tag == 13) {
        [self.trackLayer removeFromSuperlayer];
    }
}

// ----------------------------------------------------------------------
#pragma mark - UITabBarDelegate
// ----------------------------------------------------------------------

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if (tabBar == self.tabBar1) {
        CATransition *transition    = [CATransition animation];
        transition.type             = kCATransitionFade;
        transition.duration         = 1.0f;
        // 动画直接在tabBar的layer上，而不是加在tabBarItem上
        [self.tabBar1.layer addAnimation:transition forKey:nil];
    } else if (tabBar == self.tabBar2) {
        CATransition *transition    = [CATransition animation];
        transition.type             = kCATransitionMoveIn;
        transition.duration         = 1.0f;
        // 实际上是整体做了动画，如果使用Fade的话视觉效果上只能看到点击部分有动画
        [self.tabBar2.layer addAnimation:transition forKey:nil];
    }
}

// ----------------------------------------------------------------------
#pragma mark - help method
// ----------------------------------------------------------------------

- (UIButton *)getButton {
    UIButton *button                = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame                    = CGRectMake(0, 0, 150, 50);
    button.center                   = CGPointMake(self.width / 2, 35);
    button.layer.cornerRadius       = 25;
    button.layer.borderColor        = [UIColor redColor].CGColor;
    button.layer.borderWidth        = 2;
    [button setTitle:@"点击改变颜色" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (UIImageView *)getImageViewWithTransition:(CATransition *)transition {
    NSArray *images         = @[@"plane", @"sex", @"panda", @"colorbox"];
    UIImageView *imageView  = [[UIImageView alloc] init];
    imageView.image         = [UIImage imageNamed:@"plane"];
    imageView.userInteractionEnabled = YES;
    imageView.tag           = 0;
    
    __weak typeof(imageView) weakImageView = imageView;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [weakImageView.layer addAnimation:transition forKey:nil];
        
        NSUInteger index    = weakImageView.tag;
        index               = (index + 1) % images.count;
        weakImageView.image = [UIImage imageNamed:images[index]];
        weakImageView.tag   = index;
    }]];
    return imageView;
}

@end
