//
//  ZCPDataModel.h
//  Apartment
//
//  Created by apple on 15/12/28.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZCPTableViewCellItemBasicProtocol.h"

// 模型基类
@interface ZCPDataModel : NSObject <ZCPTableViewCellItemBasicProtocol, NSCopying>

// id
@property (nonatomic, copy) NSString *idString;

#pragma mark - instancetype
+ (instancetype)modelFromDictionary:(NSDictionary *)dictionary;
- (instancetype)initWithDefault;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)dictionaryValue;

@end
