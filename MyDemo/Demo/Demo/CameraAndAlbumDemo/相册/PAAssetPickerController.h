//
//  ZYQAssetPickerController.h
//  ananzu
//
//  Created by Aim on 14-7-26.
//  Copyright (c) 2014年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

#pragma mark - PAAssetPickerController

@protocol PAAssetPickerControllerDelegate;

@interface PAAssetPickerController : UINavigationController

@property (nonatomic, weak) id <UINavigationControllerDelegate, PAAssetPickerControllerDelegate> seldelegate;

@property (nonatomic, strong) ALAssetsFilter *assetsFilter;

@property (nonatomic, copy, readonly) NSArray *indexPathsForSelectedItems;

@property (nonatomic, assign) NSInteger maximumNumberOfSelection;
@property (nonatomic, assign) NSInteger minimumNumberOfSelection;

@property (nonatomic, strong) NSPredicate *selectionFilter;

@property (nonatomic, assign) BOOL showCancelButton;

@property (nonatomic, assign) BOOL showEmptyGroups;

@property (nonatomic, assign) BOOL isFinishDismissViewController;



@end

@protocol PAAssetPickerControllerDelegate <NSObject>

-(void)assetPickerController:(PAAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets;

@optional

-(void)assetPickerControllerDidCancel:(PAAssetPickerController *)picker;

-(void)assetPickerController:(PAAssetPickerController *)picker didSelectAsset:(ALAsset*)asset;

-(void)assetPickerController:(PAAssetPickerController *)picker didDeselectAsset:(ALAsset*)asset;

-(void)assetPickerControllerDidMaximum:(PAAssetPickerController *)picker;

-(void)assetPickerControllerDidMinimum:(PAAssetPickerController *)picker;

@end

#pragma mark - ZYQAssetViewController

@interface ZYQAssetViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) ALAssetsGroup *assetsGroup;
@property (nonatomic, strong) NSMutableArray *indexPathsForSelectedItems;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic,assign) NSInteger number;     //新加的，选中的张数

@end

#pragma mark - ZYQVideoTitleView

@interface ZYQVideoTitleView : UILabel

@end

#pragma mark - ZYQTapAssetView

@protocol ZYQTapAssetViewDelegate <NSObject>

-(void)touchSelect:(BOOL)select;
-(BOOL)shouldTap;

@end

@interface ZYQTapAssetView : UIView

@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) BOOL disabled;
@property (nonatomic, weak) id<ZYQTapAssetViewDelegate> delegate;

@end

#pragma mark - ZYQAssetView

@protocol ZYQAssetViewDelegate <NSObject>

-(BOOL)shouldSelectAsset:(ALAsset*)asset;
-(void)tapSelectHandle:(BOOL)select asset:(ALAsset*)asset;

@end

@interface ZYQAssetView : UIView

- (void)bind:(ALAsset *)asset selectionFilter:(NSPredicate*)selectionFilter isSeleced:(BOOL)isSeleced;

@end

#pragma mark - ZYQAssetViewCell

@protocol ZYQAssetViewCellDelegate;

@interface ZYQAssetViewCell : UITableViewCell

@property(nonatomic,weak)id<ZYQAssetViewCellDelegate> delegate;

- (void)bind:(NSArray *)assets selectionFilter:(NSPredicate*)selectionFilter minimumInteritemSpacing:(float)minimumInteritemSpacing minimumLineSpacing:(float)minimumLineSpacing columns:(int)columns assetViewX:(float)assetViewX;

@end

@protocol ZYQAssetViewCellDelegate <NSObject>

- (BOOL)shouldSelectAsset:(ALAsset*)asset;
- (void)didSelectAsset:(ALAsset*)asset;
- (void)didDeselectAsset:(ALAsset*)asset;

@end

#pragma mark - ZYQAssetGroupViewCell

@interface ZYQAssetGroupViewCell : UITableViewCell

- (void)bind:(ALAssetsGroup *)assetsGroup;

@end

#pragma mark - ZYQAssetGroupViewController

@interface PAAssetGroupViewController : UITableViewController

@end

