//
//  ZCPGenerateQRCode.m
//  Demo
//
//  Created by apple on 16/6/12.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPGenerateQRCode.h"

@implementation ZCPGenerateQRCode

#pragma mark 生成黑白二维码
+ (UIImage *)generateQRCodeWithString:(NSString *)string {
    if (!string || [string isEqualToString:@""]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"生成二维码的信息不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        
        [[[UIApplication sharedApplication].delegate window].rootViewController presentViewController:alertController animated:YES completion:nil];
        
        return nil;
    }
    
    // 二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 设置滤镜属性为默认值
    [filter setDefaults];
    // 将字符串装换成NSData
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    // 通过KVO设置滤镜inuptMessage数据
    [filter setValue:data forKey:@"inputMessage"];
    // 获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    // 将CIImage转换成UIImage，并放大显示
    UIImage *image = [ZCPGenerateQRCode getNonInterpolatedUIImageFromCIImage:outputImage size:200];
    
    return image;
}

#pragma mark 通过CIImage获得指定大小的非差值图像
+ (UIImage *)getNonInterpolatedUIImageFromCIImage:(CIImage *)ciImage size:(CGFloat)size {
    // CGRectIntegral函数，将十进制值转换为近似等值的整数， {0, 15.6, 16.1, 20.2} -> {0, 15, 17, 20}
    // CIImage没有bounds和frame属性，只有extent属性
    CGRect extent = CGRectIntegral(ciImage.extent);
    
    CGFloat scale = MIN(size/ CGRectGetWidth(extent), size / CGRectGetHeight(extent));
    
    // 创建bitmap
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef csRef = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, csRef, (CGBitmapInfo)kCGImageAlphaNone);
    CGColorSpaceRelease(csRef);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:ciImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    UIImage *image = [UIImage imageWithCGImage:scaledImage];
    CGImageRelease(scaledImage);
    
    return image;
}


#pragma mark release call back method
void zcp_providerReleaseData(void *info, const void *data, size_t size) {
    free((void *)data);
}
 
#pragma mark 将UIImage中黑色的内容转换成参数对应的RGB颜色
+ (UIImage *)imageBlackToTransparent:(UIImage *)image withRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    const int imageWidth        = image.size.width;
    const int imageHeight       = image.size.height;
    size_t bytesPerRow          = imageWidth * 4;
    uint32_t *rgbImageBuf       = (uint32_t *)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpace  = CGColorSpaceCreateDeviceRGB();
    CGContextRef context        = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t *pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++) {
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900) { // 将白色变成透明
            uint8_t*ptr = (uint8_t *)pCurPtr;
            ptr[3] = red;   // 0 ~ 255
            ptr[2] = green;
            ptr[1] = blue;
        } else {
            uint8_t *ptr = (uint8_t *)pCurPtr;
            ptr[0] = 0;
        }
    }
    // 输出图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, zcp_providerReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace, kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider, NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage *resultUIImage = [UIImage imageWithCGImage:imageRef];
    // 清理空间
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}

+ (UIImage *)imageBlackToTransparentWithRandomColor:(UIImage *)image {
    const int imageWidth        = image.size.width;
    const int imageHeight       = image.size.height;
    size_t bytesPerRow          = imageWidth * 4;
    uint32_t *rgbImageBuf       = (uint32_t *)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpace  = CGColorSpaceCreateDeviceRGB();
    CGContextRef context        = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t *pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++) {
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900) { // 将白色变成透明
            uint8_t *ptr    = (uint8_t *)pCurPtr;
            ptr[3]          = RANDOM(0, 255);   // 0 ~ 255
            ptr[2]          = RANDOM(0, 255);
            ptr[1]          = RANDOM(0, 255);
        } else {
            uint8_t *ptr = (uint8_t *)pCurPtr;
            ptr[0] = 0;
        }
    }
    // 输出图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, zcp_providerReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace, kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider, NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage *resultUIImage = [UIImage imageWithCGImage:imageRef];
    // 清理空间
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}

#pragma mark 生成带logo的二维码图片
+ (UIImage *)imageWithQRCode:(UIImage *)qrCode logo:(UIImage *)logo {
    CGRect qrCodeRect = CGRectMake(0, 0, qrCode.size.width, qrCode.size.height);
    CGRect logoRect = CGRectMake((qrCodeRect.size.width - qrCodeRect.size.width * 0.25) / 2, (qrCodeRect.size.height - qrCodeRect.size.height * 0.25) / 2, qrCodeRect.size.width * 0.25, qrCodeRect.size.height * 0.25);
    
    UIGraphicsBeginImageContext(qrCodeRect.size);
    [qrCode drawInRect:qrCodeRect];
    [logo drawInRect:logoRect];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}

#pragma mark 给UIImageView添加阴影
//+ (void)addShadow:(UIColor *)color forImageView:(UIImageView *)imageView {
//    // 设置阴影的偏移量
//    imageView.layer.shadowOffset = CGSizeMake(0, 0.5);
//    // 设置阴影的半径
//    imageView.layer.shadowRadius = 100;
//    // 设置阴影的颜色
//    imageView.layer.shadowColor = color.CGColor;
//    // 设置阴影的不透明度
//    imageView.layer.shadowOpacity = 0.9;
//}

@end
