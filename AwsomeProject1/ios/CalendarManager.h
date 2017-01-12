//
//  CalendarManager.h
//  AwsomeProject
//
//  Created by apple on 16/1/13.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <RCTBridgeModule.h>
#import <RCTLog.h>

@interface CalendarManager : NSObject <RCTBridgeModule>

- (void)addEvent:(nonnull NSString *)name location:(nonnull NSString *)location;
- (void)addEvent1:(nonnull NSString *)name location:(nonnull NSString *)location date:(nonnull NSNumber *)secondsSinceUnixEpoch;
- (void)addEvent2:(nonnull NSString *)name location:(nonnull NSString *)location date:(nonnull NSString *)ISO8601DateString;
- (void)addEvent3:(nonnull NSString *)name location:(nonnull NSString *)location date:(nonnull NSDate *)date;
- (void)addEvent4:(nonnull NSString *)name details:(nonnull NSDictionary *)details;

- (void)eventWithCallback:(nonnull RCTResponseSenderBlock)callback;
- (void)eventWithPromise:(nonnull RCTPromiseResolveBlock)resolve rejecter:(nonnull RCTPromiseRejectBlock)reject;

@end
