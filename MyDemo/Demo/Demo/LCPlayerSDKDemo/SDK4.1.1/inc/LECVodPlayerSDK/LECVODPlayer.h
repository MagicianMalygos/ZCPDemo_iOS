//
//  LECVODPlayer.h
//  LECPlayerSDK
//
//  Created by 侯迪 on 9/13/15.
//  Copyright (c) 2015 letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LECPlayer.h"

@interface LECVODPlayer : LECPlayer

- (BOOL) registerWithUu:(NSString *) uu
                     vu:(NSString *) vu
             completion:(void (^)(BOOL result))completion;

- (BOOL) registerWithUu:(NSString *) uu
                     vu:(NSString *) vu
           payCheckCode:(NSString *) payCheckCode
            payUserName:(NSString *) payUserName
             completion:(void (^)(BOOL result))completion;

- (BOOL) registerWithUu:(NSString *) uu
                     vu:(NSString *) vu
           payCheckCode:(NSString *) payCheckCode
            payUserName:(NSString *) payUserName
                options:(LECPlayerOption *)options//设置业务相关参数以及用户ID等,没有可以为nil
  onlyLocalVODAvaliable:(BOOL) onlyLocalVODAvaliable
resumeFromLastPlayPosition:(BOOL) resumeFromLastPlayPosition
 resumeFromLastRateType:(BOOL) resumeFromLastRateType
             completion:(void (^)(BOOL result))completion;


@property (nonatomic, readonly) NSString *uu; //userId，调用注册方法后该值可获取
@property (nonatomic, readonly) NSString *vu;//videoUniqueId，调用注册方法后该值可获取
@property (nonatomic, readonly) NSString *payCheckCode;//调用注册方法后该值可获取
@property (nonatomic, readonly) NSString *payUserName;//调用注册方法后该值可获取
@property (nonatomic, readonly) NSString *videoTitle;//视频标题，注册完成后，该值可获取
@property (nonatomic, readonly) BOOL allowDownload;//标志视频是否允许下载，注册完成后，该值可获取
@property (nonatomic, readonly) BOOL resumeFromLastPlayPosition;//调用注册方法后该值可获取
@property (nonatomic, readonly) BOOL resumeFromLastRateType;//是否采用上一次播放的码率
@property (nonatomic, readonly) NSString *loadingIconUrl;//启动加载图片的URL地址
@property (nonatomic, readonly) BOOL isPanorama;//是否是全景

@end
