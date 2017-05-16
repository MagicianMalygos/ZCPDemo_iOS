//
//  ZCPUserMethod.h
//  Demo
//
//  Created by 朱超鹏(外包) on 17/2/15.
//  Copyright © 2017年 zcp. All rights reserved.
//

#pragma mark - ZCPUser method

//


/**
 每个实例方法都有 self和 sel这两个隐式参数

 @param self 实例对象
 @param sel  类实例方法指针，特指本方法
 */

void eat(id self, SEL sel) {
    ZCPLog(@"%@类的实例 调用了 %@ 方法", NSStringFromClass([self class]), NSStringFromSelector(sel));
}


void privilegeList(id self, SEL sel) {
    ZCPLog(@"%@类的成员享有以下优惠特权：1、X；2、Y；3、Z", NSStringFromClass([self class]));
}
