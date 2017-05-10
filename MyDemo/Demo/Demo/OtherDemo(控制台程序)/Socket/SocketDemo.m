//
//  SocketDemo.m
//  Demo
//
//  Created by 朱超鹏 on 17/5/9.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "SocketDemo.h"
#include <stdio.h>

@implementation SocketDemo

- (void)run {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self socketServer];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self socketClient];
    });
}

- (void)socketServer {
    
}

- (void)socketClient {
    
}

@end
