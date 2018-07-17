//
//  LockDemoHomeViewController.m
//  Demo
//
//  Created by 朱超鹏 on 2018/5/24.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "LockDemoHomeViewController.h"
#import <libkern/OSAtomic.h>
#import <os/lock.h>
#import <pthread.h>

@interface LockDemoHomeViewController () {
    OSSpinLock _osSpinLock;
    os_unfair_lock_t _unfairLock;
    dispatch_semaphore_t _semaphore;
    pthread_mutex_t _mutexLock;
    NSLock *_nsLock;
    NSCondition *_condition;
    pthread_mutex_t _recursiveMutexLock;
    NSRecursiveLock *_nsRecursiveLock;
    NSConditionLock *_nsConditionLock;
}

// UI
@property (nonatomic, strong) UIButton *testButton;

// source
@property (nonatomic, strong) NSMutableDictionary *resource;

@end

@implementation LockDemoHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.testButton.frame = CGRectMake(100, 100, 100, 50);
    self.testButton.backgroundColor = [UIColor greenColor];
    [self.testButton setTitle:@"测试" forState:UIControlStateNormal];
    [self.testButton addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.testButton];
}

- (void)test {
    // 自旋锁
//    [self testOsAtomic];
//    [self testOsAtomic2];
    
    // 信号量
//    [self testSemaphore];
    
    // 互斥锁
//    [self testMutex];
    
    // NSLock
//    [self testNSLock];
    
    // NSCondition
//    [self testNSCondition];
    
    // 递归锁
//    [self testRecursiveMutex];
    
    // NSRecursiveLock
//    [self testNSRecursiveLock];

    // NSConditionLock
//    [self testNSConditionLock];
    
    // synchronized
//    [self testSynchronized];
    
    // test Time
//    [self testTime];
}

#pragma mark - lock

- (void)testLock {
}

- (void)testOsAtomic {

    /*
     OS_SPINLOCK_INIT 默认值为 0，unlocked状态下为 0，在 locked 状态时就会大于 0
     OSSpinLockLock(volatile OSSpinLock *__lock) 上锁，参数为 OSSpinLock 地址
     OSSpinLockUnlock(volatile OSSpinLock *__lock) 解锁，参数为 OSSpinLock 地址
     OSSpinLockTry(volatile OSSpinLock *__lock) 尝试加锁，如果可以加锁则立即加锁并返回YES，反之返回NO
     */
    _osSpinLock = OS_SPINLOCK_INIT;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1 准备上锁");
        OSSpinLockLock(&self->_osSpinLock);
        NSLog(@"线程1 执行任务");
        sleep(2);
        OSSpinLockUnlock(&self->_osSpinLock);
        NSLog(@"线程1 解锁成功");
    });
    
    // 线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1 准备上锁");
        while (OSSpinLockTry(&self->_osSpinLock) != true) {
            usleep(10 * 1000);
            NSLog(@"线程1 等待...");
        }
        NSLog(@"线程1 执行任务");
        sleep(2);
        OSSpinLockUnlock(&self->_osSpinLock);
        NSLog(@"线程1 解锁成功");
    });
    
    // 线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2 准备上锁");
        while (OSSpinLockTry(&self->_osSpinLock) != true) {
            usleep(10 * 1000);
            NSLog(@"线程2 等待...");
        }
        NSLog(@"线程2 执行任务");
        OSSpinLockUnlock(&self->_osSpinLock);
        NSLog(@"线程2 解锁成功");
    });
}

- (void)testOsAtomic2 {
    // 替换自旋锁的方案 iOS10以上可用
    _unfairLock = &OS_UNFAIR_LOCK_INIT;
    
    NSLog(@"准备上锁");
    os_unfair_lock_lock(_unfairLock);
    NSLog(@"执行任务");
    sleep(2);
    os_unfair_lock_unlock(_unfairLock);
    NSLog(@"解锁成功");
}

- (void)testSemaphore {
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(1);
    }
    
    // 执行dispatch_semaphore_wait时如果信号量为0则会阻塞当前线程，直到超时或信号量大于0。
    // 超时时信号量由于是0不会再减1变成负数，所以超时时如果继续走后续的代码再执行signal会导致信号量多了1
    dispatch_time_t timeout = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1 等待信号");
        while (dispatch_semaphore_wait(self->_semaphore, timeout) != 0) {
            NSLog(@"线程1 等待...");
        }
        NSLog(@"线程1 执行任务");
        sleep(2);
        dispatch_semaphore_signal(self->_semaphore);
        NSLog(@"线程1 发送信号");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2 等待信号");
        while (dispatch_semaphore_wait(self->_semaphore, timeout) != 0) {
            NSLog(@"线程2 等待...");
        }
        NSLog(@"线程2 执行任务");
        dispatch_semaphore_signal(self->_semaphore);
        NSLog(@"线程2 发送信号");
    });
}

- (void)testMutex {
    pthread_mutex_init(&_mutexLock, NULL);
    
    // 线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1 准备上锁");
        while (pthread_mutex_trylock(&self->_mutexLock) != 0) {
            usleep(10 * 1000);
            NSLog(@"线程1 等待...");
        }
        NSLog(@"线程1 执行任务");
        sleep(2);
        pthread_mutex_unlock(&self->_mutexLock);
        NSLog(@"线程1 解锁成功");
    });
    
    // 线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2 准备上锁");
        while (pthread_mutex_trylock(&self->_mutexLock) != 0) {// 返回 0（成功） 非0（错误码）
            usleep(10 * 1000);
            NSLog(@"线程2 等待...");
        }
        NSLog(@"线程2 执行任务");
        pthread_mutex_unlock(&self->_mutexLock);
        NSLog(@"线程2 解锁成功");
    });
}

- (void)testNSLock {
    _nsLock = [[NSLock alloc] init];
    
    // 线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1 准备上锁");
        [self->_nsLock lock];
        NSLog(@"线程1 执行任务");
        sleep(2);
        [self->_nsLock unlock];
        NSLog(@"线程1 解锁成功");
    });
    
    // 线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2 准备上锁");
//        while (![_nsLock tryLock]) {
//            usleep(10 * 1000);
//            NSLog(@"线程2 等待...");
//        }
        
        while (![self->_nsLock lockBeforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]]) {
            NSLog(@"线程2 等待...");
        }
        
        NSLog(@"线程2 执行任务");
        [self->_nsLock unlock];
        NSLog(@"线程2 解锁成功");
    });
}

- (void)testNSCondition {
    _condition = [NSCondition new];
    
    // 线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1 准备上锁");
        [self->_condition lock];
        NSLog(@"线程1 等待中...");
        [self->_condition wait];
        [self->_condition unlock];
        NSLog(@"线程1 解锁成功");
    });
    
    // 线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2 准备上锁");
        [self->_condition lock];
        NSLog(@"线程2 等待中...");
        [self->_condition wait];
        [self->_condition unlock];
        NSLog(@"线程2 解锁成功");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(5);
        NSLog(@"唤醒一个等待的线程");
        [self->_condition signal];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(10);
        NSLog(@"唤醒所有等待的线程");
        [self->_condition broadcast];
    });
}

- (void)testRecursiveMutex {
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
    pthread_mutex_init(&_recursiveMutexLock, &attr);
    pthread_mutexattr_destroy(&attr);
    
    // 以下代码，如果不使用递归锁，则会在value=4上锁时产生死锁。
    
    // 线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static void(^recursiveBlock)(int);
        recursiveBlock = ^(int value) {
            NSLog(@"准备上锁 %i", value);
            pthread_mutex_lock(&self->_recursiveMutexLock);
            if (value > 0) {
                NSLog(@"执行任务%i", value);
                recursiveBlock(value - 1);
            }
            pthread_mutex_unlock(&self->_recursiveMutexLock);
            NSLog(@"解锁成功 %i", value);
        };
        recursiveBlock(5);
    });
}

- (void)testNSRecursiveLock {
    _nsRecursiveLock = [[NSRecursiveLock alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static void(^recursiveLockBlock)(int);
        recursiveLockBlock = ^(int value) {
            NSLog(@"准备上锁 %i", value);
            [self->_nsRecursiveLock lock];
            if (value > 0) {
                NSLog(@"执行任务%i", value);
                recursiveLockBlock(value - 1);
            }
            [self->_nsRecursiveLock unlock];
            NSLog(@"解锁成功 %i", value);
        };
        
        recursiveLockBlock(5);
    });
}

- (void)testNSConditionLock {
    _nsConditionLock = [[NSConditionLock alloc] initWithCondition:0];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self->_nsConditionLock lockWhenCondition:1];
        NSLog(@"请求数据1");
        sleep(2);
        NSLog(@"得到数据1");
        [self->_nsConditionLock unlockWithCondition:2];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        [self->_nsConditionLock lockWhenCondition:0];
        NSLog(@"请求数据2");
        sleep(2);
        NSLog(@"得到数据2");
        [self->_nsConditionLock unlockWithCondition:1];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self->_nsConditionLock lockWhenCondition:2];
        NSLog(@"请求数据3");
        sleep(2);
        NSLog(@"得到数据3");
        [self->_nsConditionLock unlockWithCondition:0];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self->_nsConditionLock lockWhenCondition:2];
        NSLog(@"请求数据4");
        sleep(2);
        NSLog(@"得到数据4");
        [self->_nsConditionLock unlock];
    });
}

- (void)testSynchronized {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized (self) {
            sleep(2);
            NSLog(@"线程1");
        }
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized (self) {
            NSLog(@"线程2");
        }
    });
}

#pragma mark - task

- (void)task:(NSMutableDictionary *)resource {
    CGFloat goodsPrice  = 500;
    CGFloat balance     = [resource[@"balance"] floatValue];
    NSString *bank      = resource[@"bank"];
    NSString *bankCard  = resource[@"bankCard"];
    bankCard = [bankCard substringWithRange:NSMakeRange(bankCard.length - 4, 4)];
    
    balance -= goodsPrice;
    [resource setObject:[@(balance) stringValue] forKey:@"balance"];
    
    NSLog(@"[%@]尾号[%@] 消费%.2f 余额%.2f", bank, bankCard, goodsPrice, balance);
}

- (NSMutableDictionary *)resource {
    if (!_resource) {
        _resource = @{@"bank": @"招商银行",
                      @"bankCard": @"6214000000008274",
                      @"secret": @"123456",
                      @"balance": @"50000"}.mutableCopy;
    }
    return _resource;
}

@end
