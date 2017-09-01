//
//  ZCPTableViewCell.h
//  Apartment
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

// 配置块声明
typedef void(^ZCPButtonConfigBlock)(UIButton *button);  // 按钮配置块
typedef void(^ZCPTextFieldConfigBlock)(UITextField *);  // textField配置块
typedef void(^ZCPImageViewConfigBlock)(UIImageView *);  // imageView配置块

// ----------------------------------------------------------------------
#pragma mark - Cell基类
// ----------------------------------------------------------------------
@interface ZCPTableViewCell : UITableViewCell

 // cell item
@property (nonatomic, strong) id<ZCPTableViewCellItemBasicProtocol> object;

// 初始化cell中控件
- (void)setupContentView;
// 返回cell高度
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id<ZCPTableViewCellItemBasicProtocol>)object;
// 返回cell的重用标识
+ (NSString *)cellIdentifier;

@end
