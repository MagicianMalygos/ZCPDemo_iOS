//
//  QRCodeDemoHomeController.m
//  Demo
//
//  Created by apple on 16/6/12.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "QRCodeDemoHomeController.h"
#import "ZCPScanQRCodeViewController.h"
#import "ZCPGenerateQRCode.h"
#import "ZCPRecogniseQRCode.h"

@interface QRCodeDemoHomeController ()

@property (nonatomic, strong) UITextField *tf;
@property (nonatomic, strong) UIImageView *iv1;
@property (nonatomic, strong) UIImageView *iv2;
@property (nonatomic, strong) UIImageView *iv3;

@end

@implementation QRCodeDemoHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    
    // 扫描二维码
    UIButton *scanQRCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    scanQRCodeButton.frame = CGRectMake(0, 0, screenWidth / 2, 50);
    [scanQRCodeButton setTitle:@"扫描二维码" forState:UIControlStateNormal];
    scanQRCodeButton.backgroundColor = [UIColor redColor];
    [scanQRCodeButton addTarget:self action:@selector(gotoScanQRCodeVC) forControlEvents:UIControlEventTouchUpInside];
    
    // 生成二维码
    UIButton *generateQRCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    generateQRCodeButton.frame = CGRectMake(screenWidth / 2, 0, screenWidth / 2, 50);
    [generateQRCodeButton setTitle:@"生成二维码" forState:UIControlStateNormal];
    generateQRCodeButton.backgroundColor = [UIColor greenColor];
    [generateQRCodeButton addTarget:self action:@selector(generateQRCode) forControlEvents:UIControlEventTouchUpInside];
    
    UITextField *tf = [[UITextField alloc] initWithFrame:({
        CGRectMake(0, 50, screenWidth, 50);
    })];
    tf.backgroundColor = [UIColor blueColor];
    _tf = tf;
    
    UIImageView *iv1 = [[UIImageView alloc] initWithFrame:({
        CGRectMake(0, 100, screenWidth / 2, screenWidth / 2);
    })];
    iv1.backgroundColor = [UIColor yellowColor];
    _iv1 = iv1;
    
    UIImageView *iv2 = [[UIImageView alloc] initWithFrame:({
        CGRectMake(screenWidth / 2, 100, screenWidth / 2, screenWidth / 2);
    })];
    iv2.backgroundColor = [UIColor magentaColor];
    _iv2 = iv2;
    
    UIImageView *iv3 = [[UIImageView alloc] initWithFrame:({
        CGRectMake(0, 100 + screenWidth / 2, screenWidth / 2, screenWidth / 2);
    })];
    iv3.backgroundColor = [UIColor magentaColor];
    _iv3 = iv3;
    iv3.userInteractionEnabled = YES;
    WEAK_SELF;
    [iv3 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        STRONG_SELF;
        UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *scanAction = [UIAlertAction actionWithTitle:@"扫描图中二维码" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            // 将获取图片中的二维码信息封装成一个单独的功能，传参UIImage，返回信息
            if ([sender isKindOfClass:[UITapGestureRecognizer class]] && [((UITapGestureRecognizer *)sender).view isKindOfClass:[UIImageView class]]) {
                UIImageView *iv = (UIImageView *)((UITapGestureRecognizer *)sender).view;
                NSString *result = [ZCPRecogniseQRCode recogniseFromUIImage:iv.image];
                NSLog(@"%@", result);
            }
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        [alertControl addAction:cancelAction];
        [alertControl addAction:scanAction];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alertControl animated:YES completion:nil];
        });
    }]];
    
    [self.view addSubview:scanQRCodeButton];
    [self.view addSubview:generateQRCodeButton];
    [self.view addSubview:_tf];
    [self.view addSubview:_iv1];
    [self.view addSubview:_iv2];
    [self.view addSubview:_iv3];
}

- (void)gotoScanQRCodeVC {
    [self.navigationController pushViewController:[ZCPScanQRCodeViewController new] animated:YES];
}
- (void)generateQRCode {
    NSString *info = _tf.text;
    UIImage *image = [ZCPGenerateQRCode generateQRCodeWithString:info];
    UIImage *image2 = [ZCPGenerateQRCode imageBlackToTransparent:image withRed:100 green:24 blue:0];
    _iv1.image = image;
    _iv2.image = image2;
    _iv3.image = image2;
    [ZCPGenerateQRCode addShadow:[UIColor greenColor] forImageView:_iv3];
}


@end
