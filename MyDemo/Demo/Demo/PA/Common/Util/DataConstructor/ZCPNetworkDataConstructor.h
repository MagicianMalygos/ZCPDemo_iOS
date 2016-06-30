//
//  ZCPNetworkDataConstructor.h
//  Apartment
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import "ZCPBasicDataConstructor.h"

@protocol ZCPNetworkDataConstructorDelegate;

@interface ZCPNetworkDataConstructor : ZCPBasicDataConstructor {
    BOOL _loading;
}

#pragma mark - delegate
@property (nonatomic, weak) id<ZCPNetworkDataConstructorDelegate> delegate;
@property (nonatomic, readonly, getter = isLoading) BOOL loading;

#pragma mark - 子类覆盖方法
/**
 *  加载数据
 */
- (void)loadData;
/**
 *  开始加载数据
 */
- (void)didStartLoadData;
/**
 *  数据加载完成
 *
 *  @param dataModel 加载完成后的数据
 */
- (void)didFinishLoadData:(ZCPDataModel *)dataModel;
- (void)didFinishLoadData:(ZCPDataModel *)dataModel request:(id)request;
- (void)didFinishLoadData:(ZCPDataModel *)dataModel operation:(id)operation;
/**
 *  数据加载失败
 *
 *  @param errorModel 错误数据
 */
- (void)didFailLoadData:(ZCPDataModel *)errorModel;
- (void)didFailLoadData:(ZCPDataModel *)errorModel request:(id)request;
- (void)didFailLoadData:(ZCPDataModel *)errorModel operation:(id)operation;
/**
 *  重置数据
 */
- (void)resetData;
/**
 *  所有item个数
 *
 *  @return item总数
 */
- (NSInteger)allItemCount;
- (BOOL)hasNoMore;

@end

@protocol ZCPNetworkDataConstructorDelegate <NSObject>

@optional
- (void)dataConstructorDidStartLoadData:(id)dataConstructor;
- (void)dataConstructor:(id)dataConstructor didFinishLoad:(ZCPDataModel *)dataModel;
- (void)dataConstructorDidFailLoadData:(id)dataConstructor withError:(ZCPDataModel *)errorDataModel;

@end