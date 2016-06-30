//
//  SizeToFitDemoHomeController.m
//  SizeToFit
//
//  Created by apple on 15/11/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SizeToFitDemoHomeController.h"

@interface SizeToFitDemoHomeController () <UITextViewDelegate>

@property (nonatomic, weak) UILabel *label;
@property (nonatomic, weak) UILabel *label2;
@property (nonatomic, weak) UILabel *label3;
@property (nonatomic, weak) UILabel *labelTest1;
@property (nonatomic, weak) UILabel *labelTest2;
@property (nonatomic, weak) UILabel *labelTest3;
@property (nonatomic, weak) UITextView *textView;

@end

@implementation SizeToFitDemoHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // textView
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 20, SCREENWIDTH, 50)];
    [textView setBackgroundColor:[UIColor lightGrayColor]];
    textView.delegate = self;
    self.textView = textView;
    [self.view addSubview:self.textView];
    
    // label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, SCREENWIDTH, 0)];
    [label setBackgroundColor:[UIColor lightGrayColor]];
    [label setTextColor:[UIColor orangeColor]];
    [label setNumberOfLines:0];
    [label setFont:[UIFont systemFontOfSize:15.0f weight:20.0f]];
    self.label = label;
    [self.view addSubview:self.label];
    
    // label2
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, SCREENWIDTH, 0)];
    [label2 setBackgroundColor:[UIColor lightGrayColor]];
    [label2 setTextColor:[UIColor orangeColor]];
    [label2 setNumberOfLines:0];
    [label2 setFont:[UIFont systemFontOfSize:15.0f weight:20.0f]];
    self.label2 = label2;
    [self.view addSubview:self.label2];
    
    // label3
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, SCREENWIDTH, 0)];
    [label3 setBackgroundColor:[UIColor lightGrayColor]];
    [label3 setTextColor:[UIColor orangeColor]];
    [label3 setNumberOfLines:0];
    [label3 setFont:[UIFont systemFontOfSize:15.0f weight:20.0f]];
    self.label3 = label3;
    [self.view addSubview:self.label3];
    
    // Height Method Test Label
    UILabel *labelTest1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 250, SCREENWIDTH, 0)];
    labelTest1.backgroundColor = [UIColor lightGrayColor];
    labelTest1.textColor = [UIColor orangeColor];
    labelTest1.numberOfLines = 0;
    labelTest1.font = [UIFont systemFontOfSize:15.0f weight:20.0f];
    self.labelTest1 = labelTest1;
    [self.view addSubview:self.labelTest1];
    
    UILabel *labelTest2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, SCREENWIDTH, 0)];
    labelTest2.backgroundColor = [UIColor lightGrayColor];
    labelTest2.textColor = [UIColor orangeColor];
    labelTest2.numberOfLines = 0;
    labelTest2.font = [UIFont systemFontOfSize:15.0f weight:20.0f];
    self.labelTest2 = labelTest2;
    [self.view addSubview:self.labelTest2];
    
    UILabel *labelTest3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 350, SCREENWIDTH, 0)];
    labelTest3.backgroundColor = [UIColor lightGrayColor];
    labelTest3.textColor = [UIColor orangeColor];
    labelTest3.numberOfLines = 0;
    labelTest3.font = [UIFont systemFontOfSize:15.0f weight:20.0f];
    self.labelTest3 = labelTest3;
    [self.view addSubview:self.labelTest3];
}


- (void)textViewDidChange:(UITextView *)textView {
    [self.label setText:textView.text];
    
    // label
    CGFloat labelHeight = [self calculateLabelHeightWithString:self.label.text];
    [self.label setFrame:CGRectMake(self.label.frame.origin.x, self.label.frame.origin.y, self.label.width, labelHeight)];
    
    // label2
    [self.label2 setText:textView.text];
    CGSize size = [self.label2 sizeThatFits:CGSizeMake(SCREENWIDTH, CGFLOAT_MAX)/*CGSizeMake(WIDTH, CGFLOAT_MAX)*/];
    [self.label2 setFrame:CGRectMake(self.label2.frame.origin.x, self.label2.frame.origin.y, size.width, size.height)];
    
    // label3
    [self.label3 setText:textView.text];
    [self.label3 sizeToFit];  // 当前视图边界和边界大小变化。(自动根据文本的长度改变自身的长度)
    
    // Height Method Test Label
    [self.labelTest1 setText:textView.text];
    CGFloat height1 = [self calculateLabelHeightWithString:self.labelTest1.text attributes:self.labelTest1.attributedText.attributes];
    self.labelTest1.frame = CGRectMake(self.labelTest1.frame.origin.x, self.labelTest1.frame.origin.y, self.labelTest1.width, height1);
    
    [self.labelTest2 setText:textView.text];
    CGFloat height2 = [self calculateLabelHeightWithAttributedString:self.labelTest2.attributedText];
    self.labelTest2.frame = CGRectMake(self.labelTest2.frame.origin.x, self.labelTest2.frame.origin.y, self.labelTest2.width, height2);
    
    [self.labelTest3 setText:textView.text];
    CGFloat height3 = [self calculateLabelHeightWithLabel:self.labelTest3];
    self.labelTest3.frame = CGRectMake(self.labelTest3.frame.origin.x, self.labelTest3.frame.origin.y, self.labelTest3.width, height3);
}

// 计算label高度，可以写一个NSAttributedString的分类，此方法作为分类方法，传NSAttributedString类型的参数，然后获取属性字典进行计算
- (CGFloat)calculateLabelHeightWithString:(NSString *)string {
    
    // 1.宽高限制，用于计算文本绘制时占据的矩形块
    CGSize maxLimitSize = CGSizeMake(SCREENWIDTH, CGFLOAT_MAX);
    
    /* 2.option：
    NSStringDrawingOptions：
        NSStringDrawingUsesLineFragmentOrigin：以每行组成的矩形为单位计算整个文本的尺寸
        NSStringDrawingUsesFontLeading：使用行距计算行高。行距 = 字体大小 + 行间距，从一行文字的底部到下一行文字的底部距离
        NSStringDrawingUsesDeviceMetrics：计算布局时使用图元字形（而不是印刷字体）
        NSStringDrawingTruncatesLastVisibleLine：计算文本尺寸时将以每个字或字形为单位来计算。如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号，如果没有指定NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略。
     */
    
    
    /**
     *  3.获取attrString的属性字典
     *  属性字典key有：
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
     
     */
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f weight:20.0f]}];
    NSRange range = NSMakeRange(0, attrString.length);
    NSDictionary *dict = [attrString attributesAtIndex:0 effectiveRange:&range];
    NSLog(@"属性字典：%@", dict);
    
    // 4.context 上下文
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    context.minimumScaleFactor = 0.5;
    
    // 5.方法返回文本绘制所占据的矩形空间
    CGRect rect = [string boundingRectWithSize:maxLimitSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:context];
    
    return rect.size.height;
}


#pragma mark - 计算高度方法

#pragma mark string类型
- (CGFloat)calculateLabelHeightWithString:(NSString *)string attributes:(NSDictionary *)attributes {
    CGSize maxLimitSize = CGSizeMake(SCREENWIDTH, MAXFLOAT);
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    
    /**
     *  此处的attribute是通过UILabel获取到的，内容有：
     *  NSFont              : 文字大小
     *  NSColor             : 文字颜色
     *  NSShadow            : 阴影
     *  NSParagraphStyle    : 段落样式
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
    
    CGRect rect = [string boundingRectWithSize:maxLimitSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{@"NSFont": [attributes valueForKey:@"NSFont"], @"NSColor": [attributes valueForKey:@"NSColor"], @"NSShadow": [attributes valueForKey:@"NSShadow"]} context:context];
    return rect.size.height;
}

#pragma mark 富文本类型
- (CGFloat)calculateLabelHeightWithAttributedString:(NSAttributedString *)attributedString {
    CGSize maxLimitSize = CGSizeMake(SCREENWIDTH, MAXFLOAT);
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    
    CGRect rect = [attributedString boundingRectWithSize:maxLimitSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:context];
    return rect.size.height;
}

#pragma mark UI类型
- (CGFloat)calculateLabelHeightWithLabel:(UILabel *)label {
    CGSize maxLimitSize = CGSizeMake(SCREENWIDTH, MAXFLOAT);
    
    NSString *string = label.text;
    NSAttributedString *attributedString = label.attributedText;
    NSRange range = NSMakeRange(0, attributedString.length);
    NSDictionary *attributes = [attributedString attributesAtIndex:0 effectiveRange:&range];
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    
    CGRect rect = [string boundingRectWithSize:maxLimitSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:context];
    return rect.size.height;
}


// 缩回键盘
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
