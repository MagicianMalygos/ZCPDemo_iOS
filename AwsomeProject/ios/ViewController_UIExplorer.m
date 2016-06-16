//
//  ViewController_UIExplorer.m
//  AwsomeProject
//
//  Created by apple on 16/1/11.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "ViewController_UIExplorer.h"

#import <RCTRootView.h>

@interface ViewController_UIExplorer ()

@end

@implementation ViewController_UIExplorer

- (void)viewDidLoad {
    [super viewDidLoad];
  
  NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8089/UIExplorer/UIExplorerApp.ios.bundle?platform=ios&dev=true"];
  RCTRootView *view = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                  moduleName:@"AwsomeProject"
                                           initialProperties:nil
                                               launchOptions:nil];
  self.view = view;
}

@end
