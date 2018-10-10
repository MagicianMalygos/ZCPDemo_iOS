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
    
    // 1.不同系统使用不同样式的图片，详见UIImage+Runtime
    [UIImage openUIImageRuntimeTest];
    UIImage *image          = [UIImage imageNamed:@"rocket"];
    UIImageView *imageView  = [[UIImageView alloc] init];
    imageView.frame         = CGRectMake(100, 100, 200, 200);
    imageView.image         = image;
    [self.view addSubview:imageView];
    
    // 2.在分类中增加属性，详见OCClassPropertyDemo
    /*
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
     
     4.使用runtime将self关联一个name属性
     objc_getAssociatedObject(self, &name_var);
     objc_setAssociatedObject(self, &name_var, name, OBJC_ASSOCIATION_COPY);
     
     */
    ZCPUser *user001    = [ZCPUser new];
    user001.uID         = @"001";
    user001.name        = @"Zcp大官人";
    user001.level       = @(120);
    ZCPLog(@"分类添加属性结果：%@", user001);
    
    ZCPUser *user002    = [ZCPUser new];
    user002.uID         = @"002";
    user002.name        = @"飞花蝶舞剑";
    user002.level       = @(320);
    
    // 3.运行时归档，详见ZCPUser类的NSCoding协议实现
    // 3.1
    {
        NSMutableData *user001Data      = [[NSMutableData alloc] init];
        NSKeyedArchiver *archiver       = [[NSKeyedArchiver alloc] initForWritingWithMutableData:user001Data];
        [archiver encodeObject:user001 forKey:@"user"];
        [archiver finishEncoding];
        // 存data
        [self writeData:user001Data withKey:@"user001"];
    }
    {
        // 取data
        NSData *user001Data             = [self readDataWithKey:@"user001"];
        NSKeyedUnarchiver *unarchiver   = [[NSKeyedUnarchiver alloc] initForReadingWithData:user001Data];
        ZCPUser *resultUser             = [unarchiver decodeObjectForKey:@"user"];
        ZCPLog(@"运行时归档解档1结果：%@", resultUser);
    }
    
    // 3.2
    {
        NSArray *userGroup              = @[user001, user002];
        NSData *userGroupData           = [NSKeyedArchiver archivedDataWithRootObject:userGroup];
        // 存data
        [self writeData:userGroupData withKey:@"group"];
    }
    {
        // 取data
        NSData *userGroupData           = [self readDataWithKey:@"group"];
        NSArray *resultArray            = [NSKeyedUnarchiver unarchiveObjectWithData:userGroupData];
        ZCPLog(@"运行时归档解档2结果：%@", resultArray);
    }
    
    // e:归档解档时发现的一个问题
    {
        NSArray *paths                  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        // UIImage实现了NSSecureCoding协议，应该是可以归档解档
        
        // image1进行归档解档
        UIImage *testImage1             = [UIImage imageNamed:@"rocket"];
        UIImageAsset *asset1            = testImage1.imageAsset;
        NSString *filePath1             = [[paths objectAtIndex:0] stringByAppendingString:@"/image1.data"];
        [NSKeyedArchiver archiveRootObject:testImage1 toFile:filePath1];
        id object1                      = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath1];
        
        // image2进行归档解档
        UIImage *testImage2             = [UIImage imageWithCGImage:testImage1.CGImage];
        UIImageAsset *asset2            = testImage2.imageAsset;
        NSString *filePath2             = [[paths objectAtIndex:0] stringByAppendingString:@"/image2.data"];
        [NSKeyedArchiver archiveRootObject:testImage2 toFile:filePath2];
        id object2                      = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath2];
        
        // 结果会发现，object1是nil，object2是有值的。这是由于UIImage实例的imageAsset属性导致的。如果对UIImage的实例进行归档解档，需要做一次CGImage的转换
        ZCPLog(@"image1:%@ asset1:%@\nimage2:%@ asset1:%@", object1, asset1, object2, asset2);
    }
    
    // 4.动态添加方法
    /*
     问题：如果一个类的实例方法非常多，加载类到内存的时候也比较耗费资源，需要给每个方法生成映射表。
     解决：可以动态给某个类添加方法解决。
     */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [user001 performSelector:@selector(eat)];
    [user001.class performSelector:@selector(privilegeList)];
#pragma clang diagnostic pop
    
    // 5.字典转模型
    NSDictionary *userDict              = @{@"uID": @"1001", @"name": @"Zcp大官人", @"level": @"107", @"sex": @"male"};
    ZCPUser *userModel                  = [[ZCPUser alloc] init];
    [userModel setValuesForKeysWithDictionary:userDict];
    ZCPLog(@"字典转模型结果：%@", userModel);
}

#pragma mark - private method

// 读取数据
- (NSData *)readDataWithKey:(NSString *)key {
    NSArray *arrDocumentPaths   = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentPath      = [arrDocumentPaths objectAtIndex:0];
    NSString *filePath          = [documentPath stringByAppendingString:@"/user.data"];
    NSData *resultData          = [NSData dataWithContentsOfFile:filePath];
    return resultData;
}

// 写入数据
- (void)writeData:(NSData *)data withKey:(NSString *)key {
    NSArray *arrDocumentPaths   = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentPath      = [arrDocumentPaths objectAtIndex:0];
    NSString *filePath          = [documentPath stringByAppendingString:@"/user.data"];
    [data writeToFile:filePath atomically:NO];
}

@end
