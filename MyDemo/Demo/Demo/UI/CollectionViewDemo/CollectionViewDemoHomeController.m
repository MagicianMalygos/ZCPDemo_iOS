//
//  CollectionViewDemoHomeController.m
//  Demo
//
//  Created by apple on 16/3/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "CollectionViewDemoHomeController.h"

#pragma mark - CollectionViewDemoHomeCollection
@interface CollectionViewDemoHomeController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *infoArray;

@end

@implementation CollectionViewDemoHomeController

#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
}
#pragma mark - getter / setter
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        // 如果Layout写的有问题，则不会响应数据源方法构造cell
        _collectionView = [[UICollectionView alloc] initWithFrame:({
            CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64);
        }) collectionViewLayout:[UICollectionViewFlowLayout new]];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        
        // 注册, 用来进行重用
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        // 注册header
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableHeaderView"];
        // 注册footer
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableFooterView"];
    }
    return _collectionView;
}
- (NSArray *)infoArray {
    if (_infoArray == nil) {
        _infoArray = @[@(1), @(2), @(3), @(4), @(5)];
    }
    return _infoArray;
}

#pragma mark - UICollectionView DataSource
// 返回section数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}
// 返回每个section的item数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}
// 返回索引对应的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = RANDOM_COLOR;
    return cell;
}
// 返回Header Footer
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = ([kind isEqualToString:UICollectionElementKindSectionHeader ])? @"UICollectionReusableHeaderView": @"UICollectionReusableFooterView";
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
    view.backgroundColor = [UIColor blackColor];
    return view;
}
// 设置是否可移动 iOS9.0
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0) {
    return YES;
}
// 移动item iOS9.0
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath NS_AVAILABLE_IOS(9_0) {
}

#pragma mark - UICollectionView Delegate FlowLayout
// 每个cell的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, 100);
}
// 每个cell的margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(37.5f, 37.5f, 37.5f, 37.5f);
}
// cell的垂直边距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}
// cell的水平边距，会受margin的影响
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}
// headerView的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREENWIDTH, 50);
}
// footerView的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(SCREENWIDTH, 50);
}
#pragma mark - UICollectionView Delegate
// 点击是否可以高亮显示，是否可点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
// 高亮状态开始
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didHighlight section:%li row:%li", indexPath.section, indexPath.row);
}
// 高亮状态结束
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didUnhighlight section:%li row:%li", indexPath.section, indexPath.row);
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
// ???
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
} // called when the user taps on an already-selected item in multi-select mode
// 被选中
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelect section:%li row:%li", indexPath.section, indexPath.row);
}
// 取消选中
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didDeselect section:%li row:%li", indexPath.section, indexPath.row);
}
// cell将要显示
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0) {
    NSLog(@"willDisplay section:%li row:%li", indexPath.section, indexPath.row);
}
// SupplementaryView将要显示
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0) {
    NSLog(@"willDisplaySupplementaryView section:%li row:%li kind:%@", indexPath.section, indexPath.row, elementKind);
}
// cell结束显示
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didEndDisplaying section:%li row:%li", indexPath.section, indexPath.row);
}
// SupplementaryView结束显示
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didEndDisplayingSupplementaryView section:%li row:%li kind:%@", indexPath.section, indexPath.row, elementKind);
}

// These methods provide support for copy/paste actions on cells.
// All three should be implemented if any are.
// 长按cell是否显示cut/copy/paste菜单
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
// cell是否可以响应cut/copy/paste点击事件
- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender{
    return YES;
}
// cut/copy/paste点击响应事件
- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender {
    SuppressPerformSelectorLeakWarning(
        [self performSelector:action withObject:self];  // object可为任意OC对象
    );
    NSLog(@"action:%@ section:%li row:%li sender:%@", NSStringFromSelector(action), indexPath.section, indexPath.row, sender);
}

// support for custom transition layout
// 重新布局时调用???
- (nonnull UICollectionViewTransitionLayout *)collectionView:(UICollectionView *)collectionView transitionLayoutForOldLayout:(UICollectionViewLayout *)fromLayout newLayout:(UICollectionViewLayout *)toLayout {
    return (UICollectionViewTransitionLayout *)toLayout;
}

// Focus
// ???
- (BOOL)collectionView:(UICollectionView *)collectionView canFocusItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0) {
    return YES;
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldUpdateFocusInContext:(UICollectionViewFocusUpdateContext *)context NS_AVAILABLE_IOS(9_0) {
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didUpdateFocusInContext:(UICollectionViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator NS_AVAILABLE_IOS(9_0) {
}
- (nullable NSIndexPath *)indexPathForPreferredFocusedViewInCollectionView:(UICollectionView *)collectionView NS_AVAILABLE_IOS(9_0) {
    return nil;
}

- (NSIndexPath *)collectionView:(UICollectionView *)collectionView targetIndexPathForMoveFromItemAtIndexPath:(NSIndexPath *)originalIndexPath toProposedIndexPath:(NSIndexPath *)proposedIndexPath NS_AVAILABLE_IOS(9_0) {
    return [NSIndexPath new];
}

- (CGPoint)collectionView:(UICollectionView *)collectionView targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset NS_AVAILABLE_IOS(9_0) {
    return CGPointZero;
} // customize the content offset to be applied during transition or update animations

#pragma mark - call back
- (void)cut:(id)sender {
    NSLog(@"CallBack: Cut Sender: %@", sender);
    [self.collectionView reloadData];
}
- (void)copy:(id)sender {
    NSLog(@"CallBack: Copy Sender: %@", sender);
}
- (void)paste:(id)sender {
    NSLog(@"CallBack: Paste Sender: %@", sender);
}

@end
