//
//  ZCPLDStackEntranceView.m
//  Demo
//
//  Created by zcp on 2019/5/14.
//  Copyright © 2019 zcp. All rights reserved.
//

#import "ZCPLDStackEntranceView.h"
#import "ZCPLDCommon.h"

@implementation ZCPLDStackEntranceView

- (void)setEntranceArr:(NSArray *)entranceArr {
    _entranceArr = entranceArr;
    [self updateView];
}

- (void)updateView {
    [self removeAllSubviews];
    CGFloat viewHeight = 150;
    
    NSMutableArray *entranceViewArr = [NSMutableArray array];
    for (NSString *title in self.entranceArr) {
        ZCPLDEntranceView *entranceView = [[ZCPLDEntranceView alloc] init];
        [entranceView.widthAnchor constraintEqualToConstant:50].active = YES;
        [entranceView.heightAnchor constraintEqualToConstant:150].active = YES;
        
        entranceView.titleLabel.text = title;
        [entranceViewArr addObject:entranceView];
    }
    
    UIStackView *stack = [[UIStackView alloc] initWithArrangedSubviews:entranceViewArr];
    stack.axis = UILayoutConstraintAxisHorizontal;
    stack.alignment = UIStackViewAlignmentFill;
    stack.distribution = UIStackViewDistributionFillEqually;
    stack.spacing = 10;
    stack.translatesAutoresizingMaskIntoConstraints = NO;
    stack.frame = CGRectMake(0, 0, SCREENWIDTH, 150);
    [self addSubview:stack];
    
    _fitViewHeight = viewHeight;
}

@end
