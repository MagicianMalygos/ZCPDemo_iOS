//
//  ZCPTableViewCell.h
//  Apartment
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CELLWIDTH_DEFAULT   APPLICATIONWIDTH

// 配置块声明
typedef void(^ZCPButtonConfigBlock)(UIButton *button);  // 按钮配置块
typedef void(^ZCPTextFieldConfigBlock)(UITextField *);  // textField配置块
typedef void(^ZCPImageViewConfigBlock)(UIImageView *);  // imageView配置块

// Cell基类
@interface ZCPTableViewCell : UITableViewCell

@property (nonatomic, strong) NSObject *object;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setupContentView;
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object;

+ (NSString *)cellIdentifier;

@end
