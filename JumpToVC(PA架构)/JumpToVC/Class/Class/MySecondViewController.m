//
//  MySecondViewController.m
//  JumpToVC
//
//  Created by apple on 15/12/4.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MySecondViewController.h"

@interface MySecondViewController ()

@property (nonatomic, weak) UILabel *label;

@end

@implementation MySecondViewController

#pragma mark - 初始化方法
- (instancetype)initWithParams:(NSDictionary *)params {
    if (self = [super init]) {
        NSLog(@"%@", params);
    }
    return self;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 100)];
    [label setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:label];
}

@end
