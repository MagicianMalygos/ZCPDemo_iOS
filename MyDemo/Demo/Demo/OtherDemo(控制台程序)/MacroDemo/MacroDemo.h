//
//  MacroDemo.h
//  Demo
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MacroDemo : NSObject

- (void)run;

@end

/*
 1. @#      字符化操作符
 将传入的单字符参数名转换成字符，以一对单引号括起来
 2. #       字符串化操作符
 将传入的参数名转换成字符串，以一对双引号括起来
 3. ##      符号连接操作符
 将宏定义的多个形参名连接成一个实际参数名
 4. \       行继续操作符
 当定义的宏不能用一行表达完整时，可以用\表示下一行继续此宏的定义
 5. do{}while(0)或{}
 避免出错
 */

// 转char
#define CHAR(c)     @#c
// 转string
#define STRING(s)   #s

// 定义变量宏
#define DEFINITION(type, name) type name##_##type;
// 使用行继续符
#define MAX_AB(a, b) \
if (a > b) {    \
NSLog(@"%d > %d", a, b);    \
}   \
else {  \
NSLog(@"%d >= %d", b, a);    \
}

// 使用do{...} while(0)或{}
#define PRINT \
NSLog(@"msg1"); \
NSLog(@"msg2");

#define PRINT2 \
{   \
NSLog(@"msg1"); \
NSLog(@"msg2"); \
}

// 方法执行耗时
// while(_0Ti-- > 0): 当_0Ti>0时自减1
#define TEST_FUNC_SPEED(f,n) \
do {\
clock_t _0Ts;\
double _0Tt;\
int _0Ti, _0Tc;\
_0Ti = _0Tc = (n);\
_0Ts = clock();\
while (_0Ti-- > 0) (f);\
_0Tt = (clock() - _0Ts) / (double)CLOCKS_PER_SEC;\
printf("%s %d times: %f second%s\n", #f, _0Tc, _0Tt, _0Tt > 1 ? "s": "");\
} while (0)
