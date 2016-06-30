//
//  ZCPPhotoCarouselView.m
//  Demo
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPPhotoCarouselView.h"

@interface ZCPPhotoCarouselView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIPageControl *mainPageControl;
@property (nonatomic, assign) CGFloat scrollWidth;
@property (nonatomic, assign) CGFloat scrollHeight;
@property (nonatomic, assign) UIViewContentMode imageViewContentModel;

@property (nonatomic, strong) UIPageControl *imageViewPageControl;

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) TapImageViewBlock block;

@end

@implementation ZCPPhotoCarouselView

#pragma mark - synthesize
@synthesize imageNameArray      = _imageNameArray;
@synthesize scrollInterval      = _scrollInterval;
@synthesize animationInterval   = _animationInterval;
@synthesize mainScrollView      = _mainScrollView;
@synthesize mainPageControl     = _mainPageControl;
@synthesize scrollWidth         = _scrollWidth;
@synthesize scrollHeight        = _scrollHeight;

#pragma mark - instancetype
+ (instancetype)photoCarouselViewWithFrame:(CGRect)frame {
    return [[self alloc] initWithFrame:frame];
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _scrollWidth = frame.size.width;
        _scrollHeight = frame.size.height;
        [self addSubview:self.mainScrollView];
    }
    return self;
}

#pragma mark - getter / setter
- (UIScrollView *)mainScrollView {
    if (_mainScrollView == nil) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:({
            CGRectMake(0, 0, _scrollWidth, _scrollHeight);
        })];
        _mainScrollView.contentSize = ({
            CGSizeMake(_scrollWidth, _scrollHeight);
        });
        _mainScrollView.contentOffset = CGPointMake(0, 0);
        _mainScrollView.pagingEnabled = YES;                    // 设置分页
        _mainScrollView.showsHorizontalScrollIndicator = NO;    // 隐藏水平滑动条
        _mainScrollView.showsVerticalScrollIndicator = NO;      // 隐藏垂直滑动条
        _mainScrollView.delegate = self;
    }
    return _mainScrollView;
}
- (NSArray *)imageNameArray {
    if (_imageNameArray == nil) {
        _imageNameArray = [NSMutableArray array];
    }
    return _imageNameArray;
}

// 可优化，缓存并重用UIImageView
- (void)setImageNameArray:(NSArray *)imageNameArray {
    // 更新imageNameArray
    _imageNameArray = imageNameArray;
    // 更新mainScrollView的contentSize
    self.mainScrollView.contentSize = ({
        CGSizeMake(_scrollWidth * (imageNameArray.count + 1), _scrollHeight);
    });
    
    // 遍历图片并添加
    for (int i = 0; i < imageNameArray.count + 1; i++) {
        UIImageView *tempImageView = [[UIImageView alloc] initWithFrame:({
            CGRectMake(_scrollWidth * i, 0, _scrollWidth, _scrollHeight);
        })];
        tempImageView.contentMode = _imageViewContentModel;
        tempImageView.clipsToBounds = YES;
        
        NSString *imageName = @"";
        if (i == imageNameArray.count) {
            imageName = [self.imageNameArray firstObject];
        } else {
            imageName = [self.imageNameArray objectAtIndex:i];
        }
        
        // 判断是否是合法url
        if ([self verifyURL:imageName]) {
            NSURL *url = [NSURL URLWithString:imageName];
            [tempImageView sd_setImageWithURL:url
                             placeholderImage:[UIImage imageNamed:self.placeholderImageName]];
        } else {
            UIImage *imageTemp = [UIImage imageNamed:imageName];
            [tempImageView setImage:imageTemp];
        }
        WEAK_SELF;
        [tempImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            if (weakSelf.block) {
                weakSelf.block(i % imageNameArray.count);
            }
        }]];
        tempImageView.userInteractionEnabled = YES;
        [self.mainScrollView addSubview:tempImageView];
    }
}

#pragma mark - public method
- (void)addTapEventForImageWithBlock:(TapImageViewBlock)block {
    if (_block == nil) {
        if (block != nil) {
            _block = block;
        }
    }
}

#pragma mark - private method
- (BOOL)verifyURL:(NSString *)url{
    NSString *pattern = @"((http|ftp|https)://)(([a-zA-Z0-9\\._-]+\\.[a-zA-Z]{2,6})|([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}))(:[0-9]{1,4})*(/[a-zA-Z0-9\\&%_\\./-~-]*)?";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSInteger currentPage = scrollView.contentOffset.x / _scrollWidth;
    if(currentPage == 0){
        _mainScrollView.contentOffset = CGPointMake(_scrollWidth * _imageNameArray.count, 0);
        _imageViewPageControl.currentPage = _imageNameArray.count;
        _currentPage = _imageNameArray.count;
        return;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentPage = scrollView.contentOffset.x / _scrollWidth;
    if (_currentPage + 1 == currentPage || currentPage == 1) {
        _currentPage = currentPage;
        
        if (_currentPage == _imageNameArray.count + 1) {
            _currentPage = 1;
        }
        
        if (_currentPage == _imageNameArray.count) {
            _mainScrollView.contentOffset = CGPointMake(0, 0);
        }
        
        _imageViewPageControl.currentPage = _currentPage - 1;
        return;
    }
}

@end
