//
//  ZCPKitTests.m
//  ZCPKitTests
//
//  Created by 朱超鹏 on 2017/9/1.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZCPCommon.h"

@interface ZCPKitTests : XCTestCase

@end

@implementation ZCPKitTests

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
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testOpenURL {
    NSString *url = @"";
    url = @"https://www.baidu.com"; // ok
    url = @"https://www.baidu.com?&_openWith=browser&_title=SimBlog"; // ok
    url = @"https://www.baidu.com?&_openWith=webview_blank"; // ok
    url = @"https://www.baidu.com?&_openWith=webview_blank&_title=SimBlog&_needsNavigationBar=false"; // ok
    url = @"https://www.baidu.com?&_openWith=webview_keep&_title=SimBlog&_needsNavigationBar=true"; // ok
    url = @"simblog://view/view"; // ok
    url = @"simblog://view/webview?_url=https%3a%2f%2fwww.baidu.com&_openWith=browser"; // ok
    url = @"simblog://view/webview?_url=https%3a%2f%2fwww.baidu.com&_openWith=webview_blank&_title=SimBlog&_needsNavigationBar=false"; // ok
    url = @"simblog://view/webview?_url=https%3a%2f%2fwww.baidu.com&_openWith=webview_keep&_title=SimBlog&_needsNavigationBar=true"; // ok
    url = @"simblog://view/webview?_url=https%3a%2f%2fwww.baidu.com&_openWith=webview_keep"; // ok
    url = @"simblog://view/webview?_url=https%3a%2f%2fwww.baidu.com&_title=SimBlog+WebView+Title"; // ok
    url = @"simblog://view/webview?_url=https%3a%2f%2fwww.baidu.com&_title=%e6%88%91%e6%98%af%e4%b8%ad%e5%9b%bd%e4%ba%ba"; // ok
    url = @"simblog://service/helloWorld"; // ok
    
    openURL(url);
}

@end
