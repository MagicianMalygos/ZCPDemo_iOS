//
//  ZCPBasicDataConstructor.h
//  Apartment
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>


// 基础数据构造器
@interface ZCPBasicDataConstructor : NSObject

// 用来存放构造出来的数据
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, weak) id responder;

/**
 *  构造数据方法，由子类来实现此方法
 */
- (void)constructData;

@end
