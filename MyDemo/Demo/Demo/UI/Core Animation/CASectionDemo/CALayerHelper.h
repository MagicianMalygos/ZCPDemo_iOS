//
//  CALayerHelper.h
//  Demo
//
//  Created by 朱超鹏 on 2018/8/19.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

/// layer辅助类
@interface CALayerHelper : NSObject <CALayerDelegate>

DEF_SINGLETON

@end

/// layer标记分类
@interface CALayer (CADemoTag)

@property (nonatomic, copy, nullable) NSString *caDemoTag;

@end
