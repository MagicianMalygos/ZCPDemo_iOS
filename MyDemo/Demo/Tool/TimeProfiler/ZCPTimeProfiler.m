//
//  ZCPTimeProfiler.m
//  Demo
//
//  Created by zcp on 2019/4/12.
//  Copyright © 2019 zcp. All rights reserved.
//

#import "ZCPTimeProfiler.h"
#import "BSBacktraceLogger.h"

@interface ZCPTimeProfiler ()

@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, strong) dispatch_source_t timer2;
@property (nonatomic, strong) NSMutableDictionary *dict;

@end

@implementation ZCPTimeProfiler

IMP_SINGLETON

- (void)startMonitor {
    self.dict = [NSMutableDictionary dictionary];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        NSArray *arr = [BSBacktraceLogger zcp_backtraceOfMainThread];
        for (NSDictionary *dict in arr) {
            NSString *addr = dict[@"addr"];
            if (![self.dict.allKeys containsObject:addr]) {
                AddrModel *model = [AddrModel new];
                model.addr = addr;
                model.info = dict[@"info"];
                model.time = 0;
                self.dict[addr] = model;
            } else {
                AddrModel *model = self.dict[addr];
                model.time += 0.01;
            }
        }
    });
    dispatch_resume(timer);
    self.timer = timer;
    
    [self logInfo];
}

- (void)stopMonitor {
    dispatch_source_cancel(self.timer);
    dispatch_source_cancel(self.timer2);
    self.dict = nil;
}

- (void)logInfo {
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        [self.dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            AddrModel *model = (AddrModel *)obj;
            if (model.time < 0.01) {
                [self.dict removeObjectForKey:model.addr];
            }
        }];
        NSLog(@"%@", self.dict);
    });
    dispatch_resume(timer);
    self.timer2 = timer;
}

@end


@implementation AddrModel

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@> %lf", self.info, self.time];
}

@end
