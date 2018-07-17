//
//  TemporaryTestHomeController.m
//  Demo
//
//  Created by 朱超鹏 on 17/4/28.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "TemporaryTestHomeController.h"
#import <IQKeyboardManager.h>
#import <IQKeyboardReturnKeyHandler.h>

#define SCALE 1
#define S(s) ((s)*SCALE)
#define W(w) ((w)*SCALE)
#define H(h) ((h)*SCALE)

@interface TemporaryTestHomeController ()

@property (nonatomic, strong) NSMutableDictionary *headerDict;
@property (nonatomic, strong) IQKeyboardReturnKeyHandler *returnKeyHandler;
@property (nonatomic, strong) NSArray *directorys;
@property (nonatomic, copy) NSString *path;

@end

@implementation TemporaryTestHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Test
    [self testXXX]; // 范例
//    [self testSD];  // 测试给url添加HeaderField
//    [self testAutoreleasepool];
//    [self testGetImageFromView];
//    [self testIQKeyboardManagerReturn];
//    [self testSandBoxPath];
//    [self testSettings];
    [self testAnchorPoint];
}

#pragma mark - test

// 测试XXX
- (void)testXXX {
}

#pragma mark - sd test

// 测试给url添加HeaderField
- (void)testSD {
    
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
    [[SDImageCache sharedImageCache] clearMemory];
    self.headerDict = [NSMutableDictionary dictionary];
    
    NSArray *urlArr = @[@"http://avatar.csdn.net/2/A/5/1_yiya1989.jpg",
                        @"http://bpic.588ku.com/element_banner/20/16/12/50a1a3be752815245c8891004465717c.jpg",
                        @"http://bpic.588ku.com/element_banner/20/17/02/c01d4b880f4b4d408805c61c726f16fc.png"];
    
    for (int i = 0; i < urlArr.count; i++) {
        [self loadphoto:(NSString *)[urlArr objectAtIndex:i] index:i];
    }
    
    WEAK_SELF;
    [SDWebImageManager sharedManager].imageDownloader.headersFilter =  ^(NSURL *url, NSDictionary *headers) {
        NSMutableDictionary *h = [NSMutableDictionary dictionary];
        [h setDictionary:headers];
        [h setDictionary:[weakSelf.headerDict valueForKey:url.absoluteString]];
        return h;
    };
}

- (void)loadphoto:(NSString *)url index:(NSInteger)i {
    
    // post获取header
    NSDictionary *header = @{@"url": url};
    [self.headerDict setValue:header forKey:[NSURL URLWithString:url].absoluteString];
    
    // get请求
    UIImageView *imageView = [[UIImageView alloc] init];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:url]
                 placeholderImage:[UIImage imageNamed:@""]
                          options:SDWebImageAllowInvalidSSLCertificates
                         progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                         } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                         }];
    imageView.frame = CGRectMake(i * 50, 0, 50, 50);
    [self.view addSubview:imageView];
}

#pragma mark - testAutoreleasepool

- (void)testAutoreleasepool {
    // autoreleasepool主要用于创建大量临时变量的情况，例如for循环中的临时变量
    
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"rocket.png"];
    
    // 内存暴增
    while (1) {
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        [image description];
    }
    
    // image被及时释放，不会暴增
//    while (1) {
//        @autoreleasepool {
//            UIImage *image = [UIImage imageWithContentsOfFile:path];
//            [image description];
//        }
//    }
}

#pragma mark - testGetImageFromView

- (void)testGetImageFromView {
    
    NSMutableArray *viewArr = [NSMutableArray array];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        START_COUNT_TIME(start);
        int num = 0;
        for (int i = 0; i < 10; i++) {
            for (int j = 0; j < 50; j++) {
                @autoreleasepool {
                    UIView *view = [self getColorView];
                    UIImage *image = [self getImageFromView:view];
                    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                    imageView.frame = CGRectMake(i*50, j*50, 50, 50);
                    [viewArr addObject:imageView];
                    num++;
                }
            }
        }
        NSLog(@"%i", num);
        
        NSLog(@"创建花费 %lu 微妙", END_COUNT_TIME(start));
        
        dispatch_async(dispatch_get_main_queue(), ^{
            START_COUNT_TIME(start2);
            for (UIView *view in viewArr) {
                [self.view addSubview:view];
            }
            NSLog(@"添加花费 %lu 微妙", END_COUNT_TIME(start2));
        });
    });
}

- (UIView *)getColorView {
    UIView *container = [UIView new];
    container.frame = CGRectMake(0, 0, 50, 50);
    UIImageView *view1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"codeLogo"]];
    view1.frame = CGRectMake(0, 0, 25, 25);
    view1.backgroundColor = RANDOM_COLOR;
    UIImageView *view2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"codeLogo"]];
    view2.frame = CGRectMake(25, 0, 25, 25);
    view2.backgroundColor = RANDOM_COLOR;
    UIImageView *view3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"codeLogo"]];
    view3.frame = CGRectMake(0, 25, 25, 25);
    view3.backgroundColor = RANDOM_COLOR;
    UIImageView *view4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"codeLogo"]];
    view4.frame = CGRectMake(25, 25, 25, 25);
    view4.backgroundColor = RANDOM_COLOR;
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 50, 50);
    label.font = [UIFont systemFontOfSize:8.0f];
    label.text = @"拉开见识到了疯狂就俺俩是打飞机拉克丝";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    [container addSubview:view1];
    [container addSubview:view2];
    [container addSubview:view3];
    [container addSubview:view4];
//    [container addSubview:label];
    return container;
}

- (UIImage *)getImageFromView:(UIView *)view {
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - testIQKeyboardManagerReturn

- (void)testIQKeyboardManagerReturn {
    
    for (int i = 0; i < 5; i++) {
        UITextField *tf = [[UITextField alloc] init];
        tf.frame = CGRectMake(0, 50*i + 10, 100, 50);
        tf.backgroundColor = RANDOM_COLOR;
        [self.view addSubview:tf];
    }
    self.returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
}

#pragma mark - testSandBoxPath

- (void)testSandBoxPath {
    /*
        1./Users/zhuchaopeng388/Library/Developer/CoreSimulator/Devices/8D557EBD-4180-4535-93B4-F9D9CD9D008F/data/Containers/Data/Application/10CB9AFC-A114-4E5F-B760-065EDAC5D31B/Documents
        2.~/Documents
     */
    self.directorys = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    self.directorys = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, NO);

    self.directorys = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, NO); // ~/Applications
    self.directorys = NSSearchPathForDirectoriesInDomains(NSDemoApplicationDirectory, NSUserDomainMask, NO); // ~/Applications/Demos
    self.directorys = NSSearchPathForDirectoriesInDomains(NSDeveloperApplicationDirectory, NSUserDomainMask, NO); // ~/Developer/Applications
    self.directorys = NSSearchPathForDirectoriesInDomains(NSAdminApplicationDirectory, NSUserDomainMask, NO); // ~/Applications/Utilities
    self.directorys = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, NO); // ~/Library
    self.directorys = NSSearchPathForDirectoriesInDomains(NSDeveloperDirectory, NSUserDomainMask, NO); // ~/Developer
    
    self.directorys = NSSearchPathForDirectoriesInDomains(NSUserDirectory, NSUserDomainMask, NO); //
    self.directorys = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, NO); // ~/Library/Documentation
    self.directorys = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, NO); // ~/Documents
    self.directorys = NSSearchPathForDirectoriesInDomains(NSCoreServiceDirectory, NSUserDomainMask, NO); //
    self.directorys = NSSearchPathForDirectoriesInDomains(NSAutosavedInformationDirectory, NSUserDomainMask, NO); // ~/Library/Autosave Information
    self.directorys = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, NO); // ~/Desktop
    self.directorys = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, NO); // ~/Library/Caches
    self.directorys = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, NO); // ~/Library/Application Support
    self.directorys = NSSearchPathForDirectoriesInDomains(NSDownloadsDirectory, NSUserDomainMask, NO); // ~/Downloads
    self.directorys = NSSearchPathForDirectoriesInDomains(NSInputMethodsDirectory, NSUserDomainMask, NO); // ~/Library/Input Methods
    self.directorys = NSSearchPathForDirectoriesInDomains(NSMoviesDirectory, NSUserDomainMask, NO); // ~/Movies
    self.directorys = NSSearchPathForDirectoriesInDomains(NSMusicDirectory, NSUserDomainMask, NO); // ~/Music
    self.directorys = NSSearchPathForDirectoriesInDomains(NSPicturesDirectory, NSUserDomainMask, NO); // ~/Pictures
    self.directorys = NSSearchPathForDirectoriesInDomains(NSPrinterDescriptionDirectory, NSUserDomainMask, NO); //
    self.directorys = NSSearchPathForDirectoriesInDomains(NSSharedPublicDirectory, NSUserDomainMask, NO); // ~/Public
    self.directorys = NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, NO); // ~/Library/PreferencePanes
    self.directorys = NSSearchPathForDirectoriesInDomains(NSItemReplacementDirectory, NSUserDomainMask, NO); //
    self.directorys = NSSearchPathForDirectoriesInDomains(NSAllApplicationsDirectory, NSUserDomainMask, NO); // ~/Applications、~/Applications/Utilities、~/Developer/Applications、~/Applications/Demos"
    self.directorys = NSSearchPathForDirectoriesInDomains(NSAllLibrariesDirectory, NSUserDomainMask, NO); // ~/Library、~/Developer
    
    /*
     1.
     2.
     3./Users/zhuchaopeng388/Library/Developer/CoreSimulator/Devices/8D557EBD-4180-4535-93B4-F9D9CD9D008F/data/Containers/Data/Application/39284E1B-9ACA-4FA3-AC1B-5B0AB6217A72
     4./Users/zhuchaopeng388/Library/Developer/CoreSimulator/Devices/8D557EBD-4180-4535-93B4-F9D9CD9D008F/data/Containers/Data/Application/39284E1B-9ACA-4FA3-AC1B-5B0AB6217A72
     5./Users/zhuchaopeng388/Library/Developer/CoreSimulator/Devices/8D557EBD-4180-4535-93B4-F9D9CD9D008F/data/Containers/Data/Application/39284E1B-9ACA-4FA3-AC1B-5B0AB6217A72/tmp/
     6./
     */
    self.path = NSUserName();
    self.path = NSFullUserName();
    self.path = NSHomeDirectory();
    self.path = NSHomeDirectoryForUser(@"zcp");
    self.path = NSTemporaryDirectory();
    self.path = NSOpenStepRootDirectory();
    
    
    // 总结：
    // 1.document目录
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // 2.library目录：caches、preferences
    NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES);
    // 3.tmp目录
    NSTemporaryDirectory();
}

- (void)setDirectorys:(NSArray *)directorys {
    _directorys = directorys;
    NSLog(@"%@", directorys);
}

- (void)setPath:(NSString *)path {
    _path = path;
    NSLog(@"%@", self.path);
}

#pragma mark - testSettings

// 读取Settings.bundle中的设置
- (void)testSettings {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    // 如果app第一次启动，则设置默认值
    [userDefaults setObject:@"zcp" forKey:@"user_name"];
    [userDefaults setObject:@"bobo4" forKey:@"cheat_code"];
    
    
    NSString *userName = [userDefaults stringForKey:@"user_name"];
    NSString *cheatCode = [userDefaults stringForKey:@"cheat_code"];
    NSString *area = [userDefaults stringForKey:@"area"];
    NSLog(@"%@ %@ %@", userName, cheatCode, area);
}

#pragma mark - testAnchorPoint

- (void)testAnchorPoint {
    
    __block UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, 100, 100);
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 200, 0, 0);
    
    __block CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:transform];
    animation.duration = 5;
    
    [view.layer addAnimation:animation forKey:@"transform"];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        animation.fromValue = [view.layer.presentationLayer valueForKeyPath:@"transform"];
        animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-200, 0, 0)];
        [view.layer removeAllAnimations];
        [view.layer addAnimation:animation forKey:@"transform"];
    });
}

@end
