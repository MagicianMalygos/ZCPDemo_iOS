//
//  LCVODDownloadManager.h
//  LECPlayerSDK
//
//  Created by 侯迪 on 10/26/15.
//  Copyright © 2015 letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LECVODDownloadItem.h"
#import "LCPlayerOption.h"

@class LCVODDownloadManager;

typedef NS_ENUM(int, LCVODDownloadManagerDefaultCodeSelectType) {
    LCVODDownloadManagerDefaultCodeSelectTypeHighest = 0,
    LCVODDownloadManagerDefaultCodeSelectTypeLowest = 1,
//    LCVODDownloadManagerDefaultCodeSelectTypeMiddle = 2
};

@protocol LCVODDownloadManagerDelegate <NSObject>
//开始下载事件
- (void) vodDownloadManager:(LCVODDownloadManager *) downloadManager didBeginDownloadVODDownloadItem:(LECVODDownloadItem *) vodDownloadItem;
//下载中的下载状态返回
- (void) vodDownloadManager:(LCVODDownloadManager *) downloadManager downloadingVODDownloadItem:(LECVODDownloadItem *) vodDownloadItem downloadedBytes:(long long) downloadedBytes totalBytes:(long long) totalBytes speed:(float) speed;
//完成下载事件
- (void) vodDownloadManager:(LCVODDownloadManager *) downloadManager didFinishDownloadVODDownloadItem:(LECVODDownloadItem *) vodDownloadItem;
//下载出错
- (void) vodDownloadManager:(LCVODDownloadManager *) downloadManager didFailDownloadVODDownloadItem:(LECVODDownloadItem *) vodDownloadItem withErrorCode:(NSString *) errorCode withErrorDesc:(NSString *) errorDesc;

@end

@interface LCVODDownloadManager : NSObject

@property (nonatomic, readonly) NSArray <LECVODDownloadItem *>*vodItemsList;//获取下载队列中的LECVODDownloadItem
@property (nonatomic, weak) id<LCVODDownloadManagerDelegate> delegate;//点播下载代理
@property (nonatomic, assign) LCVODDownloadManagerDefaultCodeSelectType defaultCodeSelectType;  //没有传入下载码率的下载任务会根据该值选择一个默认码率进行下载；默认选择的码率如果已经存在会直接报错，不会引起恢复的操作

+ (id) sharedManager;
//创建下载Item
- (LECVODDownloadItem *) createVODDownloadItemWithUu:(NSString *) uu
                                              withVu:(NSString *) vu
                                            userInfo:(NSDictionary *) dict
                             withExpectVideoCodeType:(NSString *) videoCodeType;    //如果传入nil，则会根据defaultCodeSelectType选择默认码率

- (LECVODDownloadItem *) createVODDownloadItemWithUu:(NSString *) uu
                                              withVu:(NSString *) vu
                                            userInfo:(NSDictionary *) dict
                             withExpectVideoCodeType:(NSString *) videoCodeType
                                    withPayCheckCode:(NSString *) payCheckCode
                                     withPayUserName:(NSString *) payUserName;

- (LECVODDownloadItem *) createVODDownloadItemWithUu:(NSString *) uu
                                                  vu:(NSString *) vu
                                            userInfo:(NSDictionary *) dict
                                 expectVideoCodeType:(NSString *) videoCodeType
                                        payCheckCode:(NSString *) payCheckCode
                                         payUserName:(NSString *) payUserName
                                             options:(LCPlayerOption *)options;

//开始下载
- (BOOL) startDownloadWithVODItem:(LECVODDownloadItem *) downloadItem;          //如果存在相同码率，则会返回错误
//暂停下载
- (void) pauseDownloadWithVODItem:(LECVODDownloadItem *) downloadItem;
//清空已经存在的下载
- (void) cleanDownloadWithVODItem:(LECVODDownloadItem *) downloadItem NS_DEPRECATED_IOS(0_1, 7_0);  //使用 removeDownloadWithVODItem 代替
- (void) removeDownloadWithVODItem:(LECVODDownloadItem *) downloadItem;


//根据点播uu和vu获取多种码率下载LECVODDownloadItem
- (NSArray *) vodItemsListWithUu:(NSString *) uu vu:(NSString *) vu;
//刷新库内容到本地list
- (void) refreshVodItemsList;

@end
