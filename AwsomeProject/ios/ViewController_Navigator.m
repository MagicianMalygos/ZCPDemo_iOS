//
//  ViewController_Navigator.m
//  AwsomeProject
//
//  Created by apple on 16/1/12.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "ViewController_Navigator.h"

#import <RCTRootView.h>

@interface ViewController_Navigator ()

@end

@implementation ViewController_Navigator

- (void)viewDidLoad {
    [super viewDidLoad];
  NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8089/vc_navigator.ios.bundle?plateform=ios&dev=true"];
  RCTRootView *view = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                  moduleName:@"AwsomeProject"
                                           initialProperties:nil
                                               launchOptions:nil];
  self.view = view;
}

@end
