//
//  QiPaoDemoHomeController.m
//  Demo
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "QiPaoDemoHomeController.h"
#import "UIImage+Category.h"

@interface QiPaoDemoHomeController ()

@property (nonatomic, strong) UITextField *tf;
@property (nonatomic, strong) UIButton *reRenderButton;
@property (nonatomic, strong) UIButton *qipaoButton1;
@property (nonatomic, strong) UIButton *qipaoButton2;

@property (nonatomic, strong) UIView *nineSquareColorView;
@property (nonatomic, strong) UIImageView *colorOriginView;
@property (nonatomic, strong) UIImageView *colorZoomView;

@end

@implementation QiPaoDemoHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tf.frame               = CGRectMake(0, 20, CGRectGetWidth([[UIScreen mainScreen] bounds]) - 50, 50);
    self.reRenderButton.frame   = CGRectMake(CGRectGetWidth([[UIScreen mainScreen] bounds]) - 50, 20, 50, 50);
    self.qipaoButton1.frame     = CGRectMake(0, 100, 240, 0);
    self.qipaoButton2.frame     = CGRectMake(0, 200, 240, 0);
    
    UIImage *colorImage         = [UIImage imageFromView:self.nineSquareColorView];
    UIImage *colorZoomImage     = [colorImage resizableImageWithCapInsets:UIEdgeInsetsMake(30, 30, 30, 30) resizingMode:UIImageResizingModeStretch];
    self.colorOriginView.image  = colorImage;
    self.colorZoomView.image    = colorZoomImage;
    self.colorOriginView.frame  = CGRectMake(0, 300, colorImage.size.width, colorImage.size.height);
    self.colorZoomView.frame    = CGRectMake(100, 300, 180, 180);
    
    [self.view addSubview:self.tf];
    [self.view addSubview:self.reRenderButton];
    [self.view addSubview:self.qipaoButton1];
    [self.view addSubview:self.qipaoButton2];
    [self.view addSubview:self.colorOriginView];
    [self.view addSubview:self.colorZoomView];
}

#pragma mark - event response

// qq聊天气泡的拉伸效果
- (void)reRender {
    
    // 计算文字宽高，并设置气泡frame
    NSString *content       = _tf.text;
    CGRect rect             = [content boundingRectWithSize:CGSizeMake(200, MAXFLOAT)
                                                    options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13.0f]}
                                                    context:nil];
    CGRect frame            = CGRectMake(30, 100, rect.size.width + 30 * 2, rect.size.height + 20 * 2);
    CGRect frame2           = CGRectMake(30, 200, rect.size.width + 30 * 2, rect.size.height + 20 * 2);
    self.qipaoButton1.frame = frame;
    self.qipaoButton2.frame = frame2;
    
    // 变量
    UIImage *bgImageOrigin;
    UIImage *bgImage;
    
    // 气泡1：使用系统拉伸方法。参考：http://blog.csdn.net/chaoyuan899/article/details/19811889
    bgImageOrigin   = [UIImage imageNamed:@"bubble_mine_green"];
    bgImage         = [bgImageOrigin resizableImageWithCapInsets:UIEdgeInsetsMake(bgImageOrigin.size.height / 2 + 2, 4, bgImageOrigin.size.height / 2 - 3, 17) resizingMode:UIImageResizingModeStretch];
    [self.qipaoButton1 setBackgroundImage:bgImage forState:UIControlStateNormal];
    [self.qipaoButton1 setTitle:self.tf.text forState:UIControlStateNormal];
    
    // 气泡2：使用两端拉伸气泡方法
    bgImageOrigin   = [UIImage imageNamed:@"bubble_community"];
    bgImage         = [self image:bgImageOrigin stretchLeftAndRightWithContainerSize:CGSizeMake(self.qipaoButton1.width, self.qipaoButton1.height)];
    [self.qipaoButton2 setBackgroundImage:bgImage forState:UIControlStateNormal];
    [self.qipaoButton2 setTitle:self.tf.text forState:UIControlStateNormal];
}

#pragma mark - util method

// 拉伸两端方法
- (UIImage *)image:(UIImage *)image stretchLeftAndRightWithContainerSize:(CGSize)size {
    CGSize imageSize = image.size;
    CGSize bgSize = size;
    
    //1.第一次拉伸右边 保护左边
    UIImage *imageTemp = [image stretchableImageWithLeftCapWidth:imageSize.width *0.8 topCapHeight:imageSize.height * 0.5];
    
    //第一次拉伸的距离之后图片总宽度
    CGFloat tempWidth = (bgSize.width)/2 + imageSize.width/2;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(tempWidth, bgSize.height), NO, [UIScreen mainScreen].scale);
    [imageTemp drawInRect:CGRectMake(0, 0, tempWidth, bgSize.height)];
    // 拿到拉伸过的图片
    UIImage *firstStrechImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // 2.第二次拉伸左边 保护右边
    UIImage *secondStrechImage = [firstStrechImage stretchableImageWithLeftCapWidth:firstStrechImage.size.width *0.1 topCapHeight:firstStrechImage.size.height*0.5];
    
    return secondStrechImage;
}

#pragma mark - getter / setter

- (UITextField *)tf {
    if (!_tf) {
        _tf                                     = [[UITextField alloc] init];
        _tf.backgroundColor                     = [UIColor redColor];
    }
    return _tf;
}

- (UIButton *)reRenderButton {
    if (!_reRenderButton) {
        _reRenderButton                         = [UIButton buttonWithType:UIButtonTypeCustom];
        _reRenderButton.backgroundColor         = [UIColor greenColor];
        [_reRenderButton setTitle:@"Go" forState:UIControlStateNormal];
        [_reRenderButton addTarget:self action:@selector(reRender) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reRenderButton;
}

- (UIButton *)qipaoButton1 {
    if (!_qipaoButton1) {
        _qipaoButton1                           = [UIButton buttonWithType:UIButtonTypeCustom];
        _qipaoButton1.titleLabel.font           = [UIFont systemFontOfSize:13.0f];
        _qipaoButton1.titleLabel.numberOfLines  = 0;
        _qipaoButton1.titleEdgeInsets           = UIEdgeInsetsMake(20, 20, 20, 20);
        [_qipaoButton1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _qipaoButton1;
}

- (UIButton *)qipaoButton2 {
    if (!_qipaoButton2) {
        _qipaoButton2                           = [UIButton buttonWithType:UIButtonTypeCustom];
        _qipaoButton2.titleEdgeInsets           = UIEdgeInsetsMake(20, 20, 20, 20);
        _qipaoButton2.titleLabel.font           = [UIFont systemFontOfSize:13.0f];
        _qipaoButton2.titleLabel.numberOfLines  = 0;
        [_qipaoButton2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _qipaoButton2;
}

- (UIView *)nineSquareColorView {
    if (!_nineSquareColorView) {
        _nineSquareColorView = [[UIView alloc] init];
        _nineSquareColorView.frame = CGRectMake(0, 0, 90, 90);
        
        NSArray *colorArr = @[[UIColor magentaColor],
                              [UIColor redColor],
                              [UIColor orangeColor],
                              [UIColor yellowColor],
                              [UIColor blackColor],
                              [UIColor greenColor],
                              [UIColor cyanColor],
                              [UIColor blueColor],
                              [UIColor purpleColor]];
        
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                UIView *colorView = [[UIView alloc] init];
                colorView.frame = CGRectMake(i * 30, j * 30, 30, 30);
                colorView.backgroundColor = colorArr[i * 3 + j];
                [_nineSquareColorView addSubview:colorView];
            }
        }
    }
    return _nineSquareColorView;
}

- (UIImageView *)colorOriginView {
    if (!_colorOriginView) {
        _colorOriginView                    = [[UIImageView alloc] init];
        _colorOriginView.contentMode        = UIViewContentModeScaleToFill;
        _colorOriginView.backgroundColor    = [UIColor colorFromHexRGB:@"aabbcc"];
    }
    return _colorOriginView;
}

- (UIImageView *)colorZoomView {
    if (!_colorZoomView) {
        _colorZoomView                      = [[UIImageView alloc] init];
        _colorZoomView.contentMode          = UIViewContentModeScaleToFill;
        _colorZoomView.backgroundColor      = [UIColor colorFromHexRGB:@"aabbcc"];
    }
    return _colorZoomView;
}

@end
