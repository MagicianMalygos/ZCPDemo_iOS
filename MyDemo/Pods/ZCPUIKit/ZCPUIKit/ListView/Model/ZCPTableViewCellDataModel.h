//
//  ZCPTableViewCellDataModel.h
//  ZCPUIKit
//
//  Created by zhuchaopeng on 16/9/21.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCPTableViewCellItemBasicProtocol.h"

// ----------------------------------------------------------------------
#pragma mark - cell模型基类
// ----------------------------------------------------------------------
@interface ZCPTableViewCellDataModel : NSObject <ZCPTableViewCellItemBasicProtocol, NSCopying>

/// id
@property (nonatomic, copy) NSString *idString;

/// 实例化方法
- (instancetype)initWithDefault;
+ (instancetype)modelFromDictionary:(NSDictionary *)dictionary;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)dictionaryValue;

@end
