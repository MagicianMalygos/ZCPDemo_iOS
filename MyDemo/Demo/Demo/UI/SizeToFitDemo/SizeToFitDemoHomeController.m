//
//  SizeToFitDemoHomeController.m
//  SizeToFit
//
//  Created by apple on 15/11/30.
//  Copyright © 2015年 apple. All rights reserved.
//

/* 根据文本内容设置label的高度，其实就是使用NSString的boundingRectWithSize:options:attributes:context:方法或者NSAttributedString的boundingRectWithSize:options:context:方法，计算文本在给定条件下占用的矩形大小。
 
    NSString方法：
    - (CGRect)boundingRectWithSize:(CGSize)size options:(NSStringDrawingOptions)options attributes:(nullable NSDictionary<NSString *, id> *)attributes context:(nullable NSStringDrawingContext *)context NS_AVAILABLE(10_11, 7_0);
 
    该方法类型：
    CGRect:     表示在给定条件下文本占用的矩形大小
 
    该方法入参：
    size:       限制文本占用范围的最大宽高。MAXFLOAT为不限。比如设置size为CGSizeMake(100, 50)，则文字最多只占满宽100高50的范围，文字较多超出范围时则返回值即为CGRectMake(0, 0, 100, 50)。如果设置size为CGSizeMake(100, MAXFLOAT)，则文字最多只占满宽100的高度不限的范围，文字较多超出范围时则返回CGRectMake(0, 0, 100, h)（h为文字在矩形范围内全部显示时的高度）。
    options:    控制文本占用矩形的每一行该如何计算。一般使用NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading组合。
                NSStringDrawingOptions枚举：
                NSStringDrawingUsesLineFragmentOrigin：以每行组成的矩形为单位计算整个文本的尺寸
                NSStringDrawingUsesFontLeading：使用行距计算行高。行距 = 字体大小 + 行间距，从一行文字的底部到下一行文字的底部距离
                NSStringDrawingUsesDeviceMetrics：计算布局时使用图元字形（而不是印刷字体）
                NSStringDrawingTruncatesLastVisibleLine：计算文本尺寸时将以每个字或字形为单位来计算。如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号，如果没有指定NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略。
    attributes: 文字的属性字典，指明文本的属性。
                属性字典key有：
                NSFontAttributeName    字体
                NSParagraphStyleAttributeName  段落样式
                NSForegroundColorAttributeName 文字颜色
                NSBackgroundColorAttributeName 文字背景颜色
                NSLigatureAttributeName    设置连体属性，取值为NSNumber 对象(整数)，0 表示没有连体字符，1 表示使用默认的连体字符
                NSKernAttributeName    设定字符间距
                NSStrikethroughStyleAttributeName  设置删除线
                NSUnderlineStyleAttributeName  下划线
                NSStrokeColorAttributeName 填充部分颜色
                NSStrokeWidthAttributeName 设置笔画宽度
                NSShadowAttributeName  阴影属性
                NSTextEffectAttributeName  文本特殊效果
                NSAttachmentAttributeName  文本附件
                NSLinkAttributeName    设置连接属性
                NSBaselineOffsetAttributeName  设置基线偏移值，取值为NSnumber（float），正值上偏，负值下偏
                NSUnderlineColorAttributeName  设置下划线颜色
                NSStrikethroughColorAttributeName  设置删除线颜色，默认为黑色
                NSObliquenessAttributeName 设置字体倾斜度，取值为NSNumber（float），正值右倾，负值左倾
                NSExpansionAttributeName   设置文本横向拉伸属性，取值为NSNumber（float），正值横向拉伸文本，负值横向压缩文本
                NSWritingDirectionAttributeName    设置文字书写方向，从左向右书写或者从右向左书写
                NSVerticalGlyphFormAttributeName   设置文字排版方向，取值为NSNumber对象（整数），0表示横排文本，1表示竖排文本

                下划线、删除线支持的样式：
                typedef NS_ENUM(NSInteger, NSUnderlineStyle) {
                    NSUnderlineStyleNone                                    = 0x00,     不设置下划线
                    NSUnderlineStyleSingle                                  = 0x01,     细单实线
                    NSUnderlineStyleThick NS_ENUM_AVAILABLE(10_0, 7_0)      = 0x02,     粗单实线
                    NSUnderlineStyleDouble NS_ENUM_AVAILABLE(10_0, 7_0)     = 0x09,     细双实线

                    NSUnderlinePatternSolid NS_ENUM_AVAILABLE(10_0, 7_0)      = 0x0000, 实线
                    NSUnderlinePatternDot NS_ENUM_AVAILABLE(10_0, 7_0)        = 0x0100, 点线
                    NSUnderlinePatternDash NS_ENUM_AVAILABLE(10_0, 7_0)       = 0x0200, 虚线
                    NSUnderlinePatternDashDot NS_ENUM_AVAILABLE(10_0, 7_0)    = 0x0300, 点划线
                    NSUnderlinePatternDashDotDot NS_ENUM_AVAILABLE(10_0, 7_0) = 0x0400, 双点划线

                    NSUnderlineByWord NS_ENUM_AVAILABLE(10_0, 7_0)            = 0x8000
                } NS_ENUM_AVAILABLE(10_0, 6_0);
    context:    上下文（NSStringDrawingContext）
 */

/**
 *  此处的attribute是通过UILabel获取到的，内容有：
 *  NSFontAttributeName             : 文字大小
 *  NSForegroundColorAttributeName  : 文字颜色
 *  NSShadowAttributeName           : 阴影
 *  NSParagraphStyleAttributeName   : 段落样式
    其属性有：
        CGFloat lineSpacing;                       行间距
        CGFloat paragraphSpacing;                  段间距
        NSTextAlignment alignment;                 对齐方式
        CGFloat firstLineHeadIndent;               首行缩进
        CGFloat headIndent;                        除首行之外其他行缩进（尾部缩进）
        CGFloat tailIndent;                        每行容纳字符的宽度
        NSLineBreakMode lineBreakMode;             换行方式
        CGFloat minimumLineHeight;                 最小行高
        CGFloat maximumLineHeight;                 最大行高
        NSWritingDirection baseWritingDirection;   书写方式
        CGFloat lineHeightMultiple;                可变行高，乘因数
        CGFloat paragraphSpacingBefore;            段首空间
        float hyphenationFactor;                   连字符属性
        NSArray<NSTextTab *> *tabStops NS_AVAILABLE(10_0, 7_0);
        CGFloat defaultTabInterval NS_AVAILABLE(10_0, 7_0);
    BOOL allowsDefaultTighteningForTruncation NS_AVAILABLE(10_11, 9_0);
 */

#import "SizeToFitDemoHomeController.h"

#define DEFAULT_TEST_FONT [UIFont systemFontOfSize:15.0f]

@interface SizeToFitDemoHomeController () <UITextViewDelegate>

@property (nonatomic, strong) UITextView *inputTextView;
@property (nonatomic, copy)   NSString   *userInput;

@property (nonatomic, strong) UILabel *drawingUsesLineFragmentOriginLabel;
@property (nonatomic, strong) UILabel *drawingUsesFontLeadingLabel;
@property (nonatomic, strong) UILabel *drawingUsesDeviceMetricsLabel;
@property (nonatomic, strong) UILabel *drawingTruncatesLastVisibleLineLabel;

@property (nonatomic, strong) UILabel *sizeToFitLabel;

@end

@implementation SizeToFitDemoHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.drawingUsesLineFragmentOriginLabel         = [self createTestLabel];
    self.drawingUsesFontLeadingLabel                = [self createTestLabel];
    self.drawingUsesDeviceMetricsLabel              = [self createTestLabel];
    self.drawingTruncatesLastVisibleLineLabel       = [self createTestLabel];
    self.sizeToFitLabel                             = [self createTestLabel];
    
    [self.view addSubview:self.inputTextView];
    [self.view addSubview:self.drawingUsesLineFragmentOriginLabel];
    [self.view addSubview:self.drawingUsesFontLeadingLabel];
    [self.view addSubview:self.drawingUsesDeviceMetricsLabel];
    [self.view addSubview:self.drawingTruncatesLastVisibleLineLabel];
    [self.view addSubview:self.sizeToFitLabel];
}


- (void)textViewDidChange:(UITextView *)textView {
    self.userInput = textView.text ? textView.text : @"";
    
    self.drawingUsesLineFragmentOriginLabel.text   = self.userInput;
    self.drawingUsesFontLeadingLabel.text          = self.userInput;
    self.drawingUsesDeviceMetricsLabel.text        = self.userInput;
    self.drawingTruncatesLastVisibleLineLabel.text = self.userInput;
    self.sizeToFitLabel.text                       = self.userInput;
    
    [self.view setNeedsLayout];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGSize size;
    
    size = [self.userInput boundingRectWithSize:CGSizeMake(SCREENWIDTH / 2, MAXFLOAT)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName: DEFAULT_TEST_FONT}
                                        context:nil].size;
    self.drawingUsesLineFragmentOriginLabel.frame = CGRectMake(0, 100, size.width, size.height);
    
    size = [self.userInput boundingRectWithSize:CGSizeMake(SCREENWIDTH / 2, MAXFLOAT)
                                        options:NSStringDrawingUsesFontLeading
                                     attributes:@{NSFontAttributeName: DEFAULT_TEST_FONT}
                                        context:nil].size;
    self.drawingUsesFontLeadingLabel.frame = CGRectMake(SCREENWIDTH / 2, 100, size.width, size.height);
    
    size = [self.userInput boundingRectWithSize:CGSizeMake(SCREENWIDTH / 2, MAXFLOAT)
                                        options:NSStringDrawingUsesDeviceMetrics
                                     attributes:@{NSFontAttributeName: DEFAULT_TEST_FONT}
                                        context:nil].size;
    self.drawingUsesDeviceMetricsLabel.frame = CGRectMake(0, 200, size.width, size.height);
    
    size = [self.userInput boundingRectWithSize:CGSizeMake(SCREENWIDTH / 2, MAXFLOAT)
                                        options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName: DEFAULT_TEST_FONT}
                                        context:nil].size;
    self.drawingTruncatesLastVisibleLineLabel.frame = CGRectMake(SCREENWIDTH / 2, 200, size.width, size.height);
    
    CGSize fitSize = [self.sizeToFitLabel sizeThatFits:CGSizeMake(SCREENWIDTH / 2, MAXFLOAT)];
    ZCPLog(@"fitSize: %f %f", fitSize.width, fitSize.height);
    [self.sizeToFitLabel sizeToFit];
    self.sizeToFitLabel.frame = CGRectMake(0, 300, SCREENWIDTH, self.sizeToFitLabel.frame.size.height);
}

#pragma mark - factory method

- (UILabel *)createTestLabel {
    UILabel *label          = [[UILabel alloc] init];
    label.backgroundColor   = [UIColor lightGrayColor];
    label.textColor         = [UIColor orangeColor];
    label.numberOfLines     = 0;
    label.font              = DEFAULT_TEST_FONT;
    label.layer.borderColor = [UIColor redColor].CGColor;
    label.layer.borderWidth = 1.0f;
    return label;
}

#pragma mark - getter / setter

- (UITextView *)inputTextView {
    if (!_inputTextView) {
        _inputTextView                  = [[UITextView alloc] init];
        _inputTextView.frame            = CGRectMake(0, 20, SCREENWIDTH, 50);
        _inputTextView.backgroundColor  = [UIColor lightGrayColor];
        _inputTextView.delegate         = self;
    }
    return _inputTextView;
}

@end
