//
//  EnumAndFormatDemo.h
//  Demo
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnumAndFormatDemo : NSObject

- (void)run;

@end

NS_ENUM (NSInteger, SelectedColor) {
    Red     = 1,        // 0b0001
    Green   = 1 << 1,   // 0b0010
    Blue    = 1 << 2    // 0b0100
};

char * print_bin(int n);

