//
//  DesignPatternDemo.m
//  Demo
//
//  Created by 朱超鹏 on 2017/9/18.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "DesignPatternDemo.h"
#import "DecoratorHead.h"

@implementation DesignPatternDemo

- (void)run {
    
    [self decoratorPattern];
}


// 装饰模式
- (void)decoratorPattern {
    NokiaPhone *nokia = [NokiaPhone new];
    NSLog(@"%@", [nokia callNumber]);
    NSLog(@"%@", [nokia sendMessage]);
    
    // 使用继承的方式扩展。静态扩展，编译时已经确定了哪个类做什么事。
    Nokia5230Phone *nokia5230 = [Nokia5230Phone new];
    NSLog(@"%@", [nokia5230 closeGPS]);
    NSLog(@"%@", [nokia5230 callNumberWithGPS]);
    NSLog(@"%@", [nokia5230 sendMessageWithGPS]);
    NSLog(@"%@", [nokia5230 openGPS]);
    NSLog(@"%@", [nokia5230 callNumberWithGPS]);
    NSLog(@"%@", [nokia5230 sendMessageWithGPS]);
    
    NSLog(@"%@", [nokia5230 closeBlueTooth]);
    NSLog(@"%@", [nokia5230 callNumberWithBlueTooth]);
    NSLog(@"%@", [nokia5230 sendMessageWithBlueTooth]);
    NSLog(@"%@", [nokia5230 openBlueTooth]);
    NSLog(@"%@", [nokia5230 callNumberWithBlueTooth]);
    NSLog(@"%@", [nokia5230 sendMessageWithBlueTooth]);
    
    NSLog(@"%@", [nokia5230 closeGPS]);
    NSLog(@"%@", [nokia5230 closeBlueTooth]);
    NSLog(@"%@", [nokia5230 callNumberWithGPSAndBlueTooth]);
    NSLog(@"%@", [nokia5230 sendMessageWithGPSAndBlueTooth]);
    NSLog(@"%@", [nokia5230 openGPS]);
    NSLog(@"%@", [nokia5230 openBlueTooth]);
    NSLog(@"%@", [nokia5230 callNumberWithGPSAndBlueTooth]);
    NSLog(@"%@", [nokia5230 sendMessageWithGPSAndBlueTooth]);
    
    // 将原类装饰后，使用装饰类扩展。运行时扩展，无所谓是什么对象，只要实现了PhoneProtocol就进行扩展
    DecoratorGPS *gps = [[DecoratorGPS alloc] initWithPhone:nokia];
    NSLog(@"%@", [gps closeGPS]);
    NSLog(@"%@", [gps callNumber]);
    NSLog(@"%@", [gps sendMessage]);
    NSLog(@"%@", [gps openGPS]);
    NSLog(@"%@", [gps callNumber]);
    NSLog(@"%@", [gps sendMessage]);
    
    DecoratorBlueTooth *blueTooth = [[DecoratorBlueTooth alloc] initWithPhone:nokia];
    NSLog(@"%@", [blueTooth closeBlueTooth]);
    NSLog(@"%@", [blueTooth callNumber]);
    NSLog(@"%@", [blueTooth sendMessage]);
    NSLog(@"%@", [blueTooth openBlueTooth]);
    NSLog(@"%@", [blueTooth callNumber]);
    NSLog(@"%@", [blueTooth sendMessage]);
    
    DecoratorBlueTooth *gpsAndBlueTooth = [[DecoratorBlueTooth alloc] initWithPhone:gps];
    NSLog(@"%@", [gpsAndBlueTooth closeBlueTooth]);
    NSLog(@"%@", [gpsAndBlueTooth callNumber]);
    NSLog(@"%@", [gpsAndBlueTooth sendMessage]);
    NSLog(@"%@", [gpsAndBlueTooth openBlueTooth]);
    NSLog(@"%@", [gpsAndBlueTooth callNumber]);
    NSLog(@"%@", [gpsAndBlueTooth sendMessage]);
}

@end
