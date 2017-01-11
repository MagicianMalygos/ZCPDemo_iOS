//
//  ZCPScanQRCodeViewController.m
//  Demo
//
//  Created by apple on 16/6/6.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPScanQRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ZCPRecogniseQRCode.h"

#define Ratio           ([[UIScreen mainScreen] bounds].size.width / 320.0)
#define kValidX         (60 * Ratio)    // 有效扫描区X
#define kValidY         (120 * Ratio)   // 有效扫描区Y
#define kValidWidth     (200 * Ratio)   // 有效扫描区宽度
#define kValidHeight    (200 * Ratio)   // 有效扫描区高度
#define kScanLineHeight (20 * Ratio)    // 扫描线高度
#define kBgAlpha        0.6             // 蒙版透明度

static const char   *kScanQRCodeQueueName   = "ScanQRCodeQueue";
static NSString     *kValidAreaImageName    = @"scanBackground";
static NSString     *kScanLineImageName     = @"scanLine";

@interface ZCPScanQRCodeViewController () <AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) AVCaptureSession  *session;               // 会话
@property (nonatomic, strong) UIImageView       *validAreaImageView;    // 有效扫描区背景框
@property (nonatomic, strong) UIImageView       *scanLineImageView;     // 扫描线视图
@property (nonatomic, assign) BOOL              scanLineUpwordMove;     // 扫描线是否向上移动，标识移动方向
@property (nonatomic, strong) CADisplayLink     *link;                  // 定时器
@property (nonatomic, assign) BOOL              processing;             // 是否正在处理识别结果
@property (nonatomic, strong) UIButton          *lampButton;            // 照明灯按钮

@end

@implementation ZCPScanQRCodeViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self setup];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self startScan];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self pauseScan];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.view.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
}
- (void)dealloc {
    [self stopScan];
}

#pragma mark - setup

#pragma mark 初始化方法
- (void)setup {
    // 初始化nav bar
    [self setupNavigationBar];
    _processing = NO;
    
    // 初始化扫描线移动方向
    _scanLineUpwordMove = NO;
    
    // 初始化会话
    [self session];
    // 添加控件
    [self.view addSubview:self.validAreaImageView];
    [self.view addSubview:self.scanLineImageView];
    [self.view addSubview:self.lampButton];
    
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(LineReciprocate)];
    [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}
#pragma mark 初始化NavigationBar
- (void)setupNavigationBar {
    self.title = @"二维码/条形码";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backTo)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(openAlbum)];
}

#pragma mark - setter / setter

#pragma mark 懒加载session
- (AVCaptureSession *)session {
    if (!_session) {
        
        // 1.创建元数据的输出对象
        AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
        // 设置代理和 dispatch ********
        dispatch_queue_t dispatchQueue;
        dispatchQueue = dispatch_queue_create(kScanQRCodeQueueName, NULL);
        [output setMetadataObjectsDelegate:self queue:dispatchQueue];
        
        // 2.创建会话
        AVCaptureSession *session = [[AVCaptureSession alloc] init];
        // 实现高质量的输出和摄像，默认为AVCaptureSessionPresetHigh
        [session setSessionPreset:AVCaptureSessionPresetHigh];
        
        // 3.获取输入设备（摄像头）
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        // 4.根据输入设备创建输入对象
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:NULL];
        if (input == nil) {
            
            // 提示
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请在iPhone的“设置-隐私-相机”选项中，允许Demo访问你的相机。" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
            return nil;
        }
        
        // 5.添加输入输出到会话中
        if ([session canAddInput:input]) {
            [session addInput:input];
        }
        if ([session canAddOutput:output]) {
            [session addOutput:output];
        }
        
        // 6.设置输出对象, 需要输出什么样的数据 (二维码还是条形码等) 要先创建会话才能设置
        output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeAztecCode];
        
        // 7.创建预览图层（如果session中的输入设备为nil时，会crash）
        AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
        [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        previewLayer.frame = self.view.bounds;
        [self.view.layer insertSublayer:previewLayer atIndex:0];
        
        // 8.设置有效扫描区域
        // AVCapture输出的图片大小是横着的，而iPhone的屏幕是竖的，设置有效扫描区域需要把它旋转90°
        CGRect validRect = CGRectMake(kValidY / [UIScreen mainScreen].bounds.size.height
                                      , kValidX / [UIScreen mainScreen].bounds.size.width
                                      , kValidWidth / [UIScreen mainScreen].bounds.size.height
                                      , kValidHeight / [UIScreen mainScreen].bounds.size.width);
        output.rectOfInterest = validRect;
        // 添加矩形环形蒙版，以便于突出显示有效扫描区
        UIView *maskView = [[UIView alloc] initWithFrame:self.view.bounds];
        maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:kBgAlpha];
        [self.view addSubview:maskView];
        UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:self.view.bounds];
        [rectPath appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(kValidX, kValidY, kValidWidth, kValidHeight) cornerRadius:5] bezierPathByReversingPath]];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = rectPath.CGPath;
        maskView.layer.mask = shapeLayer;
        
        _session = session;
    }
    return _session;
}
#pragma mark 懒加载有效扫描区
- (UIImageView *)validAreaImageView {
    if (_validAreaImageView == nil) {
        _validAreaImageView = [[UIImageView alloc] initWithFrame:({
            CGRectMake(kValidX, kValidY, kValidWidth, kValidHeight);
        })];
        _validAreaImageView.image = [UIImage imageNamed:kValidAreaImageName];
    }
    return _validAreaImageView;
}
#pragma mark 懒加载扫描线
- (UIImageView *)scanLineImageView {
    if (_scanLineImageView == nil) {
        _scanLineImageView = [[UIImageView alloc] initWithFrame:({
            CGRectMake(kValidX, kValidY, kValidWidth, kScanLineHeight);
        })];
        _scanLineImageView.image = [UIImage imageNamed:kScanLineImageName];
    }
    return _scanLineImageView;
}

#pragma mark 懒加载照明灯按钮
- (UIButton *)lampButton {
    if (!_lampButton) {
        CGFloat lampWidth = 60 * Ratio;
        CGFloat lampHeight = 60 * Ratio;
        CGFloat lampX = ([[UIScreen mainScreen] bounds].size.width - lampWidth) / 2;
        CGFloat lampY = kValidY + kValidHeight + 60;
        _lampButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _lampButton.frame = CGRectMake(lampX, lampY, lampWidth, lampHeight);
        _lampButton.backgroundColor = [UIColor clearColor];
        [_lampButton setImage:[UIImage imageNamed:@"turn_off"] forState:UIControlStateNormal];
        [_lampButton addTarget:self action:@selector(touchLamp:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lampButton;
}

#pragma mark - call back

#pragma mark 线条上下往复移动
- (void)LineReciprocate {
    
    CGFloat offset = 2.0f;// 移动量
    CGFloat scanLineMinY = kValidY;
    CGFloat scanLineMaxY = kValidY + kValidHeight - kScanLineHeight;
    CGFloat scanLineCurrY = self.scanLineImageView.frame.origin.y;
    CGRect newFrame = self.scanLineImageView.frame;
    
    if (_scanLineUpwordMove) {
        if (scanLineCurrY - offset <= scanLineMinY) {
            newFrame.origin.y = scanLineMinY;
            _scanLineUpwordMove = !_scanLineUpwordMove;
        } else {
            newFrame.origin.y = scanLineCurrY - offset;
        }
    } else {
        if (scanLineCurrY + offset >= scanLineMaxY) {
            newFrame.origin.y = scanLineMaxY;
            _scanLineUpwordMove = !_scanLineUpwordMove;
        } else {
            newFrame.origin.y = scanLineCurrY + offset;
        }
    }
    _scanLineImageView.frame = newFrame;
}

#pragma mark 打开相册
- (void)openAlbum {
    
    // 系统照明灯自动关闭，更新按钮状态
    if (_lampButton.selected == YES) {
        [_lampButton setImage:[UIImage imageNamed:@"turn_off"] forState:UIControlStateNormal];
        _lampButton.selected = !_lampButton.selected;
    }
    
    // 1.判断相册是否可以打开
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        // 弹出提示，请打开支持
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"您的设备不支持打开相册。" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    // 2.创建图片选择器控制器
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark 照明灯按钮响应方法
- (void)touchLamp:(UIButton *)lampButton {
    if (lampButton.selected == YES) {
        [lampButton setImage:[UIImage imageNamed:@"turn_off"] forState:UIControlStateNormal];
    } else {
        [lampButton setImage:[UIImage imageNamed:@"turn_on"] forState:UIControlStateNormal];
    }
    lampButton.selected = !lampButton.selected;
    
    // 设置闪光灯
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType: AVMediaTypeVideo];
    if (![device hasTorch]) {
    } else {
        if (lampButton.selected) {
            // 开启闪光灯
            if(device.torchMode != AVCaptureTorchModeOn ||
               device.flashMode != AVCaptureFlashModeOn){
                [device lockForConfiguration:nil];
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                [device unlockForConfiguration];
            }
        } else {
            // 关闭闪光灯
            if(device.torchMode != AVCaptureTorchModeOff ||
               device.flashMode != AVCaptureFlashModeOff){
                [device lockForConfiguration:nil];
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
                [device unlockForConfiguration];
            }
        }
    }
}

#pragma mark Dismiss
- (void)backTo {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

#pragma mark 扫描到结果的回调方法（方法执行在子线程中）
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    // 系统照明灯自动关闭，更新按钮状态
    if (_lampButton.selected == YES) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_lampButton setImage:[UIImage imageNamed:@"turn_off"] forState:UIControlStateNormal];
            _lampButton.selected = !_lampButton.selected;
        });
    }
    
    if (metadataObjects.count > 0 && _processing == NO) {
        _processing = YES;
        [self pauseScan];
        
        // 2.取出扫描得到的数据
        AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
        [self handleQRCodeInfo:[object stringValue]];
    }
}

#pragma mark - UIImagePickerControllerDelegate

#pragma mark 选择一张图片的回调方法（iOS8之后才支持识别图片中的二维码）
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // * * 正在处理图片 * *
    _processing = YES;
    
    // 1.取出选中的图片
    UIImage *pickerImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        // 2.进行检测获取结果信息
        NSString *resultInfo = [ZCPRecogniseQRCode recogniseFromUIImage:pickerImage];
        if (resultInfo) {
            // 2.1若有检测结果，则进行处理
            [self handleQRCodeInfo:resultInfo];
        } else {
            // 2.2若无检测结果，则提示未检测到二维码
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"未扫描到有效二维码" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                // * * 结束本次扫描 * *
                _processing = NO;
            }];
            [alertController addAction:okAction];
            // 在主线程中显示alert
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:alertController animated:YES completion:nil];
            });
        }
    }];
}
#pragma mark 取消选择的代理方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        _processing = NO;
    }];
}

#pragma mark - Other Method

#pragma mark 处理二维码扫描结果信息
- (void)handleQRCodeInfo:(NSString *)info {

    // 判断二维码是否扫描出信息
    if (info) {
        if (_showQRCodeInfo) {
            self.successBlock(info);
        }
        
        NSURL *url = [NSURL URLWithString:info];
        // 判断URL是否能打开，如果能打开提示用户是否要打开链接
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"是否要打开链接：%@", info] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *openAction = [UIAlertAction actionWithTitle:@"打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                // 解决下面的警告
                // _BSMachError: (os/kern) invalid capability (20)
                // _BSMachError: (os/kern) invalid name (15)
                dispatch_after(0.2, dispatch_get_main_queue(), ^{
                    [[UIApplication sharedApplication] openURL:url];
                });
                
                [self startScan];
                _processing = NO;
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self startScan];
                _processing = NO;
            }];
            [alertController addAction:openAction];
            [alertController addAction:cancelAction];
            // 在主线程中显示alert
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:alertController animated:YES completion:nil];
            });
        } else {  // 如果打不开URL，则提示未识别信息
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"未识别到网址，扫描得到的信息为：%@", info] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self startScan];
                _processing = NO;
            }];
            [alertController addAction:cancelAction];
            // 在主线程中显示alert
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:alertController animated:YES completion:nil];
            });
        }
    }
}

#pragma mark 开始扫描
- (void)startScan {
    // 开启会话，开始扫描
    [self.session startRunning];
    // 开启定时器，移动扫描线
    _link.paused = NO;
}

#pragma mark 暂停扫描
- (void)pauseScan {
    // 结束会话，停止扫描
    [self.session stopRunning];
    // 关闭定时器
    _link.paused = YES;
}
#pragma mark 停止扫描
- (void)stopScan {
    [self pauseScan];
    _session = nil;
    if (_link != nil) {
        [_link removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [_link invalidate];
    }
    _link = nil;
}


@end
