//
//  NSDateFormatter+ExtraMethod.h
//  haofang
//
//  Created by leo on 14-9-5.
//  Copyright (c) 2014年 平安好房. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (ExtraMethod)

// 创建DateFormatter很耗时间，所以创建一个静态的DateFormatter共用
+ (NSDateFormatter *)staticDateFormatter;

@end
