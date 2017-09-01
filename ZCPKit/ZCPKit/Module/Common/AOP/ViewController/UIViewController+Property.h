//
//  UIViewController+Property.h
//  ZCPKit
//
//  Created by 朱超鹏 on 2017/8/10.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Property)

@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, strong) NSNumber *needsTapToDismissKeyboard;

@end
