//
//  TemporaryTestHomeController.m
//  Demo
//
//  Created by 朱超鹏 on 17/4/28.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "TemporaryTestHomeController.h"

#define SCALE 1
#define S(s) ((s)*SCALE)
#define W(w) ((w)*SCALE)
#define H(h) ((h)*SCALE)

@interface TemporaryTestHomeController ()

@property (nonatomic, strong) NSMutableDictionary *headerDict;

@end

@implementation TemporaryTestHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Test
    [self testXXX]; // 范例
//    [self testSD];  // 测试给url添加HeaderField
//    [self testCreateNSString];
    [self testGetImageFromView];
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

#pragma mark - testCreateNSString

- (void)testCreateNSString {
//    START_COUNT_TIME(start);
//    for (int i = 0; i < 100000; i++) {
//        @autoreleasepool {
//            NSString *string = @"ABC";
//            string = [string lowercaseString];
//            string = [string stringByAppendingString:@"xyz"];
//            NSLog(@"%@", string);
//        }
//    }
//    NSLog(@"init date formatter use %f seconds", (float)END_COUNT_TIME(start)/CLOCKS_PER_SEC);
    
    START_COUNT_TIME(start2);
    for (int i = 0; i < 100000; i++) {
        NSString *string = @"ABC";
        string = [string lowercaseString];
        string = [string stringByAppendingString:@"xyz"];
        NSLog(@"%@", string);
    }
    NSLog(@"init date formatter use %f seconds", (float)END_COUNT_TIME(start2)/CLOCKS_PER_SEC);
}

#pragma mark - testGetImageFromView

- (void)testGetImageFromView {
    
    int num = 0;
    for (int i = 0; i < 100; i++) {
        for (int j = 0; j < 50; j++) {
            UIView *view = [self getColorView];
            UIImage *image = [self getImageFromView:view];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            imageView.frame = CGRectMake(i*50, j*50, 50, 50);
            [self.view addSubview:imageView];
            num++;
        }
    }
    NSLog(@"%i", num);
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
    @autoreleasepool {
        UIGraphicsBeginImageContext(view.bounds.size);
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}

@end
