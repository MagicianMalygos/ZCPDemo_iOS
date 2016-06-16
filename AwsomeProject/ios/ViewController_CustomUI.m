//
//  ViewController_CustomUI.m
//  AwsomeProject
//
//  Created by apple on 16/1/11.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "ViewController_CustomUI.h"

#import <RCTRootView.h>

@interface ViewController_CustomUI ()

@end

@implementation ViewController_CustomUI

- (void)viewDidLoad {
    [super viewDidLoad];
  
  NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8089/vc_customUI.ios.bundle?plateform=ios&dev=true"];
  RCTRootView *view = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                  moduleName:@"AwsomeProject"
                                           initialProperties:nil
                                               launchOptions:nil];
  self.view = view;
}

@end
