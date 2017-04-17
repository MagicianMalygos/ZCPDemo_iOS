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
@property (nonatomic, strong) UIButton *contentButton2;

@end

@implementation QiPaoDemoHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextField *tf = [[UITextField alloc] initWithFrame:({
        CGRectMake(0, 20, CGRectGetWidth([[UIScreen mainScreen] bounds]) - 50, 50);
    })];
    tf.backgroundColor = [UIColor redColor];
    _tf = tf;
    [self.view addSubview:_tf];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(CGRectGetWidth([[UIScreen mainScreen] bounds]) - 50, 20, 50, 50);
    button.backgroundColor = [UIColor greenColor];
    [button addTarget:self action:@selector(updateTextArea) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    _contentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _contentButton.frame = CGRectMake(0, 100, 240, 0);
    _contentButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    _contentButton.titleLabel.numberOfLines = 0;
    [_contentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _contentButton.titleEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
    [self.view addSubview:_contentButton];
    
    _contentButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _contentButton2.frame = CGRectMake(0, 200, 240, 0);
    _contentButton2.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    _contentButton2.titleLabel.numberOfLines = 0;
    [_contentButton2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _contentButton2.titleEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
    [self.view addSubview:_contentButton2];
}

// qq聊天气泡的拉伸效果
- (void)updateTextArea {
    
    // 设置frame
    NSString *content = _tf.text;
    CGRect rect = [content boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13.0f]} context:nil];
    
    CGRect frame = CGRectMake(30, 100, rect.size.width + 30 * 2, rect.size.height + 20 * 2);
    _contentButton.frame = frame;
    CGRect frame2 = CGRectMake(30, 200, rect.size.width + 30 * 2, rect.size.height + 20 * 2);
    _contentButton2.frame = frame2;
    
    // 变量
    UIImage *bgImageOrigin;
    UIImage *bgImage;
    
    // 1.
    bgImageOrigin = [UIImage imageNamed:@"chat_recive_press_pic"];
    // 指定拉伸区域，设置端盖的大小，http://blog.csdn.net/chaoyuan899/article/details/19811889
    bgImage = [bgImageOrigin resizableImageWithCapInsets:UIEdgeInsetsMake(bgImageOrigin.size.height / 2 - 1, bgImageOrigin.size.width / 2 + 1, bgImageOrigin.size.height / 2 - 1, bgImageOrigin.size.width / 2 + 1) resizingMode:UIImageResizingModeStretch];
    [_contentButton setBackgroundImage:bgImage forState:UIControlStateNormal];
    [_contentButton setTitle:_tf.text forState:UIControlStateNormal];
    
    // 2.
    bgImageOrigin = [UIImage imageNamed:@"bubble_community"];
    bgImage = [self image:bgImageOrigin stretchLeftAndRightWithContainerSize:CGSizeMake(_contentButton.width, _contentButton.height)];
    [_contentButton2 setBackgroundImage:bgImage forState:UIControlStateNormal];
    [_contentButton2 setTitle:_tf.text forState:UIControlStateNormal];
}

// 将一个
- (UIImage *)image:(UIImage *)image stretchLeftAndRightWithContainerSize:(CGSize)size {
    CGSize imageSize = image.size;
    CGSize bgSize = size;
    
    //1.第一次拉伸右边 保护左边
    UIImage *imageTemp = [image stretchableImageWithLeftCapWidth:imageSize.width *0.8 topCapHeight:imageSize.height * 0.5];
    
    //第一次拉伸的距离之后图片总宽度
    CGFloat tempWidth = (bgSize.width)/2 + imageSize.width/2;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(tempWidth, bgSize.height), NO, [UIScreen mainScreen].scale);
    [imageTemp drawInRect:CGRectMake(0, 0, tempWidth, bgSize.height)];
    //拿到拉伸过的图片
    UIImage *firstStrechImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //2.第二次拉伸左边 保护右边
    UIImage *secondStrechImage = [firstStrechImage stretchableImageWithLeftCapWidth:firstStrechImage.size.width *0.1 topCapHeight:firstStrechImage.size.height*0.5];
    
    return secondStrechImage;
}

@end
