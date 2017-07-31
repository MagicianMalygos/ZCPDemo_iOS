//
//  DebugManager.m
//  Demo
//
//  Created by 朱超鹏 on 2017/7/26.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "DebugManager.h"
#import "DebugStatusBallView.h"
#import "DebugConsoleLogView.h"

static NSDateFormatter  *dfm;

void DebugLog(NSString *format, ...) {
    va_list args;
    va_start(args, format);
    NSString *log = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    [DebugManager log:log];
}

@interface DebugManager () <DebugStatusBallViewDelegate, DebugConsoleLogViewDelegate>

@property (nonatomic, assign, getter=isAlwaysShowStatusBall) BOOL alwaysShowStatusBall;

@end

@implementation DebugManager

#pragma mark - life cycle

+ (instancetype)defaultManager {
    static DebugManager     *singleton;
    static dispatch_once_t  onceToken;
    
    dispatch_once(&onceToken, ^{
        singleton = [[DebugManager alloc] init];
    });
    return singleton;
}

#pragma mark - public method

- (void)setup {
    
    dfm = [[NSDateFormatter alloc] init];
    [dfm setDateFormat:@"YY-MM-dd HH:mm:ss"];
    
    // 从setting中读取是否一直显示状态球
    self.alwaysShowStatusBall = YES;    // 模拟读取
    
    if (self.isAlwaysShowStatusBall) {
        [self.statusBallView show];
        [self.consoleLogView hide];
    }
}

+ (void)log:(NSString *)log {
    NSString *date = [dfm stringFromDate:[NSDate date]];
    log = [NSString stringWithFormat:@"%@ %@", date, log];
    [[DebugManager defaultManager].consoleLogView addlog:log];
}

#pragma mark - DebugStatusBallViewDelegate

- (void)clickDebugStatusBallView:(DebugStatusBallView *)debugStatusBallView {
    [self.statusBallView hide];
    [self.consoleLogView show];
}

#pragma mark - DebugConsoleLogViewDelegate

- (void)debugConsoleLogViewWillHide:(DebugConsoleLogView *)view {
    [self.statusBallView show];
}

#pragma mark - getter / setter

- (DebugStatusBallView *)statusBallView {
    if (!_statusBallView) {
        _statusBallView             = [DebugStatusBallView instanceDebugStatusBallView];
        _statusBallView.delegate    = self;
    }
    return _statusBallView;
}

- (DebugConsoleLogView *)consoleLogView {
    if (!_consoleLogView) {
        _consoleLogView             = [DebugConsoleLogView instanceDebugConsoleLogView];
        _consoleLogView.delegate    = self;
    }
    return _consoleLogView;
}

@end
