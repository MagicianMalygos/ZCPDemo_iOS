//
//  CASection14Demo.m
//  Demo
//
//  Created by 朱超鹏 on 2018/8/28.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "CASection14Demo.h"
#import "CALayerHelper.h"
#import <AssetsLibrary/AssetsLibrary.h>

#define IMAGETAG  99

@interface CASection14Demo () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *imagePaths;
@property (nonatomic, strong) UISegmentedControl *segment;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSArray *imageNames;

@property (nonatomic, strong) NSCache *imageCache;
@property (nonatomic, assign) NSInteger currDemoTag;

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
 3.imageIO框架，使用kCGImageSourceShouldCache设置
 4.立即绘制到CGContext中
 
 */

#pragma mark 加载和潜伏
- (void)demo1 {
    self.currDemoTag = 1;
    
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

#pragma mark <help method>

/// 使用imageWithContentsOfFile方法获取图片
- (void)demo1_custom:(NSString *)imagePath :(UIImageView *)imageView {
    UIImage *image  = [UIImage imageWithContentsOfFile:imagePath];
    imageView.image = image;
}

/// 在子线程使用imageWithContentsOfFile方法获取图片
- (void)demo1_MultiThread:(NSString *)imagePath :(UIImageView *)imageView {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image  = [UIImage imageWithContentsOfFile:imagePath];
        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.image = image;
        });
    });
}

/// 使用imageNamed方法获取图片
- (void)demo1_imageNamed:(UIImageView *)imageView {
    UIImage *image = [UIImage imageNamed:@"Azeroth.jpg"];
    imageView.image = image;
}

/// 使用ImageIO框架处理图片提前解压
- (void)demo1_ImageIO:(NSString *)imagePath :(UIImageView *)imageView {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 通过ImageIO框架获取图片并使其解压
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

/// 使用UIKit中的绘制方法使图片提前解压
- (void)demo1_CG:(NSString *)imagePath :(UIImageView *)imageView {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        
        // 拿到image后进行绘制使图片解压
        UIGraphicsBeginImageContextWithOptions(image.size, YES, 1);
        [image drawAtPoint:CGPointZero];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.image = image;
        });
    });
}

#pragma mark 缓存
- (void)demo2 {
    self.currDemoTag = 2;
    
    /*
     图片加载到内存中的大小怎么计算：
     如果是位图，则位图多大则加载到内存中所占用的大小就是多大。
     如果是非位图的图片比如jpg/png,则需要解码成位图，可以参考iOS图片加载速度极限优化,解码出来的位图多大也就是意味着该jpg/png占用内存多大。位图的大小计算公式：
     图片width x heigth x 4（ARGB）
     */
    
    // imageNamed方法：它在内存中自动缓存了解压后的图片，即使你自己没有保留对它的任何引用
    // 使用NSCache
    
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
}

- (UIImage *)loadImageAtIndex:(NSUInteger)index :(CGRect)imageViewBounds {
    if (!self.imageCache) {
        self.imageCache = [[NSCache alloc] init];
    }
    UIImage *image = [self.imageCache objectForKey:@(index)];
    if (image) {
        return [image isKindOfClass:[NSNull class]] ? nil: image;
    }
    [self.imageCache setObject:[NSNull null] forKey:@(index)];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *imagePath = self.imagePaths[index];
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];

        // 此处如果图片太大，会导致设置图片后不显示
        /*
         UIGraphicsBeginImageContextWithOptions方法第3个参数为scale，设置为0表示使用设备的scale
         它会影响其后生成的image图片的scale
         所以如果在iPhone X上设置该参数为0，原图是100x100的1倍图（像素为100 x 100），生成的图片会变成100x100的3倍图（100*3 x 100*3）
         */
        UIGraphicsBeginImageContextWithOptions(image.size, YES, 1);
        [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.imageCache setObject:image forKey:@(index)];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
            UIImageView *imageView = [cell.contentView viewWithTag:IMAGETAG];
            imageView.image = image;
        });
    });
    
    return nil;
}

#pragma mark 文件格式
- (void)demo3 {
    self.currDemoTag = 3;
    
    // setup tableview
    UITableView *tableview  = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableview.frame         = CGRectMake(0, 0, self.width, 200);
    tableview.dataSource    = self;
    tableview.delegate      = self;
    self.tableView          = tableview;
    [self addSubview:tableview];
    
    // setup segment
    self.segment        = [[UISegmentedControl alloc] initWithItems:@[@"image1", @"image2"]];
    self.segment.frame = CGRectMake(0, self.tableView.bottom + 10, self.width, 50);
    self.segment.selectedSegmentIndex = 0;
    [self.segment addTarget:self action:@selector(segmentValueChanged) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.segment];
    
    // setup imageview
    self.imageView          = [[UIImageView alloc] init];
    self.imageView.frame    = CGRectMake((self.width - 160) /2, self.segment.bottom + 10, 160, 100);
    self.imageView.image    = [UIImage imageNamed:@"image1 1920x1200"];
    [self addSubview:self.imageView];
    
    // setup data
    self.imageNames = @[@"1920x1200", @"960x600", @"480x300", @"240x150", @"120x75", @"40x25", @"8x5"];
}

- (void)loadImageAtIndex:(NSUInteger)index {
    NSString *headName = (self.segment.selectedSegmentIndex == 0)?@"image1":@"image2";
    NSString *imageName = [NSString stringWithFormat:@"%@ %@", headName, self.imageNames[index]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *pngPath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
        NSString *jpgPath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"];
        
        // load
        CFTimeInterval pngTime = [self loadImageForOneSec:pngPath] * 1000;
        CFTimeInterval jpgTime = [self loadImageForOneSec:jpgPath] * 1000;
        
        // upadte UI on main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            // find table cell and update
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            cell.textLabel.text = imageName;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"PNG: %.2fms JPG: %.2fms", pngTime, jpgTime];
        });
    });
}

- (CFTimeInterval)loadImageForOneSec:(NSString *)path {
    UIGraphicsBeginImageContext(CGSizeMake(1, 1));
    // start timing
    NSInteger imagesLoaded = 0;
    CFTimeInterval endTime = 0;
    CFTimeInterval startTime = CFAbsoluteTimeGetCurrent();

    while (endTime - startTime < 1) {
        // load image
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        [image drawAtPoint:CGPointZero];
        imagesLoaded++;
        endTime = CFAbsoluteTimeGetCurrent();
    }
    UIGraphicsEndImageContext();
    
    CFTimeInterval averageTime = (endTime - startTime) / imagesLoaded;
    return averageTime;
}

// ----------------------------------------------------------------------
#pragma mark - UICollectionViewDataSource
// ----------------------------------------------------------------------

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imagePaths.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *imageView      = (UIImageView *)[cell viewWithTag:IMAGETAG];
    
    // demo1
    if (self.currDemoTag == 1) {
        // 使用tiledLayer
        if (self.segment.selectedSegmentIndex == 5) {
            [imageView removeFromSuperview];
            imageView = nil;
            
            // tiledLayer会进行异步绘制
            CATiledLayer *tiledLayer        = (CATiledLayer *)[cell.contentView.layer.sublayers lastObject];
            if (![tiledLayer isKindOfClass:[CATiledLayer class]] || !tiledLayer) {
                CGFloat scale               = [UIScreen mainScreen].scale;
                tiledLayer                  = [CATiledLayer layer];
                tiledLayer.frame            = CGRectMake(10, 10, cell.contentView.width - 20, cell.contentView.height - 20);
                tiledLayer.contentsScale    = scale;
                tiledLayer.tileSize         = CGSizeMake(1024, 1024);
                tiledLayer.delegate         = [CALayerHelper sharedInstance];
                [cell.contentView.layer addSublayer:tiledLayer];
            }
            tiledLayer.contents             = nil;
            tiledLayer.caDemoTag            = @"section14_demo1_tileLayer";
            [tiledLayer setNeedsDisplay];
            return cell;
        }
        
        // 使用UIImageView
        if (!imageView) {
            imageView                   = [[UIImageView alloc] init];
            imageView.frame             = CGRectMake(10, 10, cell.contentView.width - 20, cell.contentView.height - 20);
            imageView.tag               = IMAGETAG;
            imageView.backgroundColor   = [UIColor lightGrayColor];
            imageView.contentMode       = UIViewContentModeScaleToFill;
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
                [self demo1_CG:imagePath :imageView];
                break;
            default:
                break;
        }
    } else if (self.currDemoTag == 2) {
        // demo2
        if (!imageView) {
            imageView                   = [[UIImageView alloc] init];
            imageView.frame             = CGRectMake(10, 10, cell.contentView.width - 20, cell.contentView.height - 20);
            imageView.tag               = IMAGETAG;
            imageView.backgroundColor   = [UIColor lightGrayColor];
            imageView.contentMode       = UIViewContentModeScaleToFill;
            [cell.contentView addSubview:imageView];
        }
        imageView.image = [self loadImageAtIndex:indexPath.row :imageView.bounds];
        if (indexPath.item < self.imagePaths.count - 1) {
            [self loadImageAtIndex:indexPath.row + 1 :imageView.bounds];
        }
        if (indexPath.row > 0) {
            [self loadImageAtIndex:indexPath.row - 1 :imageView.bounds];
        }
    }
    
    return cell;
}

// 每个cell的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.width, self.collectionView.height);
}

// ----------------------------------------------------------------------
#pragma mark - UITableViewDataSource and UITableViewDelegate
// ----------------------------------------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imageNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    // set cell
    NSString *imageName         = self.imageNames[indexPath.row];
    NSString *headName          = (self.segment.selectedSegmentIndex == 0)?@"image1":@"image2";
    cell.textLabel.text         = [NSString stringWithFormat:@"%@ %@", headName, imageName];
    cell.detailTextLabel.text   = @"Loading...";
    cell.textLabel.font         = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.font   = [UIFont systemFontOfSize:12];
    // load image
    [self loadImageAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 26;
}

// ----------------------------------------------------------------------
#pragma mark - event response
// ----------------------------------------------------------------------
- (void)segmentValueChanged {
    if (self.currDemoTag == 1) {
        [self.collectionView reloadData];
    } else if (self.currDemoTag == 3) {
        [self.tableView reloadData];
        
        if (self.segment.selectedSegmentIndex == 0) {
            self.imageView.image = [UIImage imageNamed:@"image1 1920x1200"];
        } else {
            self.imageView.image = [UIImage imageNamed:@"image2 1920x1200"];
        }
    }
}

@end
