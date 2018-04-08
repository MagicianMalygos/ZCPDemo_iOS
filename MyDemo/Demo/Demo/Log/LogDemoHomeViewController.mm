//
//  LogDemoHomeViewController.m
//  Demo
//
//  Created by 朱超鹏 on 2018/1/4.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "LogDemoHomeViewController.h"
#import <mars/xlog/xlogger.h>
#import <mars/xlog/xloggerbase.h>

@interface LogDemoHomeViewController ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation LogDemoHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.button];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.button.frame = CGRectMake(0, 100, 100, 50);
}

- (void)click {
    for (int i = 0; i < 1000; i++) {
        NSString *log = @"对于移动开发者来说，最大的尴尬莫过于用户反馈程序出现问题，但因为不能重现且没有日志无法定位具体原因。这样看来客户端日志颇有点“养兵千日，用兵一时”的感觉，只有当出现问题且不容易重现时才能体现它的重要作用。为了保证关键时刻有日志可用，就需要保证程序整个生命周期内都要打日志，所以日志方案的选择至关重要。";
        XLoggerInfo info;
        info.level = kLevelDebug;
        info.tag = "test";
        info.filename = "LogDemoHomeViewController";
        info.func_name = "viewDidLoad";
        info.line = 33;
        gettimeofday(&info.timeval, NULL);
        info.tid = (uintptr_t)[NSThread currentThread];
        info.maintid = (uintptr_t)[NSThread mainThread];
        info.pid = 0;
        xlogger_Write(&info, log.UTF8String);
    }
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = [UIColor redColor];
        [_button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

@end
