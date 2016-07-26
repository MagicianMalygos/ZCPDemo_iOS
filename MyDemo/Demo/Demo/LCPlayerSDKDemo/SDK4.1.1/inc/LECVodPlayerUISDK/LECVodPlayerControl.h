//
//  LECVodPlayerControl.h
//  LECVodPlayerUISDK
//
//  Created by tingting on 16/5/16.
//  Copyright © 2016年 tingting. All rights reserved.
//

#import "LECPlayerControl.h"
#import "LECGlobalDefine.h"

@interface LECVodPlayerControl : LECPlayerControl

@property (nonatomic, assign) BOOL enableVODResumePlay;//是否启用续播功能,Default is NO;
@property (nonatomic, assign) BOOL enableDownload;//是否启用下载,Default is YES,在注册播放器前设置;

//播放器视图初始化创建
- (UIView *)createPlayerWithOwner:(id)owner
                            frame:(CGRect)frame;

//注册点播播放器
- (BOOL)registerVodPlayerWithUU:(NSString *)uu
                             vu:(NSString *)vu;

- (BOOL)registerVodPlayerWithUU:(NSString *)uu
                             vu:(NSString *)vu
                         option:(LECPlayerOption *)option;//业务信息,如业务线p=xxx

@end

