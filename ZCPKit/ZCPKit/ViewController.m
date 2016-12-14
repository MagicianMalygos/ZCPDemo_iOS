//
//  ViewController.m
//  ZCPKit
//
//  Created by zhuchaopeng on 16/9/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ViewController.h"
#import "ZCPToastUtil.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self toast];
}

#pragma mark - unit test

- (void)toast {
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 100, 20)];
    tf.layer.borderWidth = 1.0f;
    tf.layer.borderColor = UIColorFromRGB(0x00ff00).CGColor;
    [self.view addSubview:tf];
    [tf becomeFirstResponder];
    
    [ZCPToastUtil showToast:@"abc" inView:self.view];
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

@end
