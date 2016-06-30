//
//  MyFirstSubViewController.m
//  JumpToVC
//
//  Created by apple on 15/12/4.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MyFirstSubViewController.h"

@interface MyFirstSubViewController ()

@end

@implementation MyFirstSubViewController

- (instancetype)initWithParams:(NSDictionary *)params {
    if (self = [super init]) {
        NSLog(@"%@", params);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

@end
