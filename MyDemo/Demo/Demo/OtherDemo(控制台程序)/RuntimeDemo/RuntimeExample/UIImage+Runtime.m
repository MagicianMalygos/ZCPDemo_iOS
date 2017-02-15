//
//  UIImage+Runtime.m
//  Demo
//
//  Created by 朱超鹏(外包) on 17/2/13.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "UIImage+Runtime.h"

@implementation UIImage (Runtime)

+ (UIImage *)custom_imageNamed:(NSString *)name {
    
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    if (version >= 7.0) {
        name = [name stringByAppendingString:@"_ios7"];
    }
    
    // 在方法实现交换后，调用custom_imageNamed:方法实际执行了imageNamed:方法的实现
    return [UIImage custom_imageNamed:name];
}

+ (void)openRuntimeTest {
    // 将imageNamed:方法和custom_imageNamed:方法的实现交换
    Method m1 = class_getClassMethod([UIImage class], @selector(imageNamed:));
    Method m2 = class_getClassMethod([UIImage class], @selector(custom_imageNamed:));
    method_exchangeImplementations(m1, m2);
}

@end
