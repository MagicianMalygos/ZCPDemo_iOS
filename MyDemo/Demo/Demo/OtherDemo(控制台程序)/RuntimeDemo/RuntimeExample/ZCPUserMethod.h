//
//  ZCPUserMethod.h
//  Demo
//
//  Created by 朱超鹏(外包) on 17/2/15.
//  Copyright © 2017年 zcp. All rights reserved.
//

#pragma mark - ZCPUser method

// 每个方法都有这两个隐式参数
void eat(id self, SEL sel) {
    ZCPLog(@"%@ 调用了 %@ 方法", self, NSStringFromSelector(sel));
}
