//
//  Line.h
//  Demo
//
//  Created by zhuchaopeng on 16/10/10.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Line : NSObject

@property (nonatomic, assign) CGPoint begin;
@property (nonatomic, assign) CGPoint end;
@property (nonatomic, copy)   NSString *color;

@end
