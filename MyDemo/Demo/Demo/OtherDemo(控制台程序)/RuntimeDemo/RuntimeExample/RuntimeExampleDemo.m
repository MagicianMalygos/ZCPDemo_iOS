//
//  RuntimeExampleDemo.m
//  Demo
//
//  Created by 朱超鹏(外包) on 17/2/13.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "RuntimeExampleDemo.h"

#import "UIImage+Runtime.h"
#import "ZCPUser.h"
#import "ZCPUser+AddProperty.h"

@implementation RuntimeExampleDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.不同系统使用不同样式的图片
    [UIImage openRuntimeTest];
    UIImage *image = [UIImage imageNamed:@"rocket"];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(100, 100, 200, 200);
    imageView.image = image;
    [self.view addSubview:imageView];
    
    // 2.分类增加属性，详见OCClassPropertyDemo
    // 1.给分类添加属性
    /*
     http://www.jianshu.com/p/3cbab68fb856
     
     1.当直接在category中加属性使用时，会crash。
     *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[ZCPUser setName:]: unrecognized selector sent to instance 0x60000001f2d0'
     
     2.在加了get set方法和@synthesize之后，编译不通过。
     @synthesize not allowed in a category`s implementation
     
     3.将@synthesize改为@dynamic依旧不行，然后又加了一个扩展，依旧编译不通过。
     Undefined symbols for architecture x86_64:
     "_OBJC_IVAR_$_ZCPUser._name", referenced from:
     -[ZCPUser(AddProperty) name] in ZCPUser+AddProperty.o
     -[ZCPUser(AddProperty) setName:] in ZCPUser+AddProperty.o
     ld: symbol(s) not found for architecture x86_64
     
     4.runtime解决问题
     objc_getAssociatedObject(self, &name_var);
     objc_setAssociatedObject(self, &name_var, name, OBJC_ASSOCIATION_COPY);
     
     */
    ZCPUser *user = [ZCPUser new];
    user.uID = @"001";
    user.name = @"Zcp大官人";
    ZCPLog(@"分类添加属性结果：%@", user);
    
    // 3.运行时归档
    
    // 3.1
    NSMutableData *data1 = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data1];
    [archiver encodeObject:user forKey:@"user"];
    [archiver finishEncoding];
    // 存data
    // 取data
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data1];
    ZCPUser *resultUser = [unarchiver decodeObjectForKey:@"user"];
    ZCPLog(@"运行时归档解档1结果：%@", resultUser);
    
    // 3.2
    NSArray *array = @[@"我是Test字符串", @(9527), user];
    NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:array];
    // 存data
    // 取data
    NSArray *resultArray = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
    ZCPLog(@"运行时归档解档2结果：%@", resultArray);
    
    // 4.动态添加方法
    // 如果一个类方法非常多，加载类到内存的时候也比较耗费资源，需要给每个方法生成映射表，可以使用动态给某个类，添加方法解决。
    [user performSelector:@selector(eat)];
    
    // 5.字典转模型
    NSDictionary *userDict = @{@"uID": @"1001", @"name": @"Zcp大官人", @"age": @"18", @"sex": @"male"};
    ZCPUser *userModel = [[ZCPUser alloc] init];
    [userModel setValuesForKeysWithDictionary:userDict];
    ZCPLog(@"字典转模型结果：%@", userModel);
    
}

@end
