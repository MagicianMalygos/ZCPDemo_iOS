//
//  MacroDemo.m
//  Demo
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "MacroDemo.h"

@implementation MacroDemo

- (void)run {
    NSLog(@"%@", CHAR(1));
    NSLog(@"%s", STRING(Hello world!));
    
    DEFINITION(int, number)
    number_int = 2;
    
    MAX_AB(1, 2)
    
    if (0) PRINT;
    if (0) PRINT2;
    
    TEST_FUNC_SPEED(strlen("hello world!"), 100000000);
}

@end
