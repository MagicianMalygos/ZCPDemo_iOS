//
//  ViewController_MT.m
//  AwsomeProject
//
//  Created by apple on 16/1/7.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "ViewController_MT.h"

#import <RCTRootView.h>

@interface ViewController_MT ()

@end

@implementation ViewController_MT

- (void)viewDidLoad {
    [super viewDidLoad];
  NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8089/vc_mt.ios.bundle?platform=ios&dev=true"];
  RCTRootView *view = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                  moduleName:@"AwsomeProject"
                                           initialProperties:nil
                                               launchOptions:nil];
  
  self.view = view;
}


@end
