//
//  CalendarManager.m
//  AwsomeProject
//
//  Created by apple on 16/1/13.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "CalendarManager.h"

#import <RCTConvert.h>

@implementation CalendarManager

RCT_EXPORT_MODULE();

// 普通方法：参数为标准JSON类型
RCT_EXPORT_METHOD(addEvent:(NSString *)name location:(NSString *)location) {
  RCTLogInfo(@"Pretending to create an event %@ at %@", name, location);
}
// 转换方法：需要NSDate参数时，进行一次转换，NSNumber需要加nonnull
RCT_EXPORT_METHOD(addEvent1:(NSString *)name location:(NSString *)location date:(nonnull NSNumber *)secondsSinceUnixEpoch) {
  NSDate *date = [RCTConvert NSDate:secondsSinceUnixEpoch];
  RCTLogInfo(@"%@(NSNumber) change %@(NSDate)", secondsSinceUnixEpoch, date);
}
// 转换方法：使用字符串参数
RCT_EXPORT_METHOD(addEvent2:(NSString *)name location:(NSString *)location date:(NSString *)ISO8601DateString) {
  NSDate *date = [RCTConvert NSDate:ISO8601DateString];
  RCTLogInfo(@"%@(NSString) change %@(NSDate)", ISO8601DateString, date);
}
// 自动转换方法：
RCT_EXPORT_METHOD(addEvent3:(NSString *)name location:(NSString *)location date:(NSDate *)date) {
  NSLog(@"%@", date);
}
// 包装参数方法
RCT_EXPORT_METHOD(addEvent4:(NSString *)name details:(NSDictionary *)details) {
  NSString *location = [RCTConvert NSString:details[@"location"]];
  NSDate *date = [RCTConvert NSDate:details[@"date"]];
  NSLog(@"%@,%@",location, date);
}

// 含回调参数
RCT_EXPORT_METHOD(eventWithCallback:(RCTResponseSenderBlock)callback) {
  NSArray *events = [NSArray arrayWithObjects:@"1", @"2", nil];
  callback(@[[NSNull null], events]);
}
// 最后两个参数是RCTPromiseResolveBlock和RCTPromiseRejectBlock，JS方法返回Promise对象
RCT_EXPORT_METHOD(eventWithPromise:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
  NSArray *events = [NSArray arrayWithObjects:@"ok", @"no", nil];
  if (events) {
    resolve(events);
  } else {
    NSError *error = [NSError new];
    reject(error);
  }
}


@end
