//
//  QiPaoDemoHomeController.m
//  Demo
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "QiPaoDemoHomeController.h"

@interface QiPaoDemoHomeController ()

@property (nonatomic, strong) UITextField *tf;
@property (nonatomic, strong) UIButton *contentButton;

@end

@implementation QiPaoDemoHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextField *tf = [[UITextField alloc] initWithFrame:({
        CGRectMake(0, 64, CGRectGetWidth([[UIScreen mainScreen] bounds]) - 50, 50);
    })];
    tf.backgroundColor = [UIColor redColor];
    _tf = tf;
    [self.view addSubview:_tf];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(CGRectGetWidth([[UIScreen mainScreen] bounds]) - 50, 64, 50, 50);
    button.backgroundColor = [UIColor greenColor];
    [button addTarget:self action:@selector(updateTextArea) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    _contentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _contentButton.frame = CGRectMake(0, 164, 240, 0);
    _contentButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    _contentButton.titleLabel.numberOfLines = 0;
    [_contentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _contentButton.titleEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
    [self.view addSubview:_contentButton];
}

// qq聊天气泡的拉伸效果
- (void)updateTextArea {
    
    // 设置frame
    NSString *content = _tf.text;
    CGRect rect = [content boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13.0f]} context:nil];
    
    CGRect frame = CGRectMake(0, 164, 240, rect.size.height + 20 * 2);
    _contentButton.frame = frame;
    
    // 设置bg图
    UIImage *bgImage = [UIImage imageNamed:@"chat_recive_press_pic"];
    // 指定拉伸区域，设置端盖的大小，http://blog.csdn.net/chaoyuan899/article/details/19811889
    UIImage *bgImage2 = [bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(28, 32, 28, 32) resizingMode:UIImageResizingModeStretch];
    [_contentButton setBackgroundImage:bgImage2 forState:UIControlStateNormal];
    
    
    // 设置文本
    [_contentButton setTitle:_tf.text forState:UIControlStateNormal];
    
}

@end
