//
//  AlertViewDemoHomeController.m
//  UIAlertViewDemo
//
//  Created by apple on 16/3/9.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "AlertViewDemoHomeController.h"

@interface AlertViewDemoHomeController () <UIAlertViewDelegate>

@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;
@property (nonatomic, strong) UIButton *button4;

@property (nonatomic, strong) UIAlertView *alertView;
@property (nonatomic, strong) UIAlertController *alertViewController;

@end

@implementation AlertViewDemoHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button1.frame = CGRectMake(0, 100, 50, 50);
    self.button2.frame = CGRectMake(100, 100, 50, 50);
    self.button3.frame = CGRectMake(200, 100, 50, 50);
    self.button4.frame = CGRectMake(300, 100, 50, 50);
    self.button1.backgroundColor = [UIColor redColor];
    self.button2.backgroundColor = [UIColor greenColor];
    self.button3.backgroundColor = [UIColor blueColor];
    self.button4.backgroundColor = [UIColor magentaColor];
    [self.button1 addTarget:self action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];
    [self.button2 addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
    [self.button3 addTarget:self action:@selector(click3) forControlEvents:UIControlEventTouchUpInside];
    [self.button4 addTarget:self action:@selector(click4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button1];
    [self.view addSubview:self.button2];
    [self.view addSubview:self.button3];
    [self.view addSubview:self.button4];

}
// 基本alertView
- (void)click1 {
    /*
        UIAlertView
        1.当Button数不超过2个按钮则均显示在一行上，超过2个按钮则每个按钮单独占一行垂直排列
     */
    self.alertView = [[UIAlertView alloc] initWithTitle:@"提升能力" message:@"请选择要提升的能力值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"力量", @"敏捷", nil];
    [self.alertView show];
}
// 认识alertView中属性方法
- (void)click2 {
    /*
         UIAlertViewStyleDefault = 0,           // alert
         UIAlertViewStyleSecureTextInput,       // alert上有一个密码输入框，Placeholder为Password
         UIAlertViewStylePlainTextInput,        // alert上有一个输入框
         UIAlertViewStyleLoginAndPasswordInput  // alert上有一个Login输入框，一个Password输入框
     */
    self.alertView = [[UIAlertView alloc] init];
    self.alertView.delegate = self;
    
    // 设置alert上输入框样式
    self.alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    self.alertView.title = @"登陆";                   // 设置Title
    self.alertView.message = @"请输入账号和密码";       // 设置Message
    [self.alertView addButtonWithTitle:@"取消"];      // button index = 0
    [self.alertView addButtonWithTitle:@"力量"];      // button index = 1
    
    // 打印按钮Title
    for (int i = 0; i < self.alertView.numberOfButtons; i++) {
        NSLog(@"%@", [self.alertView buttonTitleAtIndex:i]);  // 获取按钮title
    }
    
    NSLog(@"%d", self.alertView.visible);
    [self.alertView show];
    NSLog(@"%d", self.alertView.visible);
    
}
// 自定义alertView
- (void)click3 {
    self.alertViewController = [UIAlertController alertControllerWithTitle:@"选择职业" message:@"请选择喜欢的职业，选择之后不能改变。" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"随机" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"随机");
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"战士" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"战士");
    }];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"法师" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"法师");
    }];
    [self.alertViewController addAction:action1];
    [self.alertViewController addAction:action2];
    [self.alertViewController addAction:action3];
    [self.alertViewController addAction:action4];
    
    [self presentViewController:self.alertViewController animated:YES completion:^{
    }];
}
- (void)click4 {
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"Button index: %li", buttonIndex);
    
    // 根据索引获取alert的TextField
    UITextField *textField0 = [self.alertView textFieldAtIndex:0];
    UITextField *textField1 = [self.alertView textFieldAtIndex:1];
    NSLog(@"Login: %@", textField0.text);
    NSLog(@"Password: %@", textField1.text);
}

@end
