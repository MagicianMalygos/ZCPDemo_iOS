//
//  ViewController_Bridge.m
//  AwsomeProject
//
//  Created by apple on 16/1/12.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "ViewController_Bridge.h"

#import <RCTRootView.h>
#import "CalendarManager.h"

@interface ViewController_Bridge ()

@end

@implementation ViewController_Bridge

- (void)viewDidLoad {
    [super viewDidLoad];
  NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8089/vc_bridge.ios.bundle?plateform=ios&dev=true"];
 
  RCTRootView *view = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation moduleName:@"AwsomeProject" initialProperties:nil launchOptions:nil];
  self.view = view;
  
}

@end
