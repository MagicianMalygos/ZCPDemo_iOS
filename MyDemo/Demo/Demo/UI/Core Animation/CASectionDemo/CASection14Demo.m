//
//  CASection14Demo.m
//  Demo
//
//  Created by 朱超鹏 on 2018/8/28.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "CASection14Demo.h"
#import "CALayerHelper.h"

@interface CASection14Demo () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *imagePaths;

@property (nonatomic, strong) UISegmentedControl *segment;

@end

@implementation CASection14Demo

// ----------------------------------------------------------------------
#pragma mark - demo
// ----------------------------------------------------------------------

/*
 一旦图片文件被加载就必须要进行解码，解码过程是一个相当复杂的任务，需要消耗非常长的时间。解码后的图片将同样使用相当大的内存。
 用于加载的CPU时间相对于解码来说根据图片格式而不同。对于PNG图片来说，加载会比JPEG更长，因为文件可能更大，但是解码会相对较快，而且Xcode会把PNG图片进行解码优化之后引入工程。JPEG图片更小，加载更快，但是解压的步骤要消耗更长的时间，因为JPEG解压算法比基于zip的PNG算法更加复杂。
 当加载图片的时候，iOS通常会延迟解压图片的时间，直到加载到内存之后。这就会在准备绘制图片的时候影响性能，因为需要在绘制之前进行解压（通常是消耗时间的问题所在）
 
 1.使用+imageNamed:方法会在加载图片之后立刻进行解压
 2.直接设置为图层的内容，或UIImage的image属性，但是需要在主线程中执行。
 3.imageIO，使用kCGImageSourceShouldCache
 
 */

#pragma mark 加载和潜伏
- (void)demo1 {
    // data
    NSString *path  = [[NSBundle mainBundle] pathForResource:@"Azeroth" ofType:@"jpg"];
    self.imagePaths = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        [self.imagePaths addObject:path];
    }
    
    // collection
    UICollectionViewFlowLayout *layout  = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection              = UICollectionViewScrollDirectionHorizontal;
    self.collectionView                 = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width * 4783.0/7180.0) collectionViewLayout:layout];
    self.collectionView.dataSource      = self;
    self.collectionView.delegate        = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self addSubview:self.collectionView];
    
    // segment
    self.segment = [[UISegmentedControl alloc] initWithItems:@[@"custom", @"multiThread", @"imageNamed", @"ImageIO", @"CG", @"tiledLayer"]];
    self.segment.frame = CGRectMake(0, self.width + 10, self.width, 50);
    self.segment.selectedSegmentIndex = 0;
    [self.segment addTarget:self action:@selector(segmentValueChanged) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.segment];
}

- (void)demo1_custom:(NSString *)imagePath :(UIImageView *)imageView {
    UIImage *image  = [UIImage imageWithContentsOfFile:imagePath];
    imageView.image = image;
}

- (void)demo1_MultiThread:(NSString *)imagePath :(UIImageView *)imageView {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image  = [UIImage imageWithContentsOfFile:imagePath];
        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.image = image;
        });
    });
}

- (void)demo1_imageNamed:(UIImageView *)imageView {
    imageView.image = [UIImage imageNamed:@"Azeroth.jpg"];
}

- (void)demo1_ImageIO:(NSString *)imagePath :(UIImageView *)imageView {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *imageURL = [NSURL fileURLWithPath:imagePath];
        NSDictionary *options = @{(__bridge id)kCGImageSourceShouldCache: @(YES)};
        CGImageSourceRef source = CGImageSourceCreateWithURL((__bridge CFURLRef)imageURL, NULL);
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source, 0, (__bridge CFDictionaryRef)options);
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
        CFRelease(source);
        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.image = image;
        });
    });
}

- (void)demo1_CG:(NSString *)imagePath :(UIImageView *)imageView :(CGRect)imageViewBounds {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        UIGraphicsBeginImageContextWithOptions(imageViewBounds.size, YES, 0);
        [image drawInRect:imageViewBounds];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.image = image;
        });
    });
}

#pragma mark 缓存
- (void)demo2 {
    
}

#pragma mark 文件格式
- (void)demo3 {
    
}

// ----------------------------------------------------------------------
#pragma mark - UICollectionViewDataSource
// ----------------------------------------------------------------------

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imagePaths.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    const NSInteger imageTag    = 99;
    UIImageView *imageView      = (UIImageView *)[cell viewWithTag:imageTag];
    
    if (self.segment.selectedSegmentIndex == 5) {
        [imageView removeFromSuperview];
        imageView = nil;
        
        CATiledLayer *tiledLayer        = (CATiledLayer *)[cell.contentView.layer.sublayers lastObject];
        if (![tiledLayer isKindOfClass:[CATiledLayer class]] || !tiledLayer) {
            CGFloat scale               = [UIScreen mainScreen].scale;
            tiledLayer                  = [CATiledLayer layer];
            tiledLayer.frame            = CGRectMake(10, 10, cell.contentView.width - 20, cell.contentView.height - 20);
            tiledLayer.contentsScale    = scale;
            tiledLayer.tileSize         = CGSizeMake(tiledLayer.width, tiledLayer.height);
            tiledLayer.delegate         = [CALayerHelper sharedInstance];
            [cell.contentView.layer addSublayer:tiledLayer];
        }
        tiledLayer.contents             = nil;
        tiledLayer.caDemoTag            = @"section14_demo1_tileLayer";
        [tiledLayer setNeedsDisplay];
        return cell;
    }
    
    if (!imageView) {
        imageView                   = [[UIImageView alloc] init];
        imageView.frame             = CGRectMake(10, 10, cell.contentView.width - 20, cell.contentView.height - 20);
        imageView.tag               = imageTag;
        imageView.backgroundColor   = [UIColor lightGrayColor];
        imageView.contentMode       = UIViewContentModeScaleAspectFill;
        [cell.contentView addSubview:imageView];
    }
    
    imageView.image = nil;
    
    // set image
    NSString *imagePath = self.imagePaths[indexPath.row];
    switch (self.segment.selectedSegmentIndex) {
        case 0:
            [self demo1_custom:imagePath :imageView];
            break;
        case 1:
            [self demo1_MultiThread:imagePath :imageView];
            break;
        case 2:
            [self demo1_imageNamed:imageView];
            break;
        case 3:
            [self demo1_ImageIO:imagePath :imageView];
            break;
        case 4:
            [self demo1_CG:imagePath :imageView :imageView.bounds];
            break;
        default:
            break;
    }
    return cell;
}

// 每个cell的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.width, self.collectionView.height);
}

// ----------------------------------------------------------------------
#pragma mark - event response
// ----------------------------------------------------------------------
- (void)segmentValueChanged {
    [self.collectionView reloadData];
}

@end
