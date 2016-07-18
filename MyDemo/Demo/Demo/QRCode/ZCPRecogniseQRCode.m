//
//  ZCPRecogniseQRCode.m
//  Demo
//
//  Created by 朱超鹏(外包) on 16/7/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRecogniseQRCode.h"

@implementation ZCPRecogniseQRCode

#pragma mark 通过UIImage得到相关二维码信息
+ (NSString *)recogniseFromUIImage:(UIImage *)image {
    if (!image) {
        return nil;
    }
    
    NSString *resultInfo = nil;
    
    // 从选中的图片中读取二维码数据
    // 创建检测器，检测类型为二维码
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
    
    // 进行检测
    NSArray *feature = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    if (feature.count != 0) {
        // 2.3取出检测结果数据
        for (CIQRCodeFeature *result in feature) {
            resultInfo = result.messageString;
        }
    }
    return resultInfo;
}

@end
