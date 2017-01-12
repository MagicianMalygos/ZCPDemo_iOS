//
//  CameraAndAlbumDemoHomeController.m
//  CameraAndAlbumDemo
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "CameraAndAlbumDemoHomeController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "PAAssetPickerController.h"

// 获取设备功能
static BOOL photoLibraryAvailable;
static BOOL cameraAvailable;

@interface CameraAndAlbumDemoHomeController () <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIButton *headButton1;
@property (nonatomic, strong) UIButton *headButton2;
@property (nonatomic, strong) UIActionSheet *takePhotoActionSheet;
@property (nonatomic, strong) UIAlertController *alertController;
@property (nonatomic, strong) UIImagePickerController *imagePicker;

@end

@implementation CameraAndAlbumDemoHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取设备功能
    photoLibraryAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    cameraAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    
    // 头像1
    self.headButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.headButton1.frame = CGRectMake(self.view.center.x - 50, 100, 100, 100);
    self.headButton1.backgroundColor = [UIColor magentaColor];
    self.headButton1.layer.masksToBounds = YES;
    self.headButton1.layer.cornerRadius = self.headButton1.layer.bounds.size.height * 0.5;
    [self.headButton1 addTarget:self action:@selector(buttonClicked1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.headButton1];
    
    // 头像2
    self.headButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.headButton2.frame = CGRectMake(self.view.center.x - 50, 250, 100, 100);
    self.headButton2.backgroundColor = [UIColor magentaColor];
    self.headButton2.layer.masksToBounds = YES;
    self.headButton2.layer.cornerRadius = self.headButton2.layer.bounds.size.height * 0.5;
    [self.headButton2 addTarget:self action:@selector(buttonClicked2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.headButton2];
}

#pragma mark - Button Click
- (void)buttonClicked1 {
    
    // UIActionSheet (>iOS 8.3 is deprecated)
    self.takePhotoActionSheet = [[UIActionSheet alloc] initWithTitle:@"UIActionSheet"
                                                                      delegate:self
                                                             cancelButtonTitle:@"取消"
                                                        destructiveButtonTitle:@"红色警示按钮"
                                                             otherButtonTitles:@"拍照", @"从手机中选择", nil];
    [self.takePhotoActionSheet showInView:self.view];
}
- (void)buttonClicked2 {
    // UIAlertController (iOS8.0)
    self.alertController = [UIAlertController alertControllerWithTitle:@"UIAlertController"
                                                               message:@"使用了UIAlertController"
                                                        preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
    UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:@"警告" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {}];
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        PAAssetPickerController *picker = [[PAAssetPickerController alloc] init];
        [self presentViewController:picker animated:YES completion:nil];
    }];
    UIAlertAction *openPhotoLibraryAction = [UIAlertAction actionWithTitle:@"从手机中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    [self.alertController addAction:cancelAction];
    [self.alertController addAction:destructiveAction];
    [self.alertController addAction:takePhotoAction];
    [self.alertController addAction:openPhotoLibraryAction];
    
    [self presentViewController:self.alertController animated:YES completion:nil];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0: {
            NSLog(@"红色按钮.");
            break;
        }
        case 1: {
            if (cameraAvailable) {
                // UIImagePickerController
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.allowsEditing = YES;
                imagePicker.delegate = self;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
                imagePicker.navigationBar.barTintColor = [UIColor lightGrayColor];
                imagePicker.navigationBar.tintColor = [UIColor whiteColor];
                
                /*
                 [self.navigationController pushViewController:imagePicker animated:YES];
                 使用push跳转会crash，是因为UIImagePickerController继承自UINavigationController
                 而当Nav去push到一个Nav时就会崩溃：
                 reason: 'Pushing a navigation controller is not supported'
                 */
                [self presentViewController:imagePicker animated:YES completion:nil];
            } else {
                NSLog(@"相机不可用");
            }
            break;
        }
        case 2: {
            // iOS10之后打开相册需要在info.plist设置访问权限的通知信息。
            if (photoLibraryAvailable) {
                // UIImagePickerController
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.allowsEditing = YES;
                imagePicker.delegate = self;
                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
                imagePicker.navigationBar.barTintColor = [UIColor lightGrayColor];
                imagePicker.navigationBar.tintColor = [UIColor whiteColor];
                
                [self presentViewController:imagePicker animated:YES completion:nil];
            } else {
                NSLog(@"相册不可用");
            }
            break;
        }
        case 3: {
            NSLog(@"取消.");
            break;
        }
        default:
            break;
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSLog(@"%@", info);
//    NSString *cropRect = [info valueForKey:UIImagePickerControllerCropRect];
//    NSString *mediaType = [info valueForKey:UIImagePickerControllerMediaType];
//    UIImage *editedImage = [info valueForKey:UIImagePickerControllerEditedImage];
    UIImage *originalImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self.headButton1 setBackgroundImage:originalImage forState:UIControlStateNormal];
        [self.headButton1 setBackgroundImage:originalImage forState:UIControlStateHighlighted];
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Picker Cancel");
    }];
}

@end
