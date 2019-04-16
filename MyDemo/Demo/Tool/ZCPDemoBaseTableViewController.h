//
//  ZCPDemoBaseTableViewController.h
//  Demo
//
//  Created by 朱超鹏 on 2017/10/10.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import <ZCPKit.h>
#import <ZCPUIKit.h>

@interface ZCPDemoBaseTableViewController : ZCPTableViewController<ZCPViewControllerBaseProtocol, ZCPNavigatorProtocol>

@property (nonatomic, strong) NSMutableArray *infoArr;

@end
