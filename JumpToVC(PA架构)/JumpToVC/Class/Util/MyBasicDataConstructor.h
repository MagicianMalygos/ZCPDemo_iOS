//
//  MyBasicDataConstructor.h
//  JumpToVC
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyBasicDataConstructor : NSObject

#pragma mark - property
// 数据数组
@property (nonatomic, strong) NSMutableArray *items;


/**
 *  构造数据，由子类实现该方法
 */
- (void)constructData;

@end
