//
//  TestViewController.m
//  ZCPKitDemo
//
//  Created by 朱超鹏 on 2017/9/11.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.textField];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.titleLabel.frame = CGRectMake(0, 0, 200, 20);
    self.titleLabel.center = self.view.center;
    self.textField.frame = CGRectMake(self.titleLabel.center.x - 150, self.titleLabel.bottom + 50, 300, 40);
}

#pragma mark -  getters and setters

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:20.0f];
        _titleLabel.textColor = [UIColor redColor];
        _titleLabel.text = @"这是首页";
    }
    return _titleLabel;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.font = [UIFont systemFontOfSize:15.0f];
        _textField.tintColor = [UIColor redColor];
        _textField.textColor = [UIColor redColor];
        _textField.layer.borderWidth = 1;
        _textField.layer.borderColor = [UIColor redColor].CGColor;
        _textField.placeholder = @"点击弹起键盘，点击view收起键盘";
    }
    return _textField;
}

@end
