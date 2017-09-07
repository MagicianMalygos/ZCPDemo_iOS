//
//  ZCPOptionView.m
//  Apartment
//
//  Created by apple on 16/1/21.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPOptionView.h"
#import "ZCPCategory.h"

@interface ZCPOptionView ()

@property (nonatomic, assign) NSInteger labelCount;

@end

@implementation ZCPOptionView

// ----------------------------------------------------------------------
#pragma mark - synthesize
// ----------------------------------------------------------------------
@synthesize optionItemLabelArr          = _optionItemLabelArr;
@synthesize markView                    = _markView;
@synthesize lineView                    = _lineView;
@synthesize currentSelectedLabelTag     = _currentSelectedLabelTag;
@synthesize markViewMoving              = _markViewMoving;
@synthesize delegate                    = _delegate;

// ----------------------------------------------------------------------
#pragma mark - init
// ----------------------------------------------------------------------
- (instancetype)initWithFrame:(CGRect)frame attributeStringArr:(NSArray *)attrStrArr {
    if (self = [super init]) {
        self.frame = frame;
        [self setLabelArrWithAttributeStringArr:attrStrArr];
    }
    return self;
}

// ----------------------------------------------------------------------
#pragma mark - public method
// ----------------------------------------------------------------------
- (void)setLabelArrWithAttributeStringArr:(NSArray *)attrStrArr {
    if (attrStrArr == nil || attrStrArr.count <= 0) {
        return;
    }
    
    self.labelCount = attrStrArr.count;
    self.optionItemLabelArr = [NSMutableArray arrayWithCapacity:self.labelCount];
    NSInteger perWidth = self.frame.size.width / self.labelCount;
    for (int i = 0; i < self.labelCount; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * perWidth, 0, perWidth, self.height - 4)];
        [label setAttributedText:[attrStrArr objectAtIndex:i]];
        label.textAlignment = NSTextAlignmentCenter;
        // 设置标识
        label.tag = i;
        // 添加点击手势
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClicked:)]];
        label.userInteractionEnabled = YES;
        [self addSubview:label];
        [self.optionItemLabelArr addObject:label];
    }
    
    // 初始化markView
    self.currentSelectedLabelTag = 0;
    self.markView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 4, perWidth, 4)];
    self.markView.backgroundColor = [UIColor colorFromHexRGB:@"ff8447"];
    [self addSubview:self.markView];
    
    // 初始化lineView
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height, self.width, -OnePixel)];
    self.lineView.backgroundColor = [UIColor colorFromHexRGB:@"dfdfdf"];
    [self addSubview:self.lineView];
}
/**
 *  移动MarkView，使用下标值
 *
 *  @param index 所要移动到的下标位置
 */
- (void)moveMarkViewToIndex:(NSInteger)index {
    self.currentSelectedLabelTag = index;
    NSInteger perWidth = self.frame.size.width / self.labelCount;
    self.markView.frame = CGRectMake(self.currentSelectedLabelTag * perWidth, self.markView.y, perWidth, 3);
}
/**
 *  移动MarkView，使用偏移量
 *
 *  @param offsetX 传递的偏移量
 *  @param range   传递的偏移量范围
 */
- (void)moveMarkViewByOffsetX:(CGFloat)offsetX offsetRange:(NSRange)range {
    
    CGFloat markViewOffsetXMax = self.width - self.markView.width;    // 计算markView最大偏移量
    
    // 处理偏移量超出range的情况
    if (offsetX < range.location) {
        [self.markView setX:0];
    }
    else if (offsetX > range.location + range.length) {
        [self.markView setX:markViewOffsetXMax];
    }
    else {
        CGFloat offsetXRate = (offsetX - range.location) / range.length;  // 计算偏移比率
        CGFloat markViewOffsetX = markViewOffsetXMax * offsetXRate;       // 计算markView偏移量
        
        [self.markView setX:markViewOffsetX];
    }
}
/**
 *  隐藏MarkView
 */
- (void)hideMarkView {
    self.markView.hidden = YES;
}
/**
 *  隐藏LineView
 */
- (void)hideLineView {
    self.lineView.hidden = YES;
}

/**
 *  触发选项
 *
 *  @param index 选项索引
 */
- (void)triggerOptionWithIndex:(NSInteger)index {
    UILabel *currentSelectedLabel = [self.optionItemLabelArr objectAtIndex:index];
    
    [UIView animateWithDuration:0.5f animations:^{
        // TODO: 此处可进行设置如果markView隐藏了，不进行移动
        [self moveMarkViewToIndex:currentSelectedLabel.tag];
        if (self.delegate && [self.delegate respondsToSelector:@selector(label:animateWillBeginDidSelectedAtIndex:)]) {
            [self.delegate label:currentSelectedLabel animateWillBeginDidSelectedAtIndex:self.currentSelectedLabelTag];
        }
    } completion:^(BOOL finished) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(label:animateWillEndDidSelectedAtIndex:)]) {
            [self.delegate label:currentSelectedLabel animateWillEndDidSelectedAtIndex:self.currentSelectedLabelTag];
        }
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(label:didSelectedAtIndex:)]) {
        [self.delegate label:currentSelectedLabel didSelectedAtIndex:self.currentSelectedLabelTag];
    }
}

// ----------------------------------------------------------------------
#pragma mark - Tap GestureRecognizer
// ----------------------------------------------------------------------
- (void)labelClicked:(UITapGestureRecognizer *)tap {
    UILabel *currentSelectedLabel = (UILabel *)[tap view];
    
    [UIView animateWithDuration:0.5f animations:^{
        // TODO: 此处可进行设置如果markView隐藏了，不进行移动
        [self moveMarkViewToIndex:currentSelectedLabel.tag];
        if (self.delegate && [self.delegate respondsToSelector:@selector(label:animateWillBeginDidSelectedAtIndex:)]) {
            [self.delegate label:currentSelectedLabel animateWillBeginDidSelectedAtIndex:self.currentSelectedLabelTag];
        }
    } completion:^(BOOL finished) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(label:animateWillEndDidSelectedAtIndex:)]) {
            [self.delegate label:currentSelectedLabel animateWillEndDidSelectedAtIndex:self.currentSelectedLabelTag];
        }
    }];

    if (self.delegate && [self.delegate respondsToSelector:@selector(label:didSelectedAtIndex:)]) {
        [self.delegate label:currentSelectedLabel didSelectedAtIndex:self.currentSelectedLabelTag];
    }
}

@end
