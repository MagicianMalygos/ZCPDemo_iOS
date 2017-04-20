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

@property (nonatomic, strong) UIButton *scanQRCodeButton;           // 扫描二维码按钮
@property (nonatomic, strong) UIButton *generateQRCodeButton;       // 生成二维码按钮

@property (nonatomic, strong) UITextField *codeMessageTextField;    // 二维码信息输入框
@property (nonatomic, strong) UIImageView *codeImageView1;          // code1
@property (nonatomic, strong) UIImageView *codeImageView2;          // code2
@property (nonatomic, strong) UIImageView *codeImageView3;          // code3
@property (nonatomic, strong) UIImageView *codeImageView4;          // code4

@end

@implementation QRCodeDemoHomeController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat screenWidth             = [[UIScreen mainScreen] bounds].size.width;
    
    // 扫描/生成二维码按钮
    self.scanQRCodeButton.frame     = CGRectMake(0, 0, screenWidth / 2, 50);
    self.generateQRCodeButton.frame = CGRectMake(screenWidth / 2, 0, screenWidth / 2, 50);
    // 二维码信息输入框
    self.codeMessageTextField.frame = CGRectMake(0, 50, screenWidth, 50);
    // 生成的二维码
    self.codeImageView1.frame       = CGRectMake(0, 100, screenWidth / 2, screenWidth / 2);
    self.codeImageView2.frame       = CGRectMake(screenWidth / 2, 100, screenWidth / 2, screenWidth / 2);
    self.codeImageView3.frame       = CGRectMake(0, 100 + screenWidth / 2, screenWidth / 2, screenWidth / 2);
    self.codeImageView4.frame       = CGRectMake(screenWidth / 2, 100 + screenWidth / 2, screenWidth / 2, screenWidth / 2);
    
    // addsubview
    [self.view addSubview:self.scanQRCodeButton];
    [self.view addSubview:self.generateQRCodeButton];
    [self.view addSubview:self.codeMessageTextField];
    [self.view addSubview:self.codeMessageTextField];
    [self.view addSubview:self.codeImageView1];
    [self.view addSubview:self.codeImageView2];
    [self.view addSubview:self.codeImageView3];
    [self.view addSubview:self.codeImageView4];
}

#pragma mark - action handler

#pragma mark 生成二维码
- (void)generateQRCode {
    NSString *codeMessage       = self.codeMessageTextField.text;
    UIImage *image1             = [ZCPGenerateQRCode generateQRCodeWithString:codeMessage];
    UIImage *image2             = [ZCPGenerateQRCode imageBlackToTransparent:image1 withRed:255 green:0 blue:0];
    UIImage *image3             = [ZCPGenerateQRCode imageBlackToTransparentWithRandomColor:image1];
    UIImage *image4             = [ZCPGenerateQRCode imageWithQRCode:image1 logo:[UIImage imageNamed:@"codeLogo"]];
    
    self.codeImageView1.image   = image1;
    self.codeImageView2.image   = image2;
    self.codeImageView3.image   = image3;
    self.codeImageView4.image   = image4;
}

#pragma mark 点击二维码视图
- (void)clickCodeImageView:(UITapGestureRecognizer *)tap {
    if ([tap isKindOfClass:[UITapGestureRecognizer class]] && [tap.view isKindOfClass:[UIImageView class]]) {
        UIImageView *codeImageView = (UIImageView *)tap.view;
        // 识别二维码信息，传参UIImage，返回识别后的信息
        NSString *result = [ZCPRecogniseQRCode recogniseFromUIImage:codeImageView.image];
        NSLog(@"%@", result);
    }
}

#pragma mark 跳转到扫描二维码视图控制器
- (void)gotoScanQRCodeVC {
    [self.navigationController pushViewController:[ZCPScanQRCodeViewController new] animated:YES];
}

#pragma mark - getter / setter

- (UIButton *)scanQRCodeButton {
    if (!_scanQRCodeButton) {
        _scanQRCodeButton                       = [UIButton buttonWithType:UIButtonTypeCustom];
        _scanQRCodeButton.backgroundColor       = [UIColor redColor];
        [_scanQRCodeButton setTitle:@"扫描二维码" forState:UIControlStateNormal];
        [_scanQRCodeButton addTarget:self action:@selector(gotoScanQRCodeVC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scanQRCodeButton;
}

- (UIButton *)generateQRCodeButton {
    if (!_generateQRCodeButton) {
        _generateQRCodeButton                   = [UIButton buttonWithType:UIButtonTypeCustom];
        _generateQRCodeButton.backgroundColor   = [UIColor greenColor];
        [_generateQRCodeButton setTitle:@"生成二维码" forState:UIControlStateNormal];
        [_generateQRCodeButton addTarget:self action:@selector(generateQRCode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _generateQRCodeButton;
}

- (UITextField *)codeMessageTextField {
    if (!_codeMessageTextField) {
        _codeMessageTextField                   = [[UITextField alloc] init];
        _codeMessageTextField.backgroundColor   = [UIColor blueColor];
    }
    return _codeMessageTextField;
}

- (UIImageView *)codeImageView1 {
    if (!_codeImageView1) {
        _codeImageView1 = [[UIImageView alloc] init];
        _codeImageView1.userInteractionEnabled = YES;
        [_codeImageView1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCodeImageView:)]];
    }
    return _codeImageView1;
}

- (UIImageView *)codeImageView2 {
    if (!_codeImageView2) {
        _codeImageView2 = [[UIImageView alloc] init];
        _codeImageView2.userInteractionEnabled = YES;
        [_codeImageView2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCodeImageView:)]];
    }
    return _codeImageView2;
}

- (UIImageView *)codeImageView3 {
    if (!_codeImageView3) {
        _codeImageView3 = [[UIImageView alloc] init];
        _codeImageView3.userInteractionEnabled = YES;
        [_codeImageView3 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCodeImageView:)]];
    }
    return _codeImageView3;
}

- (UIImageView *)codeImageView4 {
    if (!_codeImageView4) {
        _codeImageView4 = [[UIImageView alloc] init];
        _codeImageView4.userInteractionEnabled = YES;
        [_codeImageView4 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCodeImageView:)]];
    }
    return _codeImageView4;
}

@end
