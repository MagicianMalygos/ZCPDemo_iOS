//
//  TipsView.m
//  Demo
//
//  Created by apple on 16/6/2.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "TipsView.h"

@interface TipsView ()

@property (nonatomic, strong) UIImageView   *arrowView;             // 第一页斜箭头
@property (nonatomic, strong) UILabel       *textDescriptionLabel;  // 文本描述
@property (nonatomic, strong) UIButton      *processButton;         // 按钮
@property (nonatomic, strong) UIImageView   *finalSnapImageView;    // 第二页的竖箭头
@property (nonatomic, strong) UIImageView   *starImageView;         // 星星图片
@property (nonatomic, assign) CGRect        rentalIconFrame;        // 白亮显示区frame

@end

@implementation TipsView

- (instancetype)initWithFrame:(CGRect)frame circleFrame:(CGRect)circleRect {
    
    // 计算显示区中心点
    CGPoint centerOfCircle = CGPointMake(circleRect.origin.x + circleRect.size.width / 2, circleRect.origin.y + circleRect.size.height / 2);
    // 设置显示区大小
    circleRect.size.height = 80;
    circleRect.size.width = 80;
    circleRect.origin.x = centerOfCircle.x - 40;
    circleRect.origin.y = centerOfCircle.y - 40;
    _rentalIconFrame = circleRect;
    
    if (self = [super initWithFrame:frame]) {
        self.opaque = YES;  // 如果opaque设置为YES，绘图系统会将view看为完全不透明，提升性能
        self.backgroundColor = [UIColor clearColor];
        
        // 第一页视图（透明黑背景+指定区域显示）
        _firstTipView = [[UIView alloc] initWithFrame:self.bounds];
        _firstTipView.backgroundColor = [UIColor clearColor];
        // 画贝塞尔曲线 http://www.jianshu.com/p/734b34e82135
        int radius = circleRect.size.width / 2;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:0];
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:circleRect cornerRadius:radius];
        [path appendPath:circlePath];
        [path setUsesEvenOddFillRule:YES];  // 奇偶填充规则，偶数重叠部分会被裁剪，奇数重叠部分会显示 http://stackoverflow.com/questions/14840563/how-does-usesevenoddfillrule-work
        // 将贝塞尔曲线应用于layer http://blog.it985.com/7654.html
        CAShapeLayer *fillLayer = [CAShapeLayer layer];
        fillLayer.path = path.CGPath;
        fillLayer.fillRule = kCAFillRuleEvenOdd;
        fillLayer.fillColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.7f].CGColor;
        [_firstTipView.layer addSublayer:fillLayer];
        [self addSubview:_firstTipView];
        
        // 第二页视图（透明黑背景）
        _secondTipView = [[UIView alloc] initWithFrame:self.bounds];
        _secondTipView.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.7f];
        _secondTipView.hidden = YES;
        [self addSubview:_secondTipView];
        
        // 箭头
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tips_page_arrow"]];
        _arrowView.right = circleRect.origin.x + 24;
        _arrowView.top = circleRect.origin.y + circleRect.size.height + 4;
        [self addSubview:_arrowView];
        
        // 描述文字
        _textDescriptionLabel = [[UILabel alloc] init];
        NSMutableAttributedString *attrStr = [NSMutableAttributedString new];
        ;
        NSAttributedString *newAttributedString1 = [[NSAttributedString alloc] initWithString:@"全新" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15 * SCREENWIDTH / 375], NSForegroundColorAttributeName:[UIColor colorWithHexString:@"ff8447"], NSUnderlineStyleAttributeName: @(NSUnderlineStyleNone)}];
        
        [attrStr appendAttributedString:newAttributedString1];
        NSAttributedString *newAttributedString2 = [[NSAttributedString alloc] initWithString:@"租房频道倾情上线" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15 * SCREENWIDTH / 375], NSForegroundColorAttributeName:[UIColor colorWithHexString:@"ffffff"], NSUnderlineStyleAttributeName: @(NSUnderlineStyleNone)}];
        [attrStr appendAttributedString:newAttributedString2];
        _textDescriptionLabel.attributedText = attrStr;
        [_textDescriptionLabel sizeToFit];
        _textDescriptionLabel.textAlignment = NSTextAlignmentRight;
        _textDescriptionLabel.right = _arrowView.left - 10;
        _textDescriptionLabel.top = _arrowView.bottom - _arrowView.height / 2;
        [self addSubview:_textDescriptionLabel];
        
        // 下一步按钮
        _processButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _processButton.frame = CGRectMake(0, 0, 118.0, 34.0);//
        _processButton.tag = 1;//
        [_processButton setImage:[UIImage imageNamed:@"tips_page_next_step"] forState:UIControlStateNormal];
        [_processButton addTarget:self action:@selector(processButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        _processButton.center = CGPointMake(_textDescriptionLabel.centerX, _textDescriptionLabel.bottom + 41);
        [self addSubview:_processButton];
        
        // 星星图片
        _starImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tips_page_star"]];
        _starImageView.bottom = circleRect.origin.y + 4.0f;
        _starImageView.left = circleRect.origin.x + circleRect.size.width - 8;
        [self addSubview:_starImageView];
        
        // 竖箭头
        _finalSnapImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tips_page_arrow_down"]];
        _finalSnapImageView.hidden = YES;
        [self addSubview:_finalSnapImageView];
    }
    return self;
}

- (void)processButtonPressed:(UIButton *)sender {
    switch (sender.tag) {
        case 1: {
            // 动画切换
            WEAK_SELF;
            [UIView animateWithDuration:0.5f animations:^{
                // 移除/隐藏第一页的内容
                [weakSelf.firstTipView removeFromSuperview];
                weakSelf.starImageView.hidden = YES;
                weakSelf.arrowView.hidden = YES;
                
                // 显示第二页的内容
                weakSelf.secondTipView.hidden = NO;
                weakSelf.finalSnapImageView.hidden = NO;
                [weakSelf.processButton setImage:[UIImage imageNamed:@"tips_page_done"] forState:UIControlStateNormal];
                weakSelf.processButton.tag = 2;
                
                // 设置描述文字
                NSMutableAttributedString *attrStr = [NSMutableAttributedString new];
                NSAttributedString *newAttributedString1 = [[NSAttributedString alloc] initWithString:@"更多" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15 * SCREENWIDTH / 375], NSForegroundColorAttributeName:[UIColor colorWithHexString:@"ffffff"], NSUnderlineStyleAttributeName: false ? @(NSUnderlineStyleSingle) : @(NSUnderlineStyleNone)}];
                [attrStr appendAttributedString:newAttributedString1];
                NSAttributedString *newAttributedString2 = [[NSAttributedString alloc] initWithString:@"精彩活动" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15 * SCREENWIDTH / 375], NSForegroundColorAttributeName:[UIColor colorWithHexString:@"ff8447"], NSUnderlineStyleAttributeName: false ? @(NSUnderlineStyleSingle) : @(NSUnderlineStyleNone)}];
                [attrStr appendAttributedString:newAttributedString2];
                NSAttributedString *newAttributedString3 = [[NSAttributedString alloc] initWithString:@"请关注这里" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15 * SCREENWIDTH / 375], NSForegroundColorAttributeName:[UIColor colorWithHexString:@"ffffff"], NSUnderlineStyleAttributeName: false ? @(NSUnderlineStyleSingle) : @(NSUnderlineStyleNone)}];
                [attrStr appendAttributedString:newAttributedString3];
                weakSelf.textDescriptionLabel.attributedText = attrStr;
                [weakSelf.textDescriptionLabel sizeToFit];
                weakSelf.textDescriptionLabel.textAlignment = NSTextAlignmentCenter;
                weakSelf.textDescriptionLabel.center = CGPointMake(weakSelf.centerX, weakSelf.rentalIconFrame.origin.y + weakSelf.rentalIconFrame.size.height/2);
                
                // 设置按钮
                weakSelf.processButton.center = CGPointMake(weakSelf.textDescriptionLabel.centerX, weakSelf.textDescriptionLabel.bottom + 41);
                
                // 第二页竖箭头
                weakSelf.finalSnapImageView.top = weakSelf.processButton.bottom + 10;
                weakSelf.finalSnapImageView.center = CGPointMake(weakSelf.textDescriptionLabel.centerX, weakSelf.finalSnapImageView.centerY);
            }];
            break;
        }
        case 2: {
            // 结束动画
            WEAK_SELF;
            [UIView animateWithDuration:0.4 animations:^{
                STRONG_SELF;
                [self removeFromSuperview];
            }];
            break;
        }
        default:
            break;
    }
}

@end
