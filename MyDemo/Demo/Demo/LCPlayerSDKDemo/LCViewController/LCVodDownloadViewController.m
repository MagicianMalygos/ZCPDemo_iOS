//
//  LCVodDownloadViewController.m
//  LCPlayerSDKConsumerDemo
//
//  Created by CC on 16/1/15.
//  Copyright © 2016年 CC. All rights reserved.
//

#import "LCVodDownloadViewController.h"
#import "LCVODDownloadManager.h"
#import "LECVODPlayer.h"


@interface LCVodDownloadViewController ()<LCVODDownloadManagerDelegate>

@property (nonatomic, strong) NSString * uu;
@property (nonatomic, strong) NSString * vu;
@property (nonatomic, strong) LCStreamRateItem * currentRateItem;
@property (nonatomic, strong) LECVODDownloadItem * downloadItem;

@end


@implementation LCVodDownloadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
                   uu:(NSString *)uu
                   vu:(NSString *)vu
                 rate:(id)rate
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        _uu = uu;
        _vu = vu;
        _currentRateItem = rate;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    LCVODDownloadManager *sharedManager = [LCVODDownloadManager sharedManager];
    sharedManager.delegate = self;
    //Test移除已经下载的文件
    if (sharedManager.vodItemsList.count != 0)
    {
        for (int i = 0; i < sharedManager.vodItemsList.count; i++)
        {
            [sharedManager cleanDownloadWithVODItem:[sharedManager.vodItemsList objectAtIndex:i]];
        }
    }
}


#pragma mark - 按钮事件
- (IBAction)clickToBack:(id)sender
{
    LCVODDownloadManager *sharedManager = [LCVODDownloadManager sharedManager];
    [sharedManager pauseDownloadWithVODItem:_downloadItem];
    sharedManager.delegate = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickToStartDownload:(id)sender
{
//    LCVODDownloadManager *sharedManager = [LCVODDownloadManager sharedManager];
//    _downloadItem = [sharedManager createVODDownloadItemWithUu:_uu
//                                                                            withVu:_vu
//                                                                          userInfo:nil
//                                                           withExpectVideoCodeType:_currentRateItem.code];
//    [sharedManager startDownloadWithVODItem:_downloadItem];
//    
//    
    LCVODDownloadManager *sharedManager = [LCVODDownloadManager sharedManager];
    sharedManager.delegate = self;
    
    //    LECVODDownloadItem *downloadItem = [sharedManager createVODDownloadItemWithUu:@"40ff268ca7"
    //                                                                                withVu:@"aae004ab8b"
    //                                                               withExpectVideoCodeType:@"21"];
    //    [sharedManager startDownloadWithVODItem:downloadItem];
    
    NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:@"obj1", @"key1", @"obj2", @"key2", nil];
    
    NSArray *vuArray = [NSArray arrayWithObjects:@"14ab558b99",
                        @"b826ccbb00",
                        @"ab66276435",
                        @"386d6cb3f0",
                        @"20e2d8f754",
                        @"b34d4d0dba",
                        @"2d63a4bf68",
                        @"3121582e3a",
                        @"c35e62549b",
                        @"84f6f9b7aa", nil];
    NSMutableArray *downItems = [[NSMutableArray alloc]init];
    for (int i = 0; i < 10; i ++) {
        LECVODDownloadItem *downloadItem1 = [sharedManager createVODDownloadItemWithUu:@"983f0bfe3b"
                                                                                withVu:vuArray[i]
                                                                              userInfo:userInfo
                                                               withExpectVideoCodeType:nil];
        [downItems addObject:downloadItem1];
    }
    [sharedManager startDownloadWithVODItem:downItems[0]];
    [sharedManager startDownloadWithVODItem:downItems[1]];
    [sharedManager startDownloadWithVODItem:downItems[2]];
    [sharedManager startDownloadWithVODItem:downItems[3]];
    [sharedManager startDownloadWithVODItem:downItems[4]];
    [sharedManager startDownloadWithVODItem:downItems[5]];
    [sharedManager startDownloadWithVODItem:downItems[6]];
    [sharedManager startDownloadWithVODItem:downItems[7]];
    [sharedManager startDownloadWithVODItem:downItems[8]];
    [sharedManager startDownloadWithVODItem:downItems[9]];
    

}

#pragma mark - LCVODDownloadManagerDelegate
- (void) vodDownloadManager:(LCVODDownloadManager *) downloadManager didBeginDownloadVODDownloadItem:(LECVODDownloadItem *) vodDownloadItem {
    NSLog(@"开始下载");
}

- (void) vodDownloadManager:(LCVODDownloadManager *) downloadManager downloadingVODDownloadItem:(LECVODDownloadItem *) vodDownloadItem downloadedBytes:(long long)downloadedBytes totalBytes:(long long)totalBytes speed:(float)speed{
    NSLog(@"downloaded: %lld / %lld", downloadedBytes, totalBytes);
    NSLog(@"下载速度: %f", speed);
}

- (void) vodDownloadManager:(LCVODDownloadManager *) downloadManager didFinishDownloadVODDownloadItem:(LECVODDownloadItem *) vodDownloadItem {
    NSLog(@"下载完成");
}

- (void) vodDownloadManager:(LCVODDownloadManager *) downloadManager didFailDownloadVODDownloadItem:(LECVODDownloadItem *) vodDownloadItem withErrorCode:(NSString *) errorCode withErrorDesc:(NSString *) errorDesc {
    NSLog(@"下载出错:%@,%@",errorCode,errorDesc);
}

@end
