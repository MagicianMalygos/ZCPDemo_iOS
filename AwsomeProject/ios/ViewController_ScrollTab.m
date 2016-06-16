//
//  ViewController_ScrollTab.m
//  AwsomeProject
//
//  Created by apple on 16/1/12.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "ViewController_ScrollTab.h"

#import <RCTRootView.h>

@interface ViewController_ScrollTab ()

@end

@implementation ViewController_ScrollTab

- (void)viewDidLoad {
    [super viewDidLoad];
  
    NSURL *jsCodeLocation = [NSURL  URLWithString:@"http://localhost:8089/vc_scrolltab.ios.bundle?plateform=ios&dev=true"];
    RCTRootView *view = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation moduleName:@"AwsomeProject" initialProperties:nil launchOptions:nil];
    self.view = view;
}

@end
