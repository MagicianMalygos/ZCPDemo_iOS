//
//  UIImage+Runtime.m
//  Demo
//
//  Created by 朱超鹏(外包) on 17/2/13.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "UIImage+Runtime.h"

@implementation UIImage (Runtime)

/* method swizzling，替换方法实现
 需求：需要针对不同的iOS版本来使用不同的切图，版本在iOS7以上的使用“_ios7”后缀的图片，以下的使用不带后缀的图片。
 问题：在项目中存在很多的imageNamed:方法时，工作量比较大，如果此时时间比较赶，则可以使用这种方法。
 注意：项目中是否有第三方库也修改了imageNamed:的实现，需要测试是否存在异常；后期维护比较容易出现问题，如果有人在不知情的情况下也同事在项目中用这种方式进行处理则会导致问题；另外这种方法治标不治本，有导致异常问题的风险，在有时间的时候最好修改为使用自定义方法处理。
 */

+ (void)openUIImageRuntimeTest {
    // 将imageNamed:方法和custom_imageNamed:方法的实现交换
    Method m1 = class_getClassMethod([UIImage class], @selector(imageNamed:));
    Method m2 = class_getClassMethod([UIImage class], @selector(custom_imageNamed:));
    method_exchangeImplementations(m1, m2);
}

+ (UIImage *)custom_imageNamed:(NSString *)name {
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    if (version >= 9.0) {
        name = [name stringByAppendingString:@"_ios9"];
    }
    // 在方法实现交换后，调用custom_imageNamed:方法实际执行了imageNamed:方法的实现
    return [UIImage custom_imageNamed:name];
}

@end
