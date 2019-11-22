//
//  ZCPLDViewController.m
//  Demo
//
//  Created by zcp on 2019/5/14.
//  Copyright © 2019 zcp. All rights reserved.
//

#import "ZCPLDViewController.h"
#import "ZCPLDFrameViewController.h"
#import "ZCPLDStackViewController.h"

@interface ZCPLDViewController ()

@end

@implementation ZCPLDViewController

@synthesize infoArr = _infoArr;

- (NSMutableArray *)infoArr {
    if (!_infoArr) {
        _infoArr = [NSMutableArray arrayWithObjects:
                    @{@"title": @"Frame", @"class": @"frame"},
                    @{@"title": @"Stack", @"class": @"stack"},
                    nil];
    }
    return _infoArr;
}

- (void)tableView:(UITableView *)tableView didSelectObject:(nonnull id<ZCPTableViewCellProtocol>)object rowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSString *identifier = self.infoArr[indexPath.row][@"class"];
    
    if ([identifier isEqualToString:@"frame"]) {
        [self.navigationController pushViewController:[ZCPLDFrameViewController new] animated:YES];
    } else if ([identifier isEqualToString:@"stack"]) {
        [self.navigationController pushViewController:[ZCPLDStackViewController new] animated:YES];
    }
}

@end
