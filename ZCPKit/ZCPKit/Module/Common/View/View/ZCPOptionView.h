//
//  ZCPOptionView.h
//  Apartment
//
//  Created by apple on 16/1/21.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

// 选项视图默认高度
#define OPTION_VIEW_DEFAULT_HEIGHT  35.0f

@protocol ZCPOptionViewDelegate;

// ----------------------------------------------------------------------
#pragma mark - 类似SegmentView的选项卡视图
// ----------------------------------------------------------------------
@interface ZCPOptionView : UIView

@property (nonatomic, strong) NSMutableArray *optionItemLabelArr;   // 各选项label数组
@property (nonatomic, strong) UIView *markView;                     // 会滑动的标记视图
@property (nonatomic, strong) UIView *lineView;                     // 底部分割线视图
@property (nonatomic, assign) NSInteger currentSelectedLabelTag;    // 当前选中label标识

@property (nonatomic, assign) BOOL markViewMoving;                  // markView是否正在移动，防止点击label移动和使用偏移量移动产生冲突

@property (nonatomic, weak) id<ZCPOptionViewDelegate> delegate;     // delegate

/**
 *  实例化方法
 *
 *  @param frame      frame
 *  @param attrStrArr 选项富文本
 *
 *  @return 选项视图
 */
- (instancetype)initWithFrame:(CGRect)frame attributeStringArr:(NSArray *)attrStrArr;
/**
 *  通过传参AttributedString数组设置label
 *
 *  @param attrStrArr AttributedString数组
 */
- (void)setLabelArrWithAttributeStringArr:(NSArray *)attrStrArr;
/**
 *  移动MarkView
 *
 *  @param index 所要移动到的下标位置
 */
- (void)moveMarkViewToIndex:(NSInteger)index;
/**
 *  移动MarkView，使用偏移量
 *
 *  @param offsetX 传递的偏移量
 *  @param range   传递的偏移量范围
 */
- (void)moveMarkViewByOffsetX:(CGFloat)offsetX offsetRange:(NSRange)range;
/**
 *  隐藏MarkView
 */
- (void)hideMarkView;
/**
 *  隐藏LineView
 */
- (void)hideLineView;

/**
 *  触发选项
 *
 *  @param index 选项索引
 */
- (void)triggerOptionWithIndex:(NSInteger)index;

@end


#pragma mark - Protocol
@protocol ZCPOptionViewDelegate <NSObject>

@optional
/**
 *  label点击事件
 *
 *  @param label 被点击的label
 *  @param index 被点击的label的索引号
 */
- (void)label:(UILabel *)label didSelectedAtIndex:(NSInteger)index;
/**
 *  label点击事件，动画将要开始时
 *
 *  @param label 被点击的label
 *  @param index 被点击label的索引号
 */
- (void)label:(UILabel *)label animateWillBeginDidSelectedAtIndex:(NSInteger)index;
/**
 *  label点击事件，动画将要结束时
 *
 *  @param label 被点击的label
 *  @param index 被点击的label的索引号
 */
- (void)label:(UILabel *)label animateWillEndDidSelectedAtIndex:(NSInteger)index;

@end
