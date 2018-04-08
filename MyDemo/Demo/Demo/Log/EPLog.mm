//
//  EPLog.m

//
//  Created by Virtue on 2017/7/20.
//  Copyright © 2017年 Virtue. All rights reserved.
//

#import "EPLog.h"
#import <mars/xlog/xlogger.h>

static NSUInteger g_processID = 0;
static NSMutableDictionary* tabLevel = [[NSMutableDictionary alloc]init];

@implementation EPLog
+ (void)logWithLevel:(TLogLevel)logLevel moduleName:(const char*)moduleName fileName:(const char*)fileName lineNumber:(int)lineNumber funcName:(const char*)funcName message:(NSString *)message {
    if ([self shouldLog:logLevel] && [self shouldLogTab:moduleName level:logLevel]) {
        XLoggerInfo info;
        info.level = logLevel;
        info.tag = moduleName;
        info.filename = fileName;
        info.func_name = funcName;
        info.line = lineNumber;
        gettimeofday(&info.timeval, NULL);
        info.tid = (uintptr_t)[NSThread currentThread];
        info.maintid = (uintptr_t)[NSThread mainThread];
        info.pid = g_processID;
        xlogger_Write(&info, message.UTF8String);
    }
}

+ (void)logWithLevel:(TLogLevel)logLevel moduleName:(const char*)moduleName fileName:(const char*)fileName lineNumber:(int)lineNumber funcName:(const char*)funcName format:(NSString *)format, ... {
    if ([self shouldLog:logLevel] && [self shouldLogTab:moduleName level:logLevel]) {
        va_list argList;
        va_start(argList, format);
        NSString* message = [[NSString alloc] initWithFormat:format arguments:argList];
        
        XLoggerInfo info;
        info.level = logLevel;
        info.tag = moduleName;
        info.filename = fileName;
        info.func_name = funcName;
        info.line = lineNumber;
        gettimeofday(&info.timeval, NULL);
        info.tid = (uintptr_t)[NSThread currentThread];
        info.maintid = (uintptr_t)[NSThread mainThread];
        info.pid = g_processID;
        xlogger_Write(&info, message.UTF8String);
        va_end(argList);
    }
}

+ (void)logCWithLevel:(TLogLevel)logLevel moduleName:(const char*)moduleName fileName:(const char*)fileName lineNumber:(int)lineNumber funcName:(const char*)funcName message:(NSString *)message{
    if ([self shouldLog:logLevel] && [self shouldLogTab:moduleName level:logLevel]) {
        NSString* tag = moduleName == NULL ? nil :[NSString stringWithUTF8String:moduleName];
        NSLog(@"[%@ %@:%d] %@",tag, [NSString stringWithUTF8String:fileName], lineNumber, message);
    }
}

+ (void)logCWithLevel:(TLogLevel)logLevel moduleName:(const char*)moduleName fileName:(const char*)fileName lineNumber:(int)lineNumber funcName:(const char*)funcName format:(NSString *)format, ...{
    if ([self shouldLog:logLevel] && [self shouldLogTab:moduleName level:logLevel]) {
        va_list argList;
        va_start(argList, format);
        NSString* message = [[NSString alloc] initWithFormat:format arguments:argList];
        
        NSString* tag = moduleName == NULL ? nil :[NSString stringWithUTF8String:moduleName];
        NSLog(@"[%@ %@:%d] %@",tag, [NSString stringWithUTF8String:fileName], lineNumber, message);
        va_end(argList);
    }
}

+ (BOOL)shouldLog:(TLogLevel)level {
    
    if (level >= xlogger_Level()) {
        return YES;
    }
    return NO;
}

+ (BOOL)shouldLogTab:(const char*)tag level:(TLogLevel)level {
    if(tag == NULL){
        return YES;
    }
    NSString* keyTag = [NSString stringWithUTF8String:tag];
    if(![[tabLevel allKeys] containsObject:keyTag]) {
        return YES;
    }
    
    NSNumber* value = [tabLevel objectForKey:keyTag];
    if([value intValue] >= level) {
        return NO;
    }
    return YES;
}

+ (void)setTag:(const char*)tab level:(TLogLevel)loglevel {
    if(tab != NULL){
        [tabLevel setObject:@(loglevel) forKey:[NSString stringWithUTF8String:tab]];
    }
}
@end
