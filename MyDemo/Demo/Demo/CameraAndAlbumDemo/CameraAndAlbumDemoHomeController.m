//
//  CameraAndAlbumDemoHomeController.m
//  CameraAndAlbumDemo
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "CameraAndAlbumDemoHomeController.h"
#import "PAAssetPickerController.h"

#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>

@interface CameraAndAlbumDemoHomeController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

/// 头像
@property (nonatomic, strong) UIButton *headButton;
/// 图片选择器
@property (nonatomic, strong) UIImagePickerController *imagePicker;

@end

@implementation CameraAndAlbumDemoHomeController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // 头像
    [self.headButton addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.headButton];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _headButton.frame               = CGRectMake(self.view.center.x - 50, 100, 100, 100);
    _headButton.layer.cornerRadius  = self.headButton.height / 2;
}

#pragma mark - evnet response

- (void)clickButton {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        // 判断设备是否支持相机
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            DebugLog(@"设备不支持打开相机");
            return;
        }
        
        // 请求相机访问权限
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                UIImagePickerController *imagePicker    = [[UIImagePickerController alloc] init];
                imagePicker.allowsEditing               = YES;
                imagePicker.delegate                    = self;
                imagePicker.sourceType                  = UIImagePickerControllerSourceTypeCamera;
                imagePicker.mediaTypes                  = @[(NSString *)kUTTypeImage];
                imagePicker.navigationBar.barTintColor  = [UIColor lightGrayColor];
                imagePicker.navigationBar.tintColor     = [UIColor whiteColor];
                [self presentViewController:imagePicker animated:YES completion:nil];
                
                PAAssetPickerController *picker = [[PAAssetPickerController alloc] init];
                [self presentViewController:picker animated:YES completion:nil];
            } else {
                DebugLog(@"无相机访问权限");
            }
        }];
    }];
    
    UIAlertAction *openPhotoLibraryAction = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        // 判断设备是否支持相机
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            DebugLog(@"设备不支持打开相册");
            return;
        }
        
        // 请求相册访问权限
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                UIImagePickerController *imagePicker    = [[UIImagePickerController alloc] init];
                imagePicker.allowsEditing               = YES;
                imagePicker.delegate                    = self;
                imagePicker.sourceType                  = UIImagePickerControllerSourceTypePhotoLibrary;
                imagePicker.mediaTypes                  = @[(NSString *)kUTTypeImage];
                imagePicker.navigationBar.barTintColor  = [UIColor lightGrayColor];
                imagePicker.navigationBar.tintColor     = [UIColor whiteColor];
                
                [self presentViewController:imagePicker animated:YES completion:nil];
            } else {
                DebugLog(@"无相册访问权限");
            }
        }];
    }];
    [alert addAction:cancelAction];
    [alert addAction:takePhotoAction];
    [alert addAction:openPhotoLibraryAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

// 选定了图片后的回调方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    DebugLog(@"%@", info);
//    NSString *cropRect = [info valueForKey:UIImagePickerControllerCropRect];
//    NSString *mediaType = [info valueForKey:UIImagePickerControllerMediaType];
//    UIImage *editedImage = [info valueForKey:UIImagePickerControllerEditedImage];
    UIImage *originalImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self.headButton setBackgroundImage:originalImage forState:UIControlStateNormal];
        [self.headButton setBackgroundImage:originalImage forState:UIControlStateHighlighted];
    }];
}

// 取消选择图片的回调方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        DebugLog(@"Picker Cancel");
    }];
}

#pragma mark - getters and setters

- (UIButton *)headButton {
    if (!_headButton) {
        _headButton                     = [UIButton buttonWithType:UIButtonTypeCustom];
        _headButton.backgroundColor     = [UIColor colorFromHexRGB:@"c0c0c0"];
        _headButton.layer.masksToBounds = YES;
    }
    return _headButton;
}

@end
