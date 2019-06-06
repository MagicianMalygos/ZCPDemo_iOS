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
#import <AssetsLibrary/AssetsLibrary.h>
#import <Masonry.h>
#import <ZCPCommentView.h>
#import <ZCPWebView.h>
#import "ZCPDemoWebViewController.h"

@interface TemporaryTestHomeController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSMutableDictionary *headerDict;
@property (nonatomic, strong) IQKeyboardReturnKeyHandler *returnKeyHandler;
@property (nonatomic, strong) NSArray *directorys;
@property (nonatomic, copy) NSString *path;

@property (nonatomic, assign) NSInteger count;

@end

@implementation TemporaryTestHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Test
    [self testXXX]; // 范例
    [self testBlock];
//    [self testAutoreleasepool];
//    [self testGetImageFromView];
//    [self testIQKeyboardManagerReturn];
//    [self testSettings];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.isMovingToParentViewController) {
        // 首次进入
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.isMovingFromParentViewController) {
        // 退出
    }
}

#pragma mark - test

// 测试XXX
- (void)testXXX {
}

#pragma mark - testBlock

- (void)testBlock {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)click {
    ZCPDemoWebViewController *vc = [[ZCPDemoWebViewController alloc] init];
//    [vc loadURLString:@"https://www.baidu.com"];
//    [vc loadURLString:@"https://mp.weixin.qq.com/s/rhYKLIbXOsUJC_n6dt9UfA"];
    [vc loadURLString:[[NSBundle mainBundle] URLForResource:@"network_unavailable_cn.html" withExtension:nil].absoluteString];
    
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - testAutoreleasepool

- (void)testAutoreleasepool {
    /*
     @autoreleasepool实际上就是下面两句话，作用是其内包含的所有调用autorelease的对象在出这个作用域后都会执行一次release
     
     void * atautoreleasepoolobj = objc_autoreleasePoolPush();
     // Do something
     objc_autoreleasePoolPop(atautoreleasepoolobj);
     
     会创建一个pool，然后将nil(atautoreleasepoolobj)入栈，后面所有调用autorelease的对象都会放到这个pool中，
     objc_autoreleasePoolPop这句代码会让里面所有的对象都执行一次release
     */
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"rocket.png"];
    [path description];
    
    // 内存暴增
    // 这种情况下image的释放归main函数中的@autoreleasepool {}管，下面的while循环会使得main runloop一直无法走下一次事件循环，因此也无法执行到objc_autoreleasePoolPop(atautoreleasepoolobj)这句代码，让其中的image对象执行release
//    NSArray *list = @[@"1"];
    while (1) {
        // object 不会暴增
//        NSObject *obj = [[NSObject alloc] init];
//        [obj description];
        
        // list 会暴增
//        id arr = [NSArray array];
//        id arr = [NSMutableArray new];
//        id arr = list.mutableCopy;
//        [arr description];
        
        // view 会暴增
//        id view = [[UIView alloc] init];
//        [view description];
        
        // image 会暴增
//        UIImage *image = [UIImage imageWithContentsOfFile:path];
//        [image description];
    }
    
    // image被及时释放，不会暴增
    // 这种情况下image的释放归while循环中的autoreleasepool {}管，在一次while循环中，objc_autoreleasePoolPop(atautoreleasepoolobj)被调用，image就会执行release方法释放内存
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

@end
