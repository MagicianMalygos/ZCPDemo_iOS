//
//  LCPlayerOption.h
//  LECPlayerSDK
//
//  Created by CC on 16/4/7.
//  Copyright © 2016年 letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LECGlobalDefine.h"




//播放器业务相关数据Model
@interface LCPlayerOption : NSObject

@property (nonatomic, strong) NSString * p;//业务ID
@property (nonatomic, strong) NSString * customId;//用户ID
@property (nonatomic, assign) LECBusinessLine businessLine;//业务线类型

@end
