//
//  ShareDemoHomeController.m
//  Demo
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ShareDemoHomeController.h"

@implementation ShareDemoHomeController

@synthesize infoArr = _infoArr;

- (NSMutableArray *)infoArr {
    if (_infoArr == nil) {
        _infoArr = @[@{@"title": @"新浪微博SDK", @"class": @"SinaShareDemoHomeController"},
                     @{@"title": @"微信SDK", @"class": @"WeiXinShareDemoHomeController"}].mutableCopy;
    }
    return _infoArr;
}

- (void)tableView:(UITableView *)tableView didSelectObject:(id<ZCPTableViewCellItemBasicProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath {
    Class vcClass = NSClassFromString([[self.infoArr objectAtIndex:indexPath.row] valueForKey:@"class"]);
    UIViewController *vc = [vcClass new];
    if (vcClass && vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
