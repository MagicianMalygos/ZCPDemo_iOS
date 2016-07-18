//
//  ZCPRecogniseQRCode.h
//  Demo
//
//  Created by 朱超鹏(外包) on 16/7/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

// 识别二维码类
@interface ZCPRecogniseQRCode : NSObject

// 通过UIImage得到相关二维码信息
+ (NSString *)recogniseFromUIImage:(UIImage *)image;

@end
