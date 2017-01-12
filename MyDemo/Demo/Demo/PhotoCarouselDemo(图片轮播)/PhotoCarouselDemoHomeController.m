//
//  PhotoCarouselDemoHomeController.m
//  Demo
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "PhotoCarouselDemoHomeController.h"
#import "ZCPPhotoCarouselView.h"
#import "ZCPImageCircleView.h"

@interface PhotoCarouselDemoHomeController () <ZCPImageCircleViewDelegate>

@property (nonatomic, strong) ZCPImageCircleView *imageCircleView;

@end

@implementation PhotoCarouselDemoHomeController

#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *imageArray = @[@"001.jpg"
                            , @"002.jpg"
                            , @"003.jpg"
                            , @"004.jpg"
                            , @"005.jpg"
                            , @"http://pic1.nipic.com/2008-12-25/2008122510134038_2.jpg"];
    
    // 觉得还是有一些BUG，有很多需要优化的地方。
    // 我觉得可以使用3个UIImageView去实现，然后对UIImage去做缓存
    ZCPPhotoCarouselView *photoCarouselView = [ZCPPhotoCarouselView photoCarouselViewWithFrame:({
        CGRectMake(0, 0, SCREENWIDTH, 200);
    })];
    photoCarouselView.imageNameArray = imageArray;
    photoCarouselView.scrollInterval = 1.0f;
    photoCarouselView.animationInterval = 0.5f;
    photoCarouselView.placeholderImageName = @"default";
    [photoCarouselView addTapEventForImageWithBlock:^(NSInteger imageIndex) {
        NSLog(@"click: %li", imageIndex);
    }];
    
    [self.view addSubview:photoCarouselView];
    
    /*
     基本想法：
        五个图片：0 1 2 3 4
        创建+2个图片：0 1 2 3 4 0 1
        当点击滑动视图将要滑动时，如果index=0，则将0(index:0) --> 0(index:5)
        当结束滑动时：如果index=6，则将1(index:6) --> 1(index:1)
     */
    self.imageCircleView = [[ZCPImageCircleView alloc] initWithFrame:({
        CGRectMake(0, 200, SCREENWIDTH, 200);
    })];
    self.imageCircleView.imageNameArray = imageArray;
    self.imageCircleView.delegate = self;
    [self.view addSubview:self.imageCircleView];
    
    // Reload Test Button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 500, 100, 50);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
- (void)buttonClicked {
    [self.imageCircleView setImageNameArray:@[@"001.jpg", @"http://pic1.nipic.com/2008-12-25/2008122510134038_2.jpg"]];
    [self.imageCircleView reloadData];
}

#pragma mark - ZCPImageCircleViewDelegate
- (void)pageView:(ZCPImageCircleView *)imageCircleView didSelectedPageAtIndex:(NSUInteger)index {
    NSLog(@"click: %li", index);
    NSLog(@"%li", self.imageCircleView.currentPage);
}
- (void)pageView:(ZCPImageCircleView *)imageCircleView didChangeToIndex:(NSUInteger)index {
    NSLog(@"change: %li", index);
}

@end
