//
//  DemoBaseViewController.m
//  Demo
//
//  Created by 朱超鹏(外包) on 17/1/11.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "DemoBaseViewController.h"

@interface DemoBaseViewController ()

@end

@implementation DemoBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
//    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView)]];
    [self test];
}

- (void)test {
}

//- (void)clickView {
//    [self.view resignFirstResponder];
//}as

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:NO];
}

@end
