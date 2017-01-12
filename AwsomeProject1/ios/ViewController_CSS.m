//
//  ViewController_CSS.m
//  AwsomeProject
//
//  Created by apple on 16/1/7.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "ViewController_CSS.h"

#import <RCTRootView.h>

@interface ViewController_CSS ()

@end

@implementation ViewController_CSS

- (void)viewDidLoad {
    [super viewDidLoad];
  
    NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8089/vc_css.ios.bundle?platform=ios&dev=true"];
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                      moduleName:@"AwsomeProject"
                                               initialProperties:nil
                                                   launchOptions:nil];
  
  
  
  
  
  
    self.view = rootView;
}

@end
