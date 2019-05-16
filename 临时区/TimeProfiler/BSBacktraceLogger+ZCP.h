//
//  BSBacktraceLogger.h
//  BSBacktraceLogger
//
//  Created by 张星宇 on 16/8/27.
//  Copyright © 2016年 bestswifter. All rights reserved.
//

#import <BSBacktraceLogger/BSBacktraceLogger.h>

@interface BSBacktraceLogger (ZCP)

+ (NSArray *)zcp_backtraceOfMainThread;

@end
