//
//  Nokia5230Phone.h
//  Demo
//
//  Created by 朱超鹏 on 2017/9/18.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "NokiaPhone.h"

@interface Nokia5230Phone : NokiaPhone

@property (nonatomic, assign, readonly) BOOL gps;
@property (nonatomic, assign, readonly) BOOL blueTooth;

- (NSString *)callNumberWithGPS;
- (NSString *)callNumberWithBlueTooth;
- (NSString *)callNumberWithGPSAndBlueTooth;
- (NSString *)sendMessageWithGPS;
- (NSString *)sendMessageWithBlueTooth;
- (NSString *)sendMessageWithGPSAndBlueTooth;

- (NSString *)openGPS;
- (NSString *)closeGPS;
- (NSString *)openBlueTooth;
- (NSString *)closeBlueTooth;

@end
