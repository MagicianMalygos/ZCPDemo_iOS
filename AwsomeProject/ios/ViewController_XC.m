//
//  ViewController_XC.m
//  AwsomeProject
//
//  Created by apple on 16/1/7.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "ViewController_XC.h"

#import <RCTRootView.h>

@interface ViewController_XC ()

@end

@implementation ViewController_XC

- (void)viewDidLoad {
    [super viewDidLoad];
  NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8089/vc_xc.ios.bundle?platform=ios&dev=true"];
  RCTRootView *view = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                              moduleName:@"AwsomeProject"
                       initialProperties:nil
                           launchOptions:nil];
  self.view = view;
}

@end
