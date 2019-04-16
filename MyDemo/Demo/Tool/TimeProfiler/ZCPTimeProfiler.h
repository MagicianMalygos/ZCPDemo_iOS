//
//  ZCPTimeProfiler.h
//  Demo
//
//  Created by zcp on 2019/4/12.
//  Copyright © 2019 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZCPTimeProfiler : NSObject

DEF_SINGLETON

- (void)startMonitor;
- (void)stopMonitor;

@end

struct ZCPAddr {
    char *addr;
    char *info;
    float time;
};

@interface AddrModel : NSObject

@property (nonatomic, copy) NSString *addr;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, assign) CGFloat time;

@end

NS_ASSUME_NONNULL_END
