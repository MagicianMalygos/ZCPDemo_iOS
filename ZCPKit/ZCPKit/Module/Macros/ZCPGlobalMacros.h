//
//  ZCPGlobalMacros.h
//  ZCPKit
//
//  Created by zhuchaopeng on 16/9/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#ifndef ZCPGlobalMacros_h
#define ZCPGlobalMacros_h

#pragma mark - - - - - - - - - - - system - - - - - - - - - -

// 当前系统版本号
#define SYSTEM_VERSION                  [[UIDevice currentDevice] systemVersion].floatValue
// 当前软件版本号
#define APP_VERSION                     [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]

// 判断系统版本是否为iOS 7及以上
#define iOS7Upper                       ([[UIDevice currentDevice] systemVersion].floatValue >= 7.0 ? YES : NO)
// 判断系统版本是否为iOS 8及以上
#define iOS8Upper                       ([[UIDevice currentDevice] systemVersion].floatValue >= 8.0 ? YES : NO)
// 判断系统版本是否为iOS 9及以上
#define iOS9Upper                       ([[UIDevice currentDevice] systemVersion].floatValue >= 9.0 ? YES : NO)
// 判断系统版本是否为iOS 10及以上
#define iOS10Upper                      ([[UIDevice currentDevice] systemVersion].floatValue >= 10.0 ? YES : NO)

// 判断是不是iPhone
#define iPhone                          (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
// 判断是不是iPhone plus
#define iPhonePlus                      (iPhone && [[UIScreen mainScreen] scale] == 3.0)
// 设备是否ipad
#define iPad                            (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// 判断是不是iPhone 4/4s     的3.5寸屏幕
#define iPhone4                         (iPhone && [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是不是iPhone 5/5c/5s  的4.0寸屏幕
#define iPhone5                         (iPhone && [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是不是iPhone 6        的4.7寸屏幕
#define iPhone6                         (iPhone && [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1344), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是不是iPhone 6 plus   的5.5寸屏幕
#define iPhone6Plus                     (iPhone && [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

// 判断是否是高清屏
#define Retina                          ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale >= 2.0))

// 设备是否支持打开相机/应用是否允许打开相机
#define PHOTO_LIBRARY_AVAILABLE         [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]
// 设备是否支持打开相册/应用是否允许打开相册
#define CAMERA_AVAILABLE                [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]


#pragma mark - - - - - - - - - - - frame - - - - - - - - - -

// 屏幕高度
#define SCREENHEIGHT                    [[UIScreen mainScreen] bounds].size.height
// 应用高度
#define APPLICATIONHEIGHT               [[UIScreen mainScreen] bounds].size.height
// 应用宽度
#define APPLICATIONWIDTH                [[UIScreen mainScreen] bounds].size.width
// 状态栏高度
#define Height_StatusBar                20
// 导航栏高度
#define Height_NavigationBar            44
// TabBar高度
#define Height_TabBar                   48
// 默认水平边距
#define MARGIN_HORIZONTAL               15


#pragma mark - - - - - - - - - - - util - - - - - - - - - -

// 时间性能测量用
// 结束时间除以CLOCKS_PER_SEC得到耗时秒数
/*
 例子：
    START_COUNT_TIME(start);
    staticDateFormatter = [[NSDateFormatter alloc] init];
    TTDPRINT(@"init date formatter use %f seconds", (float)END_COUNT_TIME(start)/CLOCKS_PER_SEC);
 */
#define START_COUNT_TIME(start)         clock_t start = clock()
#define END_COUNT_TIME(start)           (clock() - start)

// 一像素对应数值
// 设置宽(高)时，x(y)值需要减 OnePixelOffset
#define OnePixel                        (1 / [UIScreen mainScreen].scale)
#define OnePixelOffset                  ((1 / [UIScreen mainScreen].scale) / 2)

// 控制台打印
// 非DEBUG环境下不打印
#ifdef DEBUG
#define DEBUGPF(xx, ...)                NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define ZCPLog(FORMAT, ...)             fprintf(stderr,"%s:%d\n%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define DEBUGPF(xx, ...)                ((void)0)
#define ZCPLog(xx, ...)                 ((void)0)
#endif

// Block循环引用
#define WEAK_SELF                       __weak typeof(self)weakSelf = self
#define STRONG_SELF                     __strong typeof(weakSelf)self = weakSelf

// 从hex string获得uicolor
#define UIColorFromRGB(rgbValue)        [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// RGB色值
#define RGB(r,g,b,a)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/1.0]


// 忽略PerformSelectorleak警告宏
/*
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    Stuff;
    #pragma clang diagnostic pop
*/
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
    Stuff; \
    _Pragma("clang diagnostic pop") \
} while (0)


#pragma mark - - - - - - - - - - - random - - - - - - - - - -

// 生成a-b范围内的整数随机数
#define RANDOM(a, b)                    ((arc4random() % ((b) - (a) + 1)) + (a))
// 生成随机颜色
#define RANDOM_COLOR                    [UIColor colorWithRed:arc4random() % 10 / 10.0f green:arc4random() % 10 / 10.0f blue:arc4random() % 10 / 10.0f alpha:1.0f]
// 盐，四位随机数
#define SALT                            (arc4random() % 9000 + 1000)


#endif /* ZCPGlobalMacros_h */