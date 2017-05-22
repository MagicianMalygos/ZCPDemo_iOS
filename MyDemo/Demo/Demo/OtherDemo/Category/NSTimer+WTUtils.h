//
//  NSTimer+WTUtils.h
//  Timer
//
//  Created by windtersharp on 16/7/10.
//  Copyright © 2016年 windtersharp. All rights reserved.
//

// 来源：https://github.com/windtersharp/NSTimer

#import <Foundation/Foundation.h>

// 两个宏之间的方法返回值将会被设置为nonull
NS_ASSUME_NONNULL_BEGIN;


/**
 在原本timer和其持有者（目标）之间添加一层。接替原本持有者作为timer的代理，并将原本持有者的相关处理代码封为block交由TimerTarget处理
 */
@interface WTTimerTarget : NSObject

@end

@interface NSTimer (WTUtils)

+ (NSTimer *)wt_scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;

+ (NSTimer *)wt_timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;

+ (NSTimer *)wt_scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo  block:(void(^)(NSTimer *timer))block;

+ (NSTimer *)wt_timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget userInfo:(id)userInfo repeats:(BOOL)yesOrNo  block:(void(^)(NSTimer *timer))block;

NS_ASSUME_NONNULL_END;

@end

