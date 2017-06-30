//
//  AlgorithmTests.m
//  Demo
//
//  Created by 朱超鹏 on 2017/6/28.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RegexDemo.h"

@interface RegexTests : XCTestCase

@property (nonatomic, strong) RegexDemo *regexDemo;

@end

@implementation RegexTests

- (void)setUp {
    [super setUp];
    self.regexDemo = [RegexDemo new];
}

- (void)tearDown {
    self.regexDemo = nil;
    [super tearDown];
}

- (void)testJudgePassword {
    
    NSArray *keyValues = @[@{@"123": @"NO"},
                           @{@"1234567": @"NO"},
                           @{@"abc123": @"NO"},
                           @{@"Zcp123": @"YES"},
                           @{@"Zchaopeng123": @"YES"},
                           @{@"Zcpmac1_80437": @"YES"},
                           @{@"Zcpabcdef1234567890": @"NO"}];

    for (NSDictionary *keyValue in keyValues) {
        [keyValue enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSLog(@"%@ %@", key, obj);
            BOOL result = [self.regexDemo judgePassword:key];
            BOOL assert = result == [obj boolValue];
            XCTAssertTrue(assert, @"校验密码强度方法测试未通过！！");
        }];
    }
}

- (void)testJudgeChinese {
    NSArray *keyValues = @[@{@"一二三": @"YES"},
                           @{@"中国人": @"YES"},
                           @{@"……&": @"NO"},
                           @{@"123": @"NO"},
                           @{@"an": @"NO"},
                           @{@"……&哈": @"NO"},
                           @{@"123哈": @"NO"},
                           @{@"an哈": @"NO"},
                           @{@"😁": @"NO"}];
    
    for (NSDictionary *keyValue in keyValues) {
        [keyValue enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSLog(@"%@ %@", key, obj);
            BOOL result = [self.regexDemo judgeChinese:key];
            BOOL assert = result == [obj boolValue];
            XCTAssertTrue(assert, @"校验是否存在中文方法测试未通过！！");
        }];
    }
}

- (void)testJudgeNumberWordUpperLine {
    NSArray *keyValues = @[@{@"中": @"NO"},
                           @{@"……&": @"NO"},
                           @{@"123": @"YES"},
                           @{@"abc": @"YES"},
                           @{@"__": @"YES"},
                           @{@"abc123": @"YES"},
                           @{@"abc_123": @"YES"},
                           @{@"😁": @"NO"}];
    
    for (NSDictionary *keyValue in keyValues) {
        [keyValue enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSLog(@"%@ %@", key, obj);
            BOOL result = [self.regexDemo judgeNumberWordUpperLine:key];
            BOOL assert = result == [obj boolValue];
            XCTAssertTrue(assert, @"校验纯数字英文下划线方法测试未通过！！");
        }];
    }
}

- (void)testJudgeEmail {
    NSArray *keyValues = @[@{@"164757979@qq.com": @"YES"},
                           @{@"@.com": @"NO"},
                           @{@"123@456.": @"NO"},
                           @{@"1234an@": @"NO"}];
    
    for (NSDictionary *keyValue in keyValues) {
        [keyValue enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSLog(@"%@ %@", key, obj);
            BOOL result = [self.regexDemo judgeEmail:key];
            BOOL assert = result == [obj boolValue];
            XCTAssertTrue(assert, @"校验e-mail地址方法测试未通过！！");
        }];
    }
}

- (void)testJudgeIDCard15 {
    NSArray *keyValues = @[@{@"411081225123411": @"NO"},
                           @{@"222102926182241": @"NO"},
                           @{@"000000000000000": @"NO"},
                           @{@"110105710923582": @"YES"},
                           @{@"1234567890": @"NO"}];
    
    for (NSDictionary *keyValue in keyValues) {
        [keyValue enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSLog(@"%@ %@", key, obj);
            BOOL result = [self.regexDemo judgeIDCard15:key];
            BOOL assert = result == [obj boolValue];
            XCTAssertTrue(assert, @"校验15位身份证号方法测试未通过！！");
        }];
    }
}

- (void)testJudgeIDCard18 {
    NSArray *keyValues = @[@{@"411081192251234114": @"NO"},
                           @{@"222102199261822419": @"NO"},
                           @{@"000000190000000001": @"NO"},
                           @{@"110105197109235829": @"YES"},
                           @{@"41108119931211205X": @"YES"},
                           @{@"1234567890": @"NO"}];
    
    for (NSDictionary *keyValue in keyValues) {
        [keyValue enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSLog(@"%@ %@", key, obj);
            BOOL result = [self.regexDemo judgeIDCard18:key];
            BOOL assert = result == [obj boolValue];
            XCTAssertTrue(assert, @"校验18位身份证号方法测试未通过！！");
        }];
    }
}

- (void)testJudgeDate {
    NSArray *keyValues = @[@{@"2017-3-3": @"NO"},
                           @{@"2017-03-03": @"YES"},
                           @{@"2000-02-29": @"YES"},
                           @{@"2001-02-29": @"NO"},
                           @{@"2001-02-28": @"YES"},
                           @{@"2000-02-30": @"NO"},
                           @{@"2000-04-31": @"NO"},
                           @{@"2000-08-31": @"YES"}];
    
    for (NSDictionary *keyValue in keyValues) {
        [keyValue enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSLog(@"%@ %@", key, obj);
            BOOL result = [self.regexDemo judgeDate:key];
            BOOL assert = result == [obj boolValue];
            XCTAssertTrue(assert, @"校验日期方法测试未通过！！");
        }];
    }
}

- (void)testJudgePhoneNumber {
    
    NSArray *keyValues = @[@{@"18850459303": @"YES"},
                           @{@"12345678901": @"NO"},
                           @{@"18300001111": @"YES"},
                           @{@"15402201124": @"NO"}];
    
    for (NSDictionary *keyValue in keyValues) {
        [keyValue enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSLog(@"%@ %@", key, obj);
            BOOL result = [self.regexDemo judgePhoneNumber:key];
            BOOL assert = result == [obj boolValue];
            XCTAssertTrue(assert, @"校验手机号方法测试未通过！！");
        }];
    }
}

@end
