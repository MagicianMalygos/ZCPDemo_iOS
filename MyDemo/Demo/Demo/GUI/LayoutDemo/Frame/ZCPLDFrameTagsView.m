//
//  ZCPLDFrameTagsView.m
//  Demo
//
//  Created by zcp on 2019/5/14.
//  Copyright © 2019 zcp. All rights reserved.
//

#import "ZCPLDFrameTagsView.h"
#import "ZCPLDCommon.h"

@implementation ZCPLDFrameTagsView

@synthesize fitViewHeight = _fitViewHeight;

- (void)setTags:(NSArray *)tags {
    _tags = tags;
    [self updateView];
}

- (void)updateView {
    [self removeAllSubviews];
    
    CGFloat hMargin = 20;
    CGFloat vMargin = 10;
    CGFloat hGap = 5;
    CGFloat vGap = 5;
    CGFloat tagH = 30;
    CGFloat tagPadding = 5;
    
    CGFloat availableW = self.width - hMargin*2;
    CGFloat availableWMax = self.width - hMargin*2;
    CGFloat viewHeight = (self.tags.count > 0) ? vMargin*2 + tagH : 0;
    
    CGFloat currTop = vMargin;
    CGFloat currLeft = hMargin;
    
    for (NSString *tag in self.tags) {
        CGFloat tagW = [tag boundingRectWithSize:CGSizeMake(availableWMax, 30) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size.width + tagPadding*2;
        
        ZCPLDTagView *tagLabel = [[ZCPLDTagView alloc] init];
        tagLabel.text = tag;
        [self addSubview:tagLabel];
        
        if (tagW > availableW) {
            currTop += vGap + tagH;
            currLeft = hMargin;
            
            tagLabel.frame = CGRectMake(currLeft, currTop, tagW, tagH);
            
            availableW = availableWMax - tagW - hGap;
            currLeft = currLeft + tagW + hGap;
            viewHeight += vGap + tagH;
        } else if (tagW <= availableW) {
            tagLabel.frame = CGRectMake(currLeft, currTop, tagW, tagH);
            availableW = availableW - tagW - hGap;
            currLeft = currLeft + tagW + hGap;
        }
    }
    _fitViewHeight = viewHeight;
}

@end
