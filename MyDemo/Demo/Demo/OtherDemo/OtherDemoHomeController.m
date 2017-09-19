//
//  OtherDemoHomeController.m
//  Demo
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "OtherDemoHomeController.h"
#import "NSTimer+WTUtils.h"
#import <objc/runtime.h>

@implementation OtherDemoHomeController

@synthesize infoArr = _infoArr;

#pragma mark - test

- (void)test {
    // NSTimer+WTUtils
    /*
    // 1.
    WEAK_SELF;
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"Timer Block");
        [weakSelf fire:NSStringFromSelector(@selector(scheduledTimerWithTimeInterval:repeats:block:))];
    }];
    // 2.
    NSMethodSignature *methodSignature = [[self class] instanceMethodSignatureForSelector:@selector(fire:)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    NSString *arg = NSStringFromSelector(@selector(scheduledTimerWithTimeInterval:invocation:repeats:));
    invocation.target   = self;
    invocation.selector = @selector(fire:);
    [invocation setArgument:&arg atIndex:2];
    [NSTimer scheduledTimerWithTimeInterval:1 invocation:invocation repeats:YES];
    // 3.
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(fire:) userInfo:@{@"msg": NSStringFromSelector(@selector(scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:))} repeats:YES];
    */
    
    /*
    WEAK_SELF;
    [NSTimer wt_scheduledTimerWithTimeInterval:1 target:self userInfo:@{@"msg": NSStringFromSelector(@selector(wt_scheduledTimerWithTimeInterval:target:userInfo:repeats:block:))} repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"Timer Block");
        [weakSelf fire:timer];
    }];
    [NSTimer wt_scheduledTimerWithTimeInterval:1 target:self selector:@selector(fire:) userInfo:@{@"msg": NSStringFromSelector(@selector(wt_scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:))} repeats:YES];
     */
    
    /**/
//    WEAK_SELF;
//    NSTimer *timer1 = [NSTimer wt_timerWithTimeInterval:1 target:self userInfo:@{@"msg": NSStringFromSelector(@selector(wt_timerWithTimeInterval:target:userInfo:repeats:block:))} repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"Timer Block");
//        [weakSelf fire:timer];
//
//        NSLog(@"Current Thread: %@ Current RunLoop Mode: %@", [NSThread currentThread], [NSRunLoop currentRunLoop].currentMode);
//    }];
//    NSTimer *timer2 = [NSTimer wt_timerWithTimeInterval:1 target:self selector:@selector(fire:) userInfo:@{@"msg": NSStringFromSelector(@selector(wt_timerWithTimeInterval:target:selector:userInfo:repeats:))} repeats:YES];
//
//    [[NSRunLoop currentRunLoop] addTimer:timer1 forMode:NSDefaultRunLoopMode];
//    [[NSRunLoop currentRunLoop] addTimer:timer2 forMode:NSDefaultRunLoopMode];
//    [[NSRunLoop currentRunLoop] addTimer:timer2 forMode:UITrackingRunLoopMode];
}

//- (void)fire:(id)obj {
//    NSLog(@"Current Thread: %@ Current RunLoop Mode: %@", [NSThread currentThread], [NSRunLoop currentRunLoop].currentMode);
//    if ([obj isKindOfClass:[NSString class]]) {
//        ZCPLog(@"Fire %@", obj);
//    } else if ([obj isKindOfClass:[NSTimer class]]) {
//        NSTimer *timer = (NSTimer *)obj;
//        ZCPLog(@"Fire %@", [timer.userInfo objectForKey:@"msg"]);
//    } else {
//        ZCPLog(@"Fire");
//    }
//}

#pragma mark - tableview

- (NSMutableArray *)infoArr {
    if (_infoArr == nil) {
        _infoArr = [NSMutableArray arrayWithObjects:
                    @{@"title":@"MacroDemo", @"class":@"MacroDemo"},
                    @{@"title":@"RuntimeDemo", @"class":@"RuntimeDemo"},
                    @{@"title":@"RuntimeExampleDemo", @"class":@"RuntimeExampleDemo"},
                    @{@"title":@"EnumAndFormatDemo", @"class":@"EnumAndFormatDemo"},
                    @{@"title":@"OCClassPropertyDemo", @"class":@"OCClassPropertyDemo"},
                    @{@"title":@"OCClassMethodDemo", @"class":@"OCClassMethodDemo"},
                    @{@"title":@"AlgorithmDemo", @"class":@"AlgorithmDemo"},
                    @{@"title": @"RegexDemo", @"class": @"RegexDemo"},
                    @{@"title": @"MultiThreadDemo", @"class": @"MultiThreadDemo"},
                    @{@"title": @"DesignPatternDemo", @"class": @"DesignPatternDemo"}, nil];
    }
    return _infoArr;
}

- (void)didSelectCell:(NSIndexPath *)indexPath {
    NSString *classString = [[self.infoArr objectAtIndex:indexPath.row] valueForKey:@"class"];
    Class class = NSClassFromString(classString);
    if ([classString isEqualToString:@"RuntimeExampleDemo"]) {
        UIViewController *vc = [class new];
        if (class && vc) {
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else {
        NSObject *object = [class new];
        if (class && object) {
            [object performSelector:@selector(run)];
        }
    }
}

@end

