//
//  ZCPGenerateQRCode.h
//  Demo
//
//  Created by apple on 16/6/12.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

// 生成二维码类
@interface ZCPGenerateQRCode : NSObject

// 根据string生成二维码图片
+ (UIImage *)generateQRCodeWithString:(NSString *)string;
// 将UIImage中黑色的内容转换成参数对应的RGB颜色
+ (UIImage *)imageBlackToTransparent:(UIImage *)image withRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
// 给UIImageView添加阴影(暂时没效果)
+ (void)addShadow:(UIColor *)color forImageView:(UIImageView *)imageView;

@end
