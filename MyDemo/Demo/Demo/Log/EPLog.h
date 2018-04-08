//
//  EPLog.h

//
//  Created by Virtue on 2017/7/20.
//  Copyright © 2017年 Virtue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <mars/xlog/xloggerbase.h>

typedef enum : NSUInteger {
    LOG_TYPE_SELF = 1,
    LOG_TYPE_AGORA = 2,
    LOG_TYPE_DB = 3,
} LOG_TYPE;

#define __FILENAME__ (strrchr(__FILE__,'/')+1)

#define LOG_ERROR(module, format, ...) LogInternal(kLevelError, module, __FILENAME__, __LINE__, __FUNCTION__, @"Error:", format, ##__VA_ARGS__)
#define LOG_WARNING(module, format, ...) LogInternal(kLevelWarn, module, __FILENAME__, __LINE__, __FUNCTION__, @"Warning:", format, ##__VA_ARGS__)
#define LOG_INFO(module, format, ...) LogInternal(kLevelInfo, module, __FILENAME__, __LINE__, __FUNCTION__, @"Info:", format, ##__VA_ARGS__)
#define LOG_DEBUG(module, format, ...) LogInternal(kLevelDebug, module, __FILENAME__, __LINE__, __FUNCTION__, @"Debug:", format, ##__VA_ARGS__)

#ifdef DEBUG
#define LOG_C_ERROR(module, format, ...) LogCInternal(kLevelError, module, __FILENAME__, __LINE__, __FUNCTION__, @"Error:", format, ##__VA_ARGS__)
#define LOG_C_WARNING(module, format, ...) LogCInternal(kLevelWarn, module, __FILENAME__, __LINE__, __FUNCTION__, @"Warning:", format, ##__VA_ARGS__)
#define LOG_C_INFO(module, format, ...) LogCInternal(kLevelInfo, module, __FILENAME__, __LINE__, __FUNCTION__, @"Info:", format, ##__VA_ARGS__)
#define LOG_C_DEBUG(module, format, ...) LogCInternal(kLevelDebug, module, __FILENAME__, __LINE__, __FUNCTION__, @"Debug:", format, ##__VA_ARGS__)
#else
#define LOG_C_ERROR(module, format, ...)
#define LOG_C_WARNING(module, format, ...)
#define LOG_C_INFO(module, format, ...)
#define LOG_C_DEBUG(module, format, ...)
#endif

#define SET_LOG_TAG_LEVEL(module, level) SetLogTagLevel(module, level)

#define LogInternal(level, module, file, line, func, prefix, format, ...) \
do { \
if ([EPLog shouldLog:level]) { \
NSString *aMessage = [NSString stringWithFormat:@"%@%@", prefix, [NSString stringWithFormat:format, ##__VA_ARGS__, nil]]; \
[EPLog logWithLevel:level moduleName:module fileName:file lineNumber:line funcName:func message:aMessage]; \
} \
} while(0)

#define LogCInternal(level, module, file, line, func, prefix, format, ...) \
do { \
if ([EPLog shouldLog:level]) { \
NSString *aMessage = [NSString stringWithFormat:@"%@%@", prefix, [NSString stringWithFormat:format, ##__VA_ARGS__, nil]]; \
[EPLog logCWithLevel:level moduleName:module fileName:file lineNumber:line funcName:func message:aMessage]; \
} \
} while(0)

#define SetLogTagLevel(module, logLevel) \
do { \
[EPLog setTag:module level:logLevel]; \
} while(0)

@interface EPLog : NSObject
+ (void)setTag:(const char*)tab level:(TLogLevel)loglevel;
+ (BOOL)shouldLog:(TLogLevel)level;

+ (void)logWithLevel:(TLogLevel)logLevel moduleName:(const char*)moduleName fileName:(const char*)fileName lineNumber:(int)lineNumber funcName:(const char*)funcName message:(NSString *)message;
+ (void)logWithLevel:(TLogLevel)logLevel moduleName:(const char*)moduleName fileName:(const char*)fileName lineNumber:(int)lineNumber funcName:(const char*)funcName format:(NSString *)format, ...;
+ (void)logCWithLevel:(TLogLevel)logLevel moduleName:(const char*)moduleName fileName:(const char*)fileName lineNumber:(int)lineNumber funcName:(const char*)funcName message:(NSString *)message;
+ (void)logCWithLevel:(TLogLevel)logLevel moduleName:(const char*)moduleName fileName:(const char*)fileName lineNumber:(int)lineNumber funcName:(const char*)funcName format:(NSString *)format, ...;

@end
