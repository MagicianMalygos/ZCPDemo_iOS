//
//  TestDownloadViewController.m
//  LECPlayerSDKDemo
//
//  Created by 侯迪 on 10/28/15.
//  Copyright © 2015 letv. All rights reserved.
//

#import "TestDownloadViewController.h"
#import "LECVODDownloadManager.h"
#import "TestDownloadTableViewCell.h"

@interface TestDownloadViewController () <LECVODDownloadManagerDelegate, TestDownloadTableViewCellDelegate>

- (IBAction) onTestDownloadPressed:(id)sender;
- (IBAction) onBackPressed:(id)sender;

@property (nonatomic, strong) NSArray *downloadList;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end

@implementation TestDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    LECVODDownloadManager *sharedManager = [LECVODDownloadManager sharedManager];
    sharedManager.delegate = self;
    self.downloadList = sharedManager.vodItemsList;
    if (!self.tableView.isEditing) {
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Private Methods
- (IBAction) onTestDownloadPressed:(id)sender {
    LECVODDownloadManager *sharedManager = [LECVODDownloadManager sharedManager];
    sharedManager.delegate = self;
    sharedManager.defaultCodeSelectType = LECVODDownloadManagerDefaultCodeSelectTypeHighest;

//    LECVODDownloadItem *downloadItem = [sharedManager createVODDownloadItemWithUu:@"40ff268ca7"
//                                                                                withVu:@"aae004ab8b"
//                                                               withExpectVideoCodeType:@"21"];
//    [sharedManager startDownloadWithVODItem:downloadItem];
    
    NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:@"obj1", @"key1", @"obj2", @"key2", nil];

    LECPlayerOption *option = [[LECPlayerOption alloc] init];
    option.p = @"120";
    option.businessLine = LECBusinessLineSaas;

    LECVODDownloadItem *downloadItem1 = [sharedManager createVODDownloadItemWithUu:@"40ff268ca7"
                                                                                vu:@"b32c851d93"
                                                                          userInfo:nil
                                                               expectVideoCodeType:nil
                                                                      payCheckCode:nil
                                                                       payUserName:nil
                                                                           options:nil];
    
    
    LECVODDownloadItem *downloadItem2 = [sharedManager createVODDownloadItemWithUu:@"40ff268ca7"
                                                                                vu:@"1541c1becb"
                                                                          userInfo:nil
                                                               expectVideoCodeType:nil
                                                                      payCheckCode:nil
                                                                       payUserName:nil
                                                                           options:nil];

    LECVODDownloadItem *downloadItem3 = [sharedManager createVODDownloadItemWithUu:@"40ff268ca7"
                                                                                vu:@"6c658686bf"
                                                                          userInfo:nil
                                                               expectVideoCodeType:nil
                                                                      payCheckCode:nil
                                                                       payUserName:nil
                                                                           options:nil];
    
    LECVODDownloadItem *downloadItem4 = [sharedManager createVODDownloadItemWithUu:@"40ff268ca7"
                                                                                vu:@"9de5e51e82"
                                                                          userInfo:nil
                                                               expectVideoCodeType:nil
                                                                      payCheckCode:nil
                                                                       payUserName:nil
                                                                           options:nil];
    
    LECVODDownloadItem *downloadItem5 = [sharedManager createVODDownloadItemWithUu:@"40ff268ca7"
                                                                                vu:@"cadc75cfe6"
                                                                          userInfo:nil
                                                               expectVideoCodeType:nil
                                                                      payCheckCode:nil
                                                                       payUserName:nil
                                                                           options:nil];

    [sharedManager startDownloadWithVODItem:downloadItem1];
    [sharedManager startDownloadWithVODItem:downloadItem2];
    [sharedManager startDownloadWithVODItem:downloadItem3];
    [sharedManager startDownloadWithVODItem:downloadItem4];
    [sharedManager startDownloadWithVODItem:downloadItem5];

    
//    LCVODDownloadManager *man = [LCVODDownloadManager sharedManager];
////    NSString *s[] =
////    {@"14ab558b99", @"b826ccbb00", @"ab66276435", @"386d6cb3f0", @"20e2d8f754", @"b34d4d0dba", @"2d63a4bf68", @"3121582e3a", @"c35e62549b", @"84f6f9b7aa"}
////    ;
////    for(int i = 0; i < 10;i++) {
//        LECVODDownloadItem *a = [man createVODDownloadItemWithUu:@"40ff268ca7"
//                                                        withVu:@"b32c851d93"
//                                                      userInfo:nil
//                                       withExpectVideoCodeType:LCVODDownloadManagerDefaultCodeSelectTypeHighest
//                               ];
//        [man startDownloadWithVODItem:a];
////    }
    
    self.downloadList = sharedManager.vodItemsList;
    
    if (!self.tableView.isEditing) {
        [self.tableView reloadData];
    }
}

- (IBAction) onBackPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) vodDownloadManager:(LECVODDownloadManager *) downloadManager didBeginDownloadVODDownloadItem:(LECVODDownloadItem *) vodDownloadItem {
    if (!self.tableView.isEditing) {
        [self.tableView reloadData];
    }
}

- (void) vodDownloadManager:(LECVODDownloadManager *) downloadManager downloadingVODDownloadItem:(LECVODDownloadItem *) vodDownloadItem downloadedBytes:(long long)downloadedBytes totalBytes:(long long)totalBytes speed:(float)speed{
//    NSLog(@"downloaded: %lld / %lld", downloadedBytes, totalBytes);
//    NSLog(@"speed: %f", speed);
    if (!self.tableView.isEditing) {
        [self.tableView reloadData];
    }
}

- (void) vodDownloadManager:(LECVODDownloadManager *) downloadManager didFinishDownloadVODDownloadItem:(LECVODDownloadItem *) vodDownloadItem {
    if (!self.tableView.isEditing) {
        [self.tableView reloadData];
    }
}

- (void) vodDownloadManager:(LECVODDownloadManager *) downloadManager didFailDownloadVODDownloadItem:(LECVODDownloadItem *) vodDownloadItem withErrorCode:(NSString *) errorCode withErrorDesc:(NSString *) errorDesc {
    if (!self.tableView.isEditing) {
        [self.tableView reloadData];
    }
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.downloadList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LECVODDownloadItem *downloadItem = self.downloadList[indexPath.row];
    
    TestDownloadTableViewCell *testDownloadTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"TestDownloadTableViewCell"];
    
    if (!testDownloadTableViewCell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TestDownloadTableViewCell" owner:self options:nil];
        testDownloadTableViewCell = [nib objectAtIndex:0];
        testDownloadTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        testDownloadTableViewCell.delegate = self;
    }
    
    testDownloadTableViewCell.vodDownloadItem = downloadItem;
    
    return testDownloadTableViewCell;
}

#pragma mark - Cell Delegate
- (void) testDownloadTableViewCellOperateButtonPressed:(TestDownloadTableViewCell *) cell {
    LECVODDownloadManager *sharedManager = [LECVODDownloadManager sharedManager];
    LECVODDownloadItem *downloadItem = cell.vodDownloadItem;
    if (downloadItem.status == LECVODDownloadItemStatusInit || downloadItem.status == LECVODDownloadItemStatusDownloadPause || downloadItem.status == LECVODDownloadItemStatusDownloadFail) {
        [sharedManager startDownloadWithVODItem:downloadItem];
    }
    else if (downloadItem.status == LECVODDownloadItemStatusWaitting || downloadItem.status == LECVODDownloadItemStatusDownloading) {
        [sharedManager pauseDownloadWithVODItem:downloadItem];
        [sharedManager pauseDownloadWithVODItem:downloadItem];
    }
    if (!self.tableView.isEditing) {
        [self.tableView reloadData];
    }
}

#pragma mark - UITableView Delegate
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  UITableViewCellEditingStyleDelete;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    LECVODDownloadManager *sharedManager = [LECVODDownloadManager sharedManager];
    LECVODDownloadItem *downloadItem = self.downloadList[indexPath.row];
    [sharedManager cleanDownloadWithVODItem:downloadItem];
    self.downloadList = sharedManager.vodItemsList;
    [self.tableView reloadData];
}


@end
