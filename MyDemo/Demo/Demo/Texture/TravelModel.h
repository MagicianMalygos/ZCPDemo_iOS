//
//  TravelModel.h
//  Demo
//
//  Created by zcp on 2019/5/7.
//  Copyright © 2019 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TravelModel : NSObject

@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *sourceAddr;
@property (nonatomic, copy) NSString *destinationAddr;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *amount;

@end

NS_ASSUME_NONNULL_END
