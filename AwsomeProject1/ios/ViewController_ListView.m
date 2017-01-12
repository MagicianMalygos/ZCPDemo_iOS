//
//  ViewController_ListView.m
//  AwsomeProject
//
//  Created by apple on 16/1/13.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "ViewController_ListView.h"

#import <RCTRootView.h>

@implementation ViewController_ListView

- (void)viewDidLoad {
  [super viewDidLoad];
  
  NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8089/vc_listview.ios.bundle?plateform=ios&dev=true"];
  RCTRootView *view = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                  moduleName:@"AwsomeProject"
                                           initialProperties:nil
                                               launchOptions:nil];
  self.view = view;
}

@end
