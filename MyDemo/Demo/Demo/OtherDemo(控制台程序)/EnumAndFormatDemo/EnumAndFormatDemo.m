//
//  EnumAndFormatDemo.m
//  Demo
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "EnumAndFormatDemo.h"

@implementation EnumAndFormatDemo

- (void)run {
#pragma mark - 移位枚举的使用
    printf("%li %li %li\n", Red, Green, Blue);
    
    enum SelectedColor myColor = Red | Blue;
    printf("Red:%d Green:%d Blue:%d\n", (myColor & Red) == Red, (myColor & Green) == Green, (myColor & Blue) == Blue);
    
#pragma mark - 输出格式
    // 2 8 16 进制输出 10进制
    printf("-->10: %d %d %d\n", 0b10001000, 017,0xffff);
    // 10 进制输出 2 8 16进制
    printf("10-->: %s %o %x\n", print_bin(13), 20, 30);
    // size_t类型
    printf("%zu\n", sizeof(8));

}

@end

/**
 *  打印二进制
 *
 *  @param n int_number
 */
char * print_bin(int n) {
    int l = sizeof(n) * 8;//总位数。
    int i;
    if (l == 0) {
        printf("0");
        return "";
    }
    for (i = l - 1; i >= 0; i --) { //略去高位0.
        if( n & (1 << i)) {
            break;
        }
    }
    
    char *result = malloc(sizeof(char) * 100);
    for (int index = 0; i>=0 ; i --, index ++) {
        result[index] = ((n & (1 << i)) != 0) + '0';
    }
    return result;
}
