//
//  CASection1Demo.m
//  Demo
//
//  Created by 朱超鹏 on 2018/8/9.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "CASection1Demo.h"

@implementation CASection1Demo

// ----------------------------------------------------------------------
#pragma mark - demo
// ----------------------------------------------------------------------

#pragma mark 使用图层
- (void)demo1 {
    // CALayer和UIView最大的不同是CALyer不处理用户的交互
    // 但是为什么iOS要基于UIView和CALayer提供两个平行的层级关系呢？为什么不用一个简单的层级来处理所有事情呢？原因在于要做职责分离，这样也能避免很多重复代码。在iOS和Mac OS两个平台上，事件和用户交互有很多不同的地方，基于多点触控的用户界面和基于鼠标键盘有着本质的区别，这就是为什么iOS有UIKit和UIView，但是Mac OS有AppKit和NSView的原因。他们功能上很相似，但是在实现上有着显著的区别。
    CALayer *blueLayer          = [CALayer layer];
    blueLayer.frame             = CGRectMake(0, 0, 200, 200);
    blueLayer.position          = self.center;
    blueLayer.backgroundColor   = [UIColor blueColor].CGColor;
    [self.layer addSublayer:blueLayer];
}

@end
