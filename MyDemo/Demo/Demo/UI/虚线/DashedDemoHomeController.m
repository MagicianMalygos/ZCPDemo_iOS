//
//  DashedDemoHomeController.m
//  Demo
//
//  Created by 朱超鹏(外包) on 17/1/11.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "DashedDemoHomeController.h"
#import "DashedSettingView.h"
#import "DashedView.h"

#define SettingViewHeight 170

@interface DashedDemoHomeController () {
    float phaseV;
    CGFloat lengthsV[10];
    float countV;
    CGRect dashedViewFrame;
}

@property (nonatomic, strong) DashedSettingView *settingView;

@end

@implementation DashedDemoHomeController

@synthesize infoArr = _infoArr;

#pragma mark - 
- (void)viewDidLoad {
    [super viewDidLoad];
    dashedViewFrame = CGRectMake(15, 25, self.view.frame.size.width - 30, 50);
    [self.view addSubview:self.settingView];
    [self.settingView.go addTarget:self action:@selector(reRender) forControlEvents:UIControlEventTouchUpInside];
    
    [self reRender];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, SettingViewHeight, SCREENWIDTH, SCREENHEIGHT - 64 - SettingViewHeight);
}

- (void)reRender {
    NSString *phaseS = self.settingView.phase.text;
    NSString *lengthsS = self.settingView.lengths.text;
    NSString *countS = self.settingView.count.text;
    
    phaseV = [phaseS floatValue];
    countV = [countS floatValue];
    NSString *lengthsP = @"";
    NSArray *lengthSArr = [lengthsS componentsSeparatedByString:@","];
    for (int i = 0; i < lengthSArr.count; i++) {
        lengthsV[i] = [lengthSArr[i] floatValue];
        lengthsP = [lengthsP stringByAppendingString:[NSString stringWithFormat:@"%f", lengthsV[i]]];
        if (i != lengthSArr.count - 1) {
            lengthsP = [lengthsP stringByAppendingString:@", "];
        } else {
            lengthsV[i + 1] = EOF;
        }
    }
    
    ZCPLog(@"phase: %f, count: %f, lengths: %@", phaseV, countV, lengthsP);
    
    [self.tableView reloadData];
}

#pragma mark - override

- (NSMutableArray *)infoArr {
    if (!_infoArr) {
        _infoArr = @[@{},@{},@{}].mutableCopy;
    }
    return _infoArr;
}

- (CGFloat)cellHeight {
    return 100.0f;
}

- (void)setupCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    UIView *oldView = [cell viewWithTag:10010];
    if (oldView) {
        [oldView removeFromSuperview];
    }
    
    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"drawDashed%i", (int)indexPath.row + 1]);
    UIView *view = nil;
    SuppressPerformSelectorLeakWarning({
        view = [self performSelector:selector];
        view.tag = 10010;
    });
    [cell addSubview:view];
}

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
- (UIView *)drawDashed1 {
    
    /* - - - View - - - */
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = dashedViewFrame;
    
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
    CGContextSetLineDash(context, phaseV, lengthsV, countV);
    
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
- (UIView *)drawDashed2 {
    
    /* - - - View - - - */
    DashedView *view    = [[DashedView alloc] init];
    view.phase          = phaseV;
    view.lengths        = lengthsV;
    view.count          = countV;
    view.frame          = dashedViewFrame;
    
    /* - - - Draw Dashed - - - */
    [view setNeedsLayout];
    
    /* - - - Return - - - */
    
    return view;
}
- (UIView *)drawDashed3 {
    
    /* - - - View - - - */
    UIView *view        = [[UIView alloc] init];
    view.frame          = dashedViewFrame;
    
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
    int  length = sizeof(lengthsV) / sizeof(lengthsV[0]);
    for (int i = 0; i < length; i++) {
        if (lengthsV[i] == EOF) {
            break;
        }
        [pattern addObject:@(lengthsV[i])];
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

#pragma mark - getter / setter

- (DashedSettingView *)settingView {
    if (_settingView == nil) {
        _settingView = [[[NSBundle mainBundle] loadNibNamed:@"DashedSettingView" owner:self options:nil] lastObject];
        _settingView.frame = CGRectMake(0, 0, SCREENWIDTH, SettingViewHeight);
    }
    return _settingView;
}

@end
