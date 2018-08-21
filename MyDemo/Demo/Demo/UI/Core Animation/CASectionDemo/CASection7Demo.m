//
//  CASection7Demo.m
//  Demo
//
//  Created by 朱超鹏 on 2018/8/20.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "CASection7Demo.h"

@interface CASection7Demo ()

@property (nonatomic, strong) CALayer *colorLayer;
@property (nonatomic, strong) UIView *colorView1;
@property (nonatomic, strong) UIView *colorView2;
@property (nonatomic, strong) UIView *colorView3;
@property (nonatomic, strong) UIView *colorView4;

@property (nonatomic, strong) CALayer *moveLayer;

@end

@implementation CASection7Demo

// ----------------------------------------------------------------------
#pragma mark - demo
// ----------------------------------------------------------------------

#pragma mark 隐式动画
- (void)demo1 {
    // 当你改变CALayer的一个可做动画的属性，它并不能立刻在屏幕上体现出来。相反，它是从先前的值平滑过渡到新的值。这一切都是默认的行为，你不需要做额外的操作。
    self.colorLayer                 = [CALayer layer];
    self.colorLayer.frame           = CGRectMake(0, 0, 200, 200);
    self.colorLayer.position        = CGPointMake(self.width / 2, self.height / 2);
    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:self.colorLayer];
    
    UIButton *changeColorButton     = [self getButton];
    changeColorButton.tag           = 1;
    [self addSubview:changeColorButton];
}

#pragma mark 事务
- (void)demo2 {
    // 事务实际上是Core Animation用来包含一系列属性动画集合的机制，任何用指定事务去改变可以做动画的图层属性都不会立刻发生变化，而是当事务一旦提交的时候开始用一个动画过渡到新值。
    // 事务是通过CATransaction类来做管理。不能用普通的方式创建，只能用+begin和+commit分别来入栈或者出栈。
    // 任何可以做动画的图层属性都会被添加到栈顶的事务。Core Animation在每个run loop周期中自动开始一次新的事务，即使你不显式的用[CATransaction begin]开始一次事务，任何在一次run loop循环中属性的改变都会被集中起来，然后做一次0.25秒的动画。
    self.colorLayer                 = [CALayer layer];
    self.colorLayer.frame           = CGRectMake(0, 0, 200, 200);
    self.colorLayer.position        = CGPointMake(self.width / 2, self.height / 2);
    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:self.colorLayer];
    
    UIButton *changeColorButton     = [self getButton];
    changeColorButton.tag           = 2;
    [self addSubview:changeColorButton];
}

#pragma mark 完成块
- (void)demo3 {
    self.colorLayer                 = [CALayer layer];
    self.colorLayer.frame           = CGRectMake(0, 0, 200, 200);
    self.colorLayer.position        = CGPointMake(self.width / 2, self.height / 2);
    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:self.colorLayer];
    
    UIButton *changeColorButton     = [self getButton];
    changeColorButton.tag           = 3;
    [self addSubview:changeColorButton];
}

#pragma mark 图层行为
- (void)demo4 {
    // UIView关联的图层禁用了隐式动画。当修改view的layer时，图层颜色瞬间切换到新的值，而不是之前平滑过渡的动画。
    
    /*
     我们把改变属性时CALayer自动应用的动画称作行为，当CALayer的属性被修改时候，它会调用-actionForKey:方法，传递属性的名称。步骤如下：
     1.图层检测它是否有委托，且是否实现CALayerDelegate协议的-actionForLayer:forKey方法。如果有，调用并返回结果。
     2.如果不满足上述委托调用，图层接着在行为映射actions字典中搜索属性名称。
     3.如果actions字典没有，那么图层接着在它的style字典搜索属性名。
     4.如果在style里面也找不到对应的行为，那么图层将会直接调用定义了每个属性的标准行为的-defaultActionForKey:方法。
     
     所以一轮完整的搜索结束之后，-actionForKey:要么返回空（这种情况下将不会有动画发生），要么是CAAction协议对应的对象，最后CALayer拿这个结果去对先前和当前的值做动画。
     于是这就解释了UIKit是如何禁用隐式动画的：每个UIView对它关联的图层都扮演了一个委托，并且提供了-actionForLayer:forKey的实现方法。当不在一个动画块的实现中，UIView对所有图层行为返回nil，但是在动画block范围之内，它就返回了一个非空值。
     */
    
    /*
     UIView关联的图层禁用了隐式动画，对这种图层做动画的办法就是：
     1.使用UIView的动画函数 +beginAnimations:context:、+commitAnimations。（而不是依赖CATransaction）。
     2.或者继承UIView，并覆盖-actionForLayer:forKey:方法，
     3.或者直接创建一个显式动画
     
     对于单独存在的图层，
     1.我们可以通过实现图层的-actionForLayer:forKey:委托方法，
     2.或者提供一个actions字典来控制隐式动画。
     */
    self.colorView1 = ({
        UIView *view                = [[UIView alloc] init];
        view.frame                  = CGRectMake(10, 100, 100, 100);
        view.layer.backgroundColor  = [UIColor redColor].CGColor;
        view;
    });
    [self addSubview:self.colorView1];
    
    self.colorView2 = ({
        UIView *view                = [[UIView alloc] init];
        view.frame                  = CGRectMake(120, 100, 100, 100);
        view.layer.backgroundColor  = [UIColor redColor].CGColor;
        view;
    });
    [self addSubview:self.colorView2];
    
    self.colorView3 = ({
        UIView *view                = [[UIView alloc] init];
        view.frame                  = CGRectMake(230, 100, 100, 100);
        view.layer.backgroundColor  = [UIColor redColor].CGColor;
        view;
    });
    [self addSubview:self.colorView3];
    
    // 自定义图层行为
    self.colorLayer                 = [CALayer layer];
    self.colorLayer.frame           = CGRectMake(self.width / 2 - 50, 220, 100, 100);
    self.colorLayer.position        = CGPointMake(self.width / 2, self.height / 2);
    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:self.colorLayer];
    
    CATransition *transition    = [CATransition animation];
    transition.type             = kCATransitionPush;
    transition.subtype          = kCATransitionFromLeft;
    self.colorLayer.actions     = @{@"backgroundColor": transition};
    [self.layer addSublayer:self.colorLayer];
    
    UIButton *changeColorButton     = [self getButton];
    changeColorButton.tag           = 4;
    [self addSubview:changeColorButton];
}

#pragma mark 呈现与模型
- (void)demo5 {
    /*
     图层树：图层树中的模型图层记录了图层属性的结果值。
     
     呈现树：呈现树中的呈现图层记录了图层在屏幕上真正显示出来的样子。
     
     每个图层属性的显示值都被存储在一个叫做呈现图层的独立图层当中，他可以通过-presentationLayer方法来访问。这个呈现图层实际上是模型图层的复制，但是它的属性值代表了在任何指定时刻当前外观效果。你可以通过呈现图层的值来获取当前屏幕上真正显示出来的值。
     
     比如一个视图做移动动画，从x=0移动到x=100，在设置动画之后，就可以看到x直接变成了100，但是实际屏幕上看到的效果是图层的x慢慢从0~100。呈现图层就是记录了这个0~100的过程。
     */
    self.userInteractionEnabled     = YES;
    
    self.moveLayer                  = [CALayer layer];
    self.moveLayer.frame            = CGRectMake(10, 10, 100, 100);
    self.moveLayer.backgroundColor  = [UIColor redColor].CGColor;
    [self.layer addSublayer:self.moveLayer];
}

// ----------------------------------------------------------------------
#pragma mark - event response
// ----------------------------------------------------------------------

- (void)clickButton:(UIButton *)button {
    if (button.tag == 1) {
        // 属性改变的动作会被加到栈顶的事务中，这里栈顶的事务即为系统创建的事务，执行默认0.25秒的动画
        self.colorLayer.backgroundColor = RANDOM_COLOR.CGColor;
    } else if (button.tag == 2) {
        // 入栈一个新事务
        [CATransaction begin];
        // 设置动画间隔
        [CATransaction setAnimationDuration:2.0f];
        // 属性改变的动作会被加到栈顶的事务中，而栈顶的事务就是刚刚我们自己入栈的这个新事务
        self.colorLayer.backgroundColor = RANDOM_COLOR.CGColor;
        // 提交并出栈该事务
        [CATransaction commit];
    } else if (button.tag == 3) {
        [CATransaction begin];
        [CATransaction setAnimationDuration:1.0f];
        // 事务完成块
        [CATransaction setCompletionBlock:^{
            // 旋转45度，该旋转的操作是在默认的事务中进行
            CGAffineTransform affineTransform = self.colorLayer.affineTransform;
            affineTransform = CGAffineTransformRotate(affineTransform, M_PI_4);
            self.colorLayer.affineTransform = affineTransform;
        }];
        self.colorLayer.backgroundColor = RANDOM_COLOR.CGColor;
        [CATransaction commit];
    } else if (button.tag == 4) {
        // view1
        // 可以看到并没有动画效果
        [CATransaction begin];
        [CATransaction setAnimationDuration:1.0f];
        self.colorView1.layer.backgroundColor = RANDOM_COLOR.CGColor;
        [CATransaction commit];
        
        // view2
        // 同上，没有动画效果
        self.colorView2.layer.backgroundColor = RANDOM_COLOR.CGColor;
        // 输出：<null>
        NSLog(@"%@", [self.colorView2 actionForLayer:self.colorView2.layer forKey:@"backgroundColor"]);
        
        // view3
        // 使用了UIView的动画函数，有动画效果
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.0f];
        self.colorView3.layer.backgroundColor = RANDOM_COLOR.CGColor;
        // 输出：<CABasicAnimation: 0x6040002274a0>
        NSLog(@"%@", [self.colorView3 actionForLayer:self.colorView3.layer forKey:@"backgroundColor"]);
        [UIView commitAnimations];
        
        // view4
        // 自定义图层行为
        self.colorLayer.backgroundColor = RANDOM_COLOR.CGColor;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self];
    // presentationLayer用于hitTest，可实现在图层移动过程中点击看到的图层改变颜色。
    // 如果使用self.moveLayer，则点击看到的图层不会改变颜色，点击终点的位置才会改变颜色。
    if ([self.moveLayer.presentationLayer hitTest:point]) {
        self.moveLayer.backgroundColor = RANDOM_COLOR.CGColor;
    } else {
        [CATransaction begin];
        [CATransaction setAnimationDuration:10.0f];
        self.moveLayer.position = point;
        [CATransaction commit];
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

@end
