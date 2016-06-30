//
//  UnitTestDemoTests.m
//  UnitTestDemoTests
//
//  Created by apple on 16/4/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <AFNetworking.h>
#import <STAlertView.h>
#import "Macro.h"

@interface UnitTestDemoTests : XCTestCase

@property (nonatomic, strong) STAlertView *stAlertView;

@end

@implementation UnitTestDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSLog(@"自定义测试testExample");
    int a = 3;
    XCTAssertTrue(a != 0, "a 不为 0");
}

- (void)testRequest {
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    // 发送get请求
    [manager GET:@"http://www.weather.com.cn/adat/sk/101110101.html"
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
        NSLog(@"responseObject:%@", responseObject);
        XCTAssertNotNil(responseObject, @"返回错误");
        NOTIFY;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@", error);
        XCTAssertNil(error, @"请求错误");
        NOTIFY;
    }];
    WAIT;
    
    self.stAlertView = [[STAlertView alloc] initWithTitle:@"验证码" message:nil textFieldHint:@"请输入手机验证码" textFieldValue:nil cancelButtonTitle:@"取消" otherButtonTitle:@"确认" cancelButtonBlock:^{
        NOTIFY;
    } otherButtonBlock:^(NSString *str) {
        // 点击确定后执行
        NOTIFY;
    }];
    [self.stAlertView show];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
