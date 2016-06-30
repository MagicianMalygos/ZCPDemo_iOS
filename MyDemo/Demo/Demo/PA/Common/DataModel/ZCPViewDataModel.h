//
//  ZCPViewDataModel.h
//  Apartment
//
//  Created by apple on 15/12/28.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

// 视图模型基类
@interface ZCPViewDataModel : ZCPDataModel

// ViewController 类
@property (nonatomic, strong) Class vcClass;
// ViewController 初始化方法
@property (nonatomic, strong) NSValue *vcInitMethod;
// ViewController 实例化方法
@property (nonatomic, strong) NSValue *vcInstanceMethod;
// 初始化方法参数
@property (nonatomic, strong) NSMutableDictionary *paramDictForInit;
// 实例化方法参数
@property (nonatomic, strong) NSMutableDictionary *paramDictForInstance;
// 标识
@property (nonatomic, copy) NSString *identifier;

@end
