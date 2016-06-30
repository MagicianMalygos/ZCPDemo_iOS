//
//  MyViewDataModel.h
//  JumpToVC
//
//  Created by apple on 15/12/4.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MyDataModel.h"

// 视图模型基类
@interface MyViewDataModel : MyDataModel

// viewcontroller 类
@property (nonatomic, strong) Class viewControllerClass;
// viewcontroller 初始化方法
@property (nonatomic, strong) NSValue *viewControllerInitMethod;
// viewcontroller 实例化方法
@property (nonatomic, strong) NSValue *viewControllerInstanceMethod;
// 初始化方法参数
@property (nonatomic, strong) NSMutableDictionary *paramDictForInit;
// 实例化方法参数
@property (nonatomic, strong) NSMutableDictionary *paramDictForInstance;
// 标识
@property (nonatomic, copy) NSString *identifier;

@end
