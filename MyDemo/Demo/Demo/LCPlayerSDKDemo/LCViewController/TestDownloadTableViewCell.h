//
//  TestDownloadTableViewCell.h
//  LECPlayerSDKDemo
//
//  Created by 侯迪 on 10/28/15.
//  Copyright © 2015 letv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LECVODDownloadItem.h"

@class TestDownloadTableViewCell;

@protocol TestDownloadTableViewCellDelegate <NSObject>

- (void) testDownloadTableViewCellOperateButtonPressed:(TestDownloadTableViewCell *) cell;

@end

@interface TestDownloadTableViewCell : UITableViewCell

@property (nonatomic, strong) LECVODDownloadItem *vodDownloadItem;
@property (nonatomic, weak) id<TestDownloadTableViewCellDelegate> delegate;

@end
