//
//  TemporaryUITestHomeController.m
//  Demo
//
//  Created by 朱超鹏 on 17/4/28.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "TemporaryUITestHomeController.h"

#define SCALE 1
#define S(s) ((s)*SCALE)
#define W(w) ((w)*SCALE)
#define H(h) ((h)*SCALE)

@interface TemporaryUITestHomeController ()

@property (nonatomic, strong) NSMutableDictionary *headerDict;

@end

@implementation TemporaryUITestHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Test
    [self testXXX]; // 范例
    [self testSD];  // 测试给url添加HeaderField
    [self viewChangeToImageTest];
}

#pragma mark - test

// 测试XXX
- (void)testXXX {
}

#pragma mark - sd test

// 测试给url添加HeaderField
- (void)testSD {
    
    [[SDImageCache sharedImageCache] clearDisk];
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
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageAllowInvalidSSLCertificates progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    
    imageView.frame = CGRectMake(i * 50, 0, 50, 50);
    [self.view addSubview:imageView];
}

#pragma mark - view change to image

- (void)viewChangeToImageTest {
    
    // Test 1
    
    // 9.73 KiB
    UIView *container1 = [self getTestContainer];
    // 240 Bytes
    container1.frame = CGRectMake(0, 200, S(100), S(60));
    // 5.33 KiB
    UIView *container2 = [self getTestContainer];
    // 240 Bytes
    container2.frame = CGRectMake(100, 200, S(100), S(60));
    // 5.33 Bytes
    UIView *container3 = [self getTestContainer];
    // 240 Bytes
    container3.frame = CGRectMake(200, 200, S(100), S(60));
    
    // 1.24 MiB
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[self getImageFromView:container1]];
    imageView1.frame = CGRectMake(0, 260, S(50), S(30));
    // 170.41 KiB
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[self getImageFromView:container2]];
    imageView2.frame = CGRectMake(100, 260, S(50), S(30));
    // 194.41 KiB
    UIImageView *imageView3 = [[UIImageView alloc] initWithImage:[self getImageFromView:container3]];
    imageView3.frame = CGRectMake(200, 260, S(50), S(30));
    
    [self.view addSubview:container1];  // 128 Bytes
    [self.view addSubview:container2];  // 128 Bytes
    [self.view addSubview:container3];  // 128 Bytes
    [self.view addSubview:imageView1];  // 384 Bytes
    [self.view addSubview:imageView2];  // 384 Bytes
    [self.view addSubview:imageView3];  // 512 Bytes
    
    
    // Test 2
    for (int col = 0; col < 300; col+=10) {
        for (int row = 0; row < 300; row+=10) {
            UIView *view = [self getTestContainer];
            view.frame = CGRectMake(0 + row, 60 + col, S(100), S(60));
            [self.view addSubview:view];
        }
    }
    
    //    for (int col = 0; col < 300; col+=10) {
    //        for (int row = 0; row < 300; row+=10) {
    //            UIView *view = [self getTestContainer];
    //            UIImageView *imageView = [[UIImageView alloc] initWithImage:[self getImageFromView:view]];
    //            imageView.frame = CGRectMake(0 + row, 60 + col, S(50), S(30));
    //            [self.firstVC.view addSubview:imageView];
    //        }
    //    }
}

- (UIView *)getTestContainer {
    UIView *container = [[UIView alloc] init];
    container.frame = CGRectMake(0, 0, S(100), S(60));
    container.layer.masksToBounds = YES;
    container.layer.cornerRadius = S(container.height / 2);
    container.backgroundColor = [UIColor whiteColor];
    container.layer.borderWidth = 0.5;
    container.layer.borderColor = [UIColor redColor].CGColor;
    
    UILabel *title = [[UILabel alloc] init];
    title.frame = CGRectMake(0, S(5), S(100), S(30));
    title.text = @"闸北";
    title.font = [UIFont boldSystemFontOfSize:S(28.0f)];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor blackColor];
    
    UILabel *number = [[UILabel alloc] init];
    number.frame = CGRectMake(S(50), S(35), S(50), S(20));
    number.font = [UIFont systemFontOfSize:S(10.0)];
    number.textColor = [UIColor redColor];
    number.text = @"49";
    
    UIView *color = [[UIView alloc] init];
    color.frame = CGRectMake(S(30), S(35), S(20), S(20));
    color.backgroundColor = [UIColor redColor];
    color.layer.masksToBounds = YES;
    color.layer.cornerRadius = S(color.height / 2);
    
    [container addSubview:title];
    [container addSubview:number];
    [container addSubview:color];
    
    return container;
}
- (UIImage *)getImageFromView:(UIView *)view {
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
