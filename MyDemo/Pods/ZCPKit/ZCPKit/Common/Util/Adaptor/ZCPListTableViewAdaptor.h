//
//  ZCPListTableViewAdaptor.h
//  ZCPKit
//
//  Created by zhuchaopeng on 16/9/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCPTableViewCellItemBasicProtocol.h"

@protocol ZCPListTableViewAdaptorDelegate;

// ----------------------------------------------------------------------
#pragma mark - 处理tableview的适配工作
// ----------------------------------------------------------------------
@interface ZCPListTableViewAdaptor : NSObject <UITableViewDelegate, UITableViewDataSource>

// tableView
@property (nonatomic, weak, nullable)   UITableView         *tableView;
// cell显示所需数据数组，每一个数据模型都要实现PATableViewCellItemBasicProtocol协议
@property (nonatomic, strong, nullable) NSMutableArray      *items;
// cell点击事件对应的action，使用celltype进行索引
@property (nonatomic, strong, nullable) NSMutableDictionary *cellActionDictionary;
// cell执行点击事件的对象存放的字典，使用celltype进行索引
@property (nonatomic, strong, nullable) NSMutableDictionary *cellTargetDictionary;
// delegate
@property (nonatomic, weak, nullable)   id<ZCPListTableViewAdaptorDelegate> delegate;

@end

// ----------------------------------------------------------------------
#pragma mark - 适配器协议
// ----------------------------------------------------------------------
@protocol ZCPListTableViewAdaptorDelegate <NSObject>

@optional

// cell选中事件
- (void)tableView:(nonnull UITableView *)tableView didSelectObject:(nonnull id<ZCPTableViewCellItemBasicProtocol>)object rowAtIndexPath:(nonnull NSIndexPath *)indexPath;
// cell初始化事件
- (void)tableView:(nonnull UITableView *)tableView didSetObject:(nonnull id<ZCPTableViewCellItemBasicProtocol>)object cell:(nonnull UITableViewCell *)cell;

// cell是否可编辑
- (BOOL)tableView:(nonnull UITableView *)tableView canEditRowAtIndexPath:(nonnull NSIndexPath *)indexPath;
// cell左滑编辑按钮样式
- (UITableViewCellEditingStyle)tableView:(nonnull UITableView *)tableView editingStyleForRowAtIndexPath:(nonnull NSIndexPath *)indexPath;
// 点击编辑按钮
- (void)tableView:(nonnull UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath;
// cell左滑编辑按钮title
- (nullable NSString *)tableView:(nonnull UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(nonnull NSIndexPath *)indexPath;

@end
