//
//  AppManager.h
//  Test
//
//  Created by 朱超鹏(外包) on 17/3/1.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppManager : NSObject

// 检查app版本
+ (void)checkAppVersion;
+ (void)checkAppVersion_custom;

@end


#pragma mark - app版本更新模型
@interface AppUpdateModel : NSObject

@property (nonatomic, assign)   BOOL        needUpdate;         // 是否需要更新
@property (nonatomic, copy)     NSString    *version;           // 新版本的版本号
@property (nonatomic, copy)     NSString    *downloadSURL;      // 新版本下载地址
@property (nonatomic, copy)     NSString    *title;             // 弹窗标题
@property (nonatomic, copy)     NSString    *message;           // 弹窗内容
@property (nonatomic, assign)   BOOL        needForcedUpdate;   // 是否需要强制更新

@end
