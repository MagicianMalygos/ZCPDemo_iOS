//
//  Macro.h
//  UnitTestDemo
//
//  Created by apple on 16/4/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#ifndef Macro_h
#define Macro_h


// waitForExpectationsWithTimeout是等待时间，超过了就不再等待继续执行。
#define WAIT do {   \
    [self expectationForNotification:@"RSBaseTest" object:nil handler:nil]; \
    [self waitForExpectationsWithTimeout:5 handler:nil];   \
} while(0)

#define NOTIFY  \
[[NSNotificationCenter defaultCenter] postNotificationName:@"RSBaseTest" object:nil]


#endif /* Macro_h */
