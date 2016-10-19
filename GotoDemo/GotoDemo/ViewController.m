//
//  ViewController.m
//  GotoDemo
//
//  Created by zhuchaopeng on 16/10/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoNextVC)]];
}


- (void)gotoNextVC {
    ViewController *vc = [ViewController new];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
