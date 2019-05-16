//
//  ZCPLDFrameTagsView.h
//  Demo
//
//  Created by zcp on 2019/5/14.
//  Copyright © 2019 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZCPLDFrameTagsView : UIView

@property (nonatomic, copy) NSArray *tags;
@property (nonatomic, assign, readonly) CGFloat fitViewHeight;

@end

NS_ASSUME_NONNULL_END
