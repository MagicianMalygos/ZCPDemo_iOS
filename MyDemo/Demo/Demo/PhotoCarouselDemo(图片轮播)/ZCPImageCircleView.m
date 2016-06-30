//
//  ZCPImageCircleView.m
//  Demo
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPImageCircleView.h"


#pragma mark - FlowLayout
@interface ZCPCollectionViewFlowLayout : UICollectionViewFlowLayout
@end

@implementation ZCPCollectionViewFlowLayout

- (instancetype)init {
    if (self = [super init]) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = 0;
    }
    return self;
}
- (CGSize)itemSize {
    return self.collectionView.bounds.size;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds {
    return YES;
}

@end

#pragma mark - ZCPImageCircleView
@interface ZCPImageCircleView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;     // 九宫格视图
@property (nonatomic, strong) UIPageControl *pageControl;           // pageControl
@property (nonatomic, assign) NSUInteger totalPageCount;            // 实际总页数

@end

@implementation ZCPImageCircleView

#pragma mark - instancetype
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupImageCircleView];
        [self setupDefaultValue];
    }
    return self;
}

#pragma mark - setup
// 初始化视图
- (void)setupImageCircleView {
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
}
- (void)setupDefaultValue {
    _currentPage = 0;
    self.disableCycle = self.pageCount > 1 ? NO : YES;
    self.pageControl.numberOfPages = self.pageCount;
    self.pageControl.hidden = self.pageCount > 1 ? NO : YES;
    self.pageControl.currentPage = _currentPage;
}
#pragma mark - public method
- (void)reloadData {
    
    [self setupDefaultValue];
    [self.collectionView reloadData];
    if (self.pageCount) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

#pragma mark - getter / setter
- (void)setImageNameArray:(NSArray *)imageNameArray {
    _imageNameArray = imageNameArray;
    _pageCount = _imageNameArray.count;
    [self reloadData];
}
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:({
            CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
        }) collectionViewLayout:[ZCPCollectionViewFlowLayout new]];
        
        [_collectionView registerClass:[ZCPImageCircleCollectionCell class]
            forCellWithReuseIdentifier:[ZCPImageCircleCollectionCell cellReuseIdentifier]];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollsToTop = NO;      // 锚？？
        _collectionView.bounces = NO;           // 弹簧
        _collectionView.pagingEnabled = YES;    // 分页
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        _collectionView.backgroundColor = [UIColor greenColor];
    }
    return _collectionView;
}
- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] initWithFrame:({
            CGRectMake(15, self.collectionView.height - 15, 70, 15);
        })];
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    }
    return _pageControl;
}
- (NSUInteger)totalPageCount {
    if (self.disableCycle) {
        return self.pageCount;
    } else {
        return self.pageCount? (self.pageCount + 2): 0;
    }
}

#pragma mark - UICollectionView DataSource
// 数据源方法，返回cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.totalPageCount;
}
// 数据源方法，返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCPImageCircleCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZCPImageCircleCollectionCell cellReuseIdentifier] forIndexPath:indexPath];
    // 更新imageView
    WEAK_SELF;
    [cell updateImageViewWithImageURLString:[self.imageNameArray objectAtIndex:indexPath.item % self.pageCount] imageViewClickBlock:^(UIImageView *imageView) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(pageView:didSelectedPageAtIndex:)]) {
            [weakSelf.delegate pageView:weakSelf didSelectedPageAtIndex:indexPath.item % weakSelf.pageCount];
        }
    }];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}
#pragma mark - UICollectionViewDelegate UIScrollViewDelegate
// 点击滑动视图，滑动将要开始时，调用该方法。一次有效滑动，只执行一次
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    UICollectionView *collectionView = (UICollectionView *)scrollView;
    NSIndexPath *indexPath = [collectionView indexPathForItemAtPoint:scrollView.contentOffset];
    
    if (indexPath.item == 0 && !self.disableCycle) {
        // 滑动到索引对应的cell
        [collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.pageCount inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}
// 滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
// 当滚动视图动画完成后，调用该方法，如果没有动画，那么该方法将不被调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    UICollectionView *collectionView = (UICollectionView *)scrollView;
    NSIndexPath *indexPath = [collectionView indexPathForItemAtPoint:scrollView.contentOffset];
    // 更新pageControl当前显示页
    _currentPage = indexPath.item % self.pageCount;
    self.pageControl.currentPage = self.currentPage;
    if ([self.delegate respondsToSelector:@selector(pageView:didChangeToIndex:)] && !self.disableCycle) {
        [self.delegate pageView:self didChangeToIndex:indexPath.item % self.pageCount];
    }
    if (indexPath.item + 1 == self.totalPageCount) {
        [collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

@end


#pragma mark - ZCPImageCircleCollectionCell
@interface ZCPImageCircleCollectionCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end
@implementation ZCPImageCircleCollectionCell

@synthesize imageView = _imageView;

#pragma mark - instancetype
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
    }
    return self;
}
#pragma mark - getter / setter
- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:({
            self.contentView.bounds;
        })];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        _imageView.userInteractionEnabled = YES;
        [_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onPressedImageView:)]];
    }
    return _imageView;
}

#pragma mark - public method
+ (NSString *)cellReuseIdentifier {
    return NSStringFromClass([self class]);
}
- (void)updateImageViewWithImageURLString:(NSString *)URLString imageViewClickBlock:(ZCPImageViewClickBlock)imageViewClickBlock {
    
    self.imageViewClickBlock = imageViewClickBlock;
    
    if ([self verifyURL:URLString]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:URLString] placeholderImage:[UIImage imageNamed:@"default"] completed:nil];
    } else {
        [self.imageView setImage:[UIImage imageNamed:URLString]];
    }
}

#pragma mark - callback
- (void)onPressedImageView:(UIImageView *)imageView {
    if (self.imageViewClickBlock) {
        self.imageViewClickBlock(imageView);
    }
}
#pragma mark - private method
- (BOOL)verifyURL:(NSString *)url{
    NSString *pattern = @"((http|ftp|https)://)(([a-zA-Z0-9\\._-]+\\.[a-zA-Z]{2,6})|([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}))(:[0-9]{1,4})*(/[a-zA-Z0-9\\&%_\\./-~-]*)?";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
}

@end
