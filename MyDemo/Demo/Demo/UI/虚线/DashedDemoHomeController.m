//
//  DashedDemoHomeController.m
//  Demo
//
//  Created by 朱超鹏(外包) on 17/1/11.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "DashedDemoHomeController.h"
#import "DashedSettingView.h"

#define SettingViewHeight 170

@interface DashedDemoHomeController () {
    float phaseV;
    CGFloat lengthsV[10];
    float countV;
}

@property (nonatomic, strong) DashedSettingView *settingView;

@end

@implementation DashedDemoHomeController

@synthesize infoArr = _infoArr;

#pragma mark - 
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.settingView];
    [self.settingView.go addTarget:self action:@selector(reRender) forControlEvents:UIControlEventTouchUpInside];
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
        _infoArr = @[@{},@{},@{},@{},@{},@{},@{},@{}].mutableCopy;
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
    
    UIImageView *view = [[UIImageView alloc] init];
    view.frame = CGRectMake(15, 25, self.view.frame.size.width - 30, 20);
    view.tag = 10010;
    view.image = [self drawLineByImageView:view];
    [cell addSubview:view];
}

#pragma mark - Draw Dashed
// 通过 Quartz 2D 生成UIImage虚线
- (UIImage *)drawLineByImageView:(UIImageView *)imageView {
    // 设置frame
    UIGraphicsBeginImageContext(imageView.frame.size);
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    
    // 获取当前上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 设置线条颜色
    CGContextSetStrokeColorWithColor(context, [UIColor colorFromHexRGB:@"ff0000"].CGColor);
    // 设置线宽 X
//    CGContextSetLineWidth(context, 10);
    
    // 设置线条样式
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
    CGContextAddLineToPoint(context, imageView.width / 2, 20);
    CGContextAddLineToPoint(context, imageView.width, 20);
    // 画线
    CGContextStrokePath(context); // CGContextDrawPath(context, kCGPathStroke);
    
    // 输出image
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束
    UIGraphicsEndImageContext();
    
    return outputImage;
}
- (void)drawDashed2 {
}
- (void)drawDashed3 {
}
- (void)drawDashed4 {
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
