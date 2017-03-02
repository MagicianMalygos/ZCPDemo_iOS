//
//  AppManager.m
//  Test
//
//  Created by 朱超鹏(外包) on 17/3/1.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "AppManager.h"

@implementation AppManager


#pragma mark - 方案一

// 检查app版本
+ (void)checkAppVersion {
    // 请求接口，传参appID
    NSString *appID = @"444934666"; // 使用了qq的appid
    [AppManager requestAppVersionWithAppID:appID success:^(AppUpdateModel *model) {
        // 处理app更新
        [AppManager handlerUpdateWithModel:model];
    }];
}

+ (void)requestAppVersionWithAppID:(NSString *)appID success:(void(^)(AppUpdateModel *model))success {
    [[AFHTTPRequestOperationManager manager] GET:@"http://itunes.apple.com/cn/lookup" parameters:@{@"id": appID} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *results            = [responseObject objectForKey:@"results"];
        NSDictionary *appInfo       = [results firstObject];
        
        // 判断是否需要更新
        NSString *lastestversion    = [appInfo objectForKey:@"version"];
        NSString *currentVersion    = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        BOOL needUpdate             = [AppManager judgeNeedUpadteWithLastestVersion:lastestversion currentVersion:currentVersion];
        
        // 封装model返回
        AppUpdateModel *model       = [AppUpdateModel new];
        model.needUpdate            = needUpdate;
        model.version               = [appInfo objectForKey:@"version"];
        model.downloadSURL          = [appInfo objectForKey:@"trackViewUrl"];
        model.title                 = @"发现新版本";
        model.message               = @"新增6大功能，更新后体验。";
        [AppManager handlerUpdateWithModel:model];
        
        if (success) {
            success(model);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

#pragma mark - 方案二

// 检查app版本
+ (void)checkAppVersion_custom {
    // 获取当前app版本号
    NSString *currAppVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    // 请求接口，传参app版本号
    [AppManager customRequestAppVersion:currAppVersion success:^(AppUpdateModel *model) {
        [AppManager handlerUpdateWithModel:model];
    }];
}

+ (void)customRequestAppVersion:(NSString *)appVersion success:(void(^)(AppUpdateModel *model))success {
    // 请求接口
    
    // 使用测试数据，模拟接口请求成功。
    // 由服务端下发是否需要更新的字段（不使用version进行比对是因为：可能会有类似1.1.0这种带有三级版本号的情况，这种情况不太容易进行大小比较，需要进行特殊处理）
    NSDictionary *responseDic = @{@"needUpdate": @"1",
                                  @"version": @"2.0.0",
                                  @"download_url": @"https://itunes.apple.com/cn/app/qq/id444934666?mt=8&uo=4",
                                  @"title": @"发现新版本",
                                  @"message": @"新增6大功能，更新后体验。",
                                  @"need_forced_update": @"1"};
    
    
    // 封装model返回
    AppUpdateModel *model   = [AppUpdateModel new];
    model.needUpdate        = [[responseDic objectForKey:@"needUpdate"] boolValue];
    model.version           = [responseDic objectForKey:@"version"];
    model.downloadSURL      = [responseDic objectForKey:@"trackViewUrl"];
    model.title             = @"发现新版本";
    model.message           = @"新增6大功能，更新后体验。";
    model.needForcedUpdate  = [[responseDic objectForKey:@"needForcedUpdate"] boolValue];
    
    if (success) {
        success(model);
    }
}

// 处理app更新
+ (void)handlerUpdateWithModel:(AppUpdateModel *)model {
    // 如果需要更新
    if (model.needUpdate) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:model.title message:model.message preferredStyle:UIAlertControllerStyleAlert];
        
        if (model.needForcedUpdate) {
            // 如果需要强制更新
            
            UIAlertAction *updateAction = [UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSURL *downloadURL = [NSURL URLWithString:model.downloadSURL];
                [[UIApplication sharedApplication] openURL:downloadURL options:@{} completionHandler:nil];
                // 循环重复弹出alert来达到强制更新效果
                UINavigationController *nav = (UINavigationController *)[[UIApplication sharedApplication].delegate window].rootViewController;
                [nav.topViewController presentViewController:alert animated:YES completion:nil];
            }];
            [alert addAction:updateAction];
        } else {
            // 否则为可选更新
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"下次更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            UIAlertAction *updateAction = [UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSURL *downloadURL = [NSURL URLWithString:model.downloadSURL];
                [[UIApplication sharedApplication] openURL:downloadURL options:@{} completionHandler:nil];
            }];
            [alert addAction:cancelAction];
            [alert addAction:updateAction];
        }
        // 弹出alert
        UINavigationController *nav = (UINavigationController *)[[UIApplication sharedApplication].delegate window].rootViewController;
        [nav.topViewController presentViewController:alert animated:YES completion:nil];
    } else {
        // toast: 当前为最新版本
    }
}

+ (BOOL)judgeNeedUpadteWithLastestVersion:(NSString *)lastestVersion currentVersion:(NSString *)currentVersion {
    
    if ([lastestVersion isEqualToString:currentVersion]) {
        return NO;
    }
    
    NSArray *arrlv = [lastestVersion componentsSeparatedByString:@"."];
    NSArray *arrcv = [currentVersion componentsSeparatedByString:@"."];
    NSUInteger  index = (arrlv.count < arrcv.count) ? arrlv.count : arrcv.count;
    
    for (int i = 0; i < index; i++) {
        if ([arrlv[i] intValue] > [arrcv[i] intValue]) {
            return YES;
        }
    }
    return NO;
}

@end

@implementation AppUpdateModel

@end
