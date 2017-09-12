//
//  TestCell.h
//  ZCPKitDemo
//
//  Created by 朱超鹏 on 2017/9/11.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "ZCPTableViewCell.h"

@interface TestCellItem : ZCPCellDataModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;

@end

@interface TestCell : ZCPTableViewCell

@property (nonatomic, strong) UILabel *testTitleLabel;
@property (nonatomic, strong) UILabel *testSubTitleLabel;
@property (nonatomic, strong) TestCellItem *item;

@end
