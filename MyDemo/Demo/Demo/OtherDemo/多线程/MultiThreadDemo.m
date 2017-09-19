//
//  MultiThreadDemo.m
//  Demo
//
//  Created by 朱超鹏 on 2017/9/14.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "MultiThreadDemo.h"
#import "TestOperation.h"

@implementation MultiThreadDemo

- (void)run {
    
    /**
     队列是一个对象，可以接收任务，将任务已先到先执行的顺序来执行。
     队列有三种：
         主队列    与主线程相关的串行队列。dispatch_get_main_queue()
         全局队列   并发队列，整个进程共享。区分优先级。dispatch_get_global_queue()
         用户队列   根据需求创建串行队列或者并发队列
     
     注意：主队列中添加同步操作永远不会被执行，会死锁。
     同步是不跳出当前线程去执行任务，异步是跳出当前线程开辟新线程执行任务。
     
     同步执行：同步执行的任务会在当前线程中执行。
     异步执行：异步执行的任务会新开一个线程去执行。
     同步异步主要体现在线程上。是否会阻塞当前线程，是否新开线程。
     
     队列：用于存放任务。
     串行队列：一次只执行一个线程，按照任务添加到队列的顺序执行。
     并行队列：一次可以执行多个线程，线程的执行没有先后顺序。
     队列主要体现在任务的执行顺序上。
     */
    
    /// 1.测试主队列
//    [self testMainQueue];
    
    /// 2.测试全局队列
//    [self testGlobalQueue];
    
    /// 3.测试用户队列
    // 串行队列中执行同步任务：任务在当前线程中执行；队列中的每个任务按顺序执行。
//    [self syncTask_SerialQueue];
    // 串行队列中执行异步任务：任务在新开线程中执行；队列中的每个任务按顺序执行。
//    [self asyncTask_SerialQueue];
    // 并发队列中执行同步任务：任务在当前线程中执行；队列中的每个任务按顺序执行，这是因为同步任务会在前一个任务执行完毕后才会执行下一个任务，打断点可以看到，只有前一个task执行完毕，for循环才会继续走下去，所以才导致了这种顺序执行。
//    [self syncTask_ConcurrentQueue];
    // 并发队列中执行异步任务：任务在新开线程中执行；队列中的每个任务并发执行。
//    [self asyncTask_ConcurrentQueue];
    
    /// 4.测试异常情况
//    [self testException];
    
    /// 5.其他gcd功能
//    [self testOther];
    
    
    /**
     NSOperation
     */
    [self testOperation];
}


#pragma mark - gcd

#pragma mark 测试主队列
- (void)testMainQueue {
    // 一般使用场景是：在子线程中执行任务需要更新UI时，可以在主队列中执行更新UI的任务
    NSLog(@"1%@", [NSThread currentThread]);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 在子线程中需要更新UI时
        NSLog(@"2%@", [NSThread currentThread]);
        
        // 异步任务
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"3%@", [NSThread currentThread]);
            NSLog(@"在此更新UI");
        });
        
        // 同步任务会阻塞主线程
        dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"3%@", [NSThread currentThread]);
            NSLog(@"在此更新UI");
        });
    });
    
}

#pragma mark 测试全局队列
- (void)testGlobalQueue {
    // 由于全局队列是全局队列，任务执行在不同的线程中，任务执行的顺序随机。
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < 10; i++) {
        dispatch_async(queue, ^{
            NSLog(@"在全局队列中执行任务%d %@", i, [NSThread currentThread]);
        });
    }
}

#pragma mark 测试用户队列
// 同步方式执行任务 串行队列
- (void)syncTask_SerialQueue {
    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_SERIAL);
    
    for (int i = 0; i < 10; i++) {
        void(^task)() = ^() {
            sleep(1);
            NSLog(@"%d %@", i, [NSThread currentThread]);
        };
        // 在当前线程执行任务。由于是同步方式执行任务，sleep会阻塞当前线程，直到queue队列中的任务执行完毕
        dispatch_sync(queue, task);
    }
}

// 异步方式执行任务 串行队列
- (void)asyncTask_SerialQueue {
    dispatch_queue_t queue = dispatch_queue_create("asyncTask_SerialQueue", DISPATCH_QUEUE_SERIAL);
    
    for (int i = 0; i < 10; i++) {
        void(^task)() = ^() {
            sleep(1);
            NSLog(@"%d %@", i, [NSThread currentThread]);
        };
        // 在子线程中按顺序执行任务
        dispatch_async(queue, task);
    }
}

// 同步方式执行任务 并发队列
- (void)syncTask_ConcurrentQueue {
    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    
    for (int i = 0; i < 10; i++) {
        void(^task)() = ^() {
            for (int i = 0; i < 100; i++) {
                DebugLog(@"%d %@", i, [NSThread currentThread]);
            }
            NSLog(@"%d %@", i, [NSThread currentThread]);
        };
        // 在当前线程执行任务
        dispatch_sync(queue, task);
    }
}


// 异步方式执行任务 并发队列
- (void)asyncTask_ConcurrentQueue {
    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    
    for (int i = 0; i < 10; i++) {
        void(^task)() = ^() {
            sleep(1);
            NSLog(@"%d %@", i, [NSThread currentThread]);
        };
        // 开了多个子线程执行任务
        dispatch_async(queue, task);
    }
}

#pragma mark 测试异常情况
- (void)testException {
    
    // 1.主线程中在主队列上执行同步任务导致死锁。
    // 由于是同步任务，只有当前一个任务执行完毕后才会执行下一个任务。此时主队列正在执行testException方法，该方法中又在主队列上执行mainTask。由于testException还未执行完毕，所以mainTask任务会等待testException执行完毕，又因为mainTask执行完毕后testException方法才能走下去，所以产生死锁。
    void(^mainTask)() = ^() {
        NSLog(@"主线程中执行，在主队列中执行同步任务");
    };
    dispatch_sync(dispatch_get_main_queue(), mainTask);
    
    // 2.模拟主线程中执行同步任务导致的死锁原因一致的情况
    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_SERIAL);
    void(^task1)() = ^() {
        void(^task2)() = ^() {
            NSLog(@"hehe");
        };
        dispatch_sync(queue, task2);
        NSLog(@"haha");
    };
    dispatch_sync(queue, task1);
}

#pragma mark 其他gcd功能
- (void)testOther {
    /// 1.once，常用于单例的实现，使用dispatch_once是线程安全的。
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 里面的代码只会执行一次
        NSLog(@"我只会执行一次");
    });
    dispatch_once(&onceToken, ^{
        NSLog(@"我可以再执行一次吗？");
    });
    
    /// 2.调度信号
    /**
     dispatch_semaphore_t 调度信号
     dispatch_semaphore_create 创建一个调度信号。参数为信号量
     dispatch_semaphore_signal 使调度信号的信号量+1
     dispatch_semaphore_wait 判断调度信号的信号量是否为0，为0则等待阻塞当前线程。第二个参数为阻塞等待时间。
     */
    
    // demo1，执行到dispatch_semaphore_wait时主线程被阻塞，只有当子线程的block中dispatch_semaphore_signal被执行时，才会恢复主线程。
    {
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"demo1 子线程开始执行");
            sleep(5);
            NSLog(@"demo1 子线程结束执行");
            dispatch_semaphore_signal(semaphore);
        });
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    }
    
    // demo2
    {
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0); // 创建一个信号量为0的调度信号
        // 开启子线程
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"demo2 子线程开始执行");
            sleep(5);
            NSLog(@"demo2 子线程结束执行");
            // 使调度信号的信号量+1
            dispatch_semaphore_signal(semaphore);
        });
        while(1) {
            // 如果调度信号的信号量为0则等待，阻塞当前线程
            dispatch_time_t timeout = dispatch_time(DISPATCH_TIME_NOW, 2*NSEC_PER_SEC);
            long wait = dispatch_semaphore_wait(semaphore, timeout);
            if (!wait) {
                NSLog(@"结束等待");
                break;
            }
            NSLog(@"等待中");
            // 0.5秒runloop循环
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
        }
    }
}

#pragma mark - NSOperation

- (void)testOperation {
    
    /// 1.NSOperation和NSOperationQueue的使用
    // 使用框架封装好的类去处理任务，执行单个任务时会在当前线程中执行，执行多个任务时会在当前线程和新开的线程中并发执行任务。
    {
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"执行了一个任务 %@", [NSThread currentThread]);
        }];
        for (int i = 0; i < 5; i++) {
            [operation addExecutionBlock:^{
                NSLog(@"多执行了一个任务 %@", [NSThread currentThread]);
            }];
        }
        [operation start];
    }
    
    // 使用alloc init创建出来的Queue，会开启子线程来执行任务。使用mainQueue，会在主线程中执行任务。dispatch开启的子线程没有currentQueue
    {
        TestOperation *operation = [[TestOperation alloc] init]; // 自定义operation
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        queue = [NSOperationQueue currentQueue];
        NSLog(@"%@", queue);
        [queue addOperation:operation];// 当把operation放到queue中时，operation会自动执行start方法。
    }
    
    /// 2.任务依赖
    {
        NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
            sleep(3);
            NSLog(@"完成任务1");
        }];
        NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
            sleep(1);
            NSLog(@"完成任务2");
        }];
        NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
            sleep(2);
            NSLog(@"完成任务3");
        }];
        NSBlockOperation *operation4 = [NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"完成任务4");
        }];
        [operation4 addDependency:operation1];
        [operation4 addDependency:operation2];
        [operation4 addDependency:operation3];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [queue addOperations:@[operation1, operation2, operation3, operation4] waitUntilFinished:NO];
    }
    
}


@end
