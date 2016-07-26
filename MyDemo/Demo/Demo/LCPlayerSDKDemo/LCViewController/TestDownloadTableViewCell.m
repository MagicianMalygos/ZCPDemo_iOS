//
//  TestDownloadTableViewCell.m
//  LECPlayerSDKDemo
//
//  Created by 侯迪 on 10/28/15.
//  Copyright © 2015 letv. All rights reserved.
//

#import "TestDownloadTableViewCell.h"

@interface TestDownloadTableViewCell ()

@property (nonatomic, strong) IBOutlet UILabel *uuLabel;
@property (nonatomic, strong) IBOutlet UILabel *vuLabel;
@property (nonatomic, strong) IBOutlet UILabel *statusLabel;
@property (nonatomic, strong) IBOutlet UIButton *operateButton;

- (IBAction) onOperateButtonPressed:(id)sender;

@end

@implementation TestDownloadTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSString *statusDesc;
    NSString *operateButtonDesc;
    switch (self.vodDownloadItem.status) {
        case LECVODDownloadItemStatusInit:
            statusDesc = @"未下载";
            operateButtonDesc = @"下载";
            break;
        case LECVODDownloadItemStatusWaitting:
            statusDesc = @"等待中";
            operateButtonDesc = @"暂停";
            break;
        case LECVODDownloadItemStatusDownloading:
            statusDesc = [NSString stringWithFormat:@"%d%%", (int)(self.vodDownloadItem.percent * 100)];
            operateButtonDesc = @"暂停";
            break;
        case LECVODDownloadItemStatusDownloadFinish:
            statusDesc = @"完成";
            operateButtonDesc = @"";
            break;
        case LECVODDownloadItemStatusDownloadPause:
            statusDesc = @"已暂停";
            operateButtonDesc = @"继续";
            break;
        case LECVODDownloadItemStatusDownloadFail:
            statusDesc = [NSString stringWithFormat:@"失败:%@", self.vodDownloadItem.errorDesc];
            operateButtonDesc = @"开始";
            break;
        default:
            break;
    }
    self.uuLabel.text = self.vodDownloadItem.uu;
    self.vuLabel.text = self.vodDownloadItem.vu;
    self.statusLabel.text = statusDesc;
    [self.operateButton setTitle:operateButtonDesc forState:UIControlStateNormal];
}

- (IBAction) onOperateButtonPressed:(id)sender {
    if ([_delegate respondsToSelector:@selector(testDownloadTableViewCellOperateButtonPressed:)]) {
        [_delegate testDownloadTableViewCellOperateButtonPressed:self];
    }
}

@end
