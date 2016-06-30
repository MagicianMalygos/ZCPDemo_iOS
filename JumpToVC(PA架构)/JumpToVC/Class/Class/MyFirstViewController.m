//
//  MyFirstViewController.m
//  JumpToVC
//
//  Created by apple on 15/12/4.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MyFirstViewController.h"

@interface MyFirstViewController ()

@property (nonatomic, weak) UIButton *jumpButton;

@end

@implementation MyFirstViewController

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
    
    [self registerKeyboardNotification];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *jumpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [jumpButton setFrame:CGRectMake(100, 100, 200, 100)];
    [jumpButton setBackgroundColor:[UIColor redColor]];
    [jumpButton addTarget:self action:@selector(jumpBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.jumpButton = jumpButton;
    [self.view addSubview:jumpButton];
    
    
    UITextField *textField = [UITextField new];
    [textField setFrame:CGRectMake(100, 300, 200, 100)];
    [self.view addSubview:textField];
}
- (void)jumpBtnClick {
    [[MyNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_MY_SUB_FIRST paramDictForInit:@{@"1":@"a", @"2":@"b"}];
}

@end
