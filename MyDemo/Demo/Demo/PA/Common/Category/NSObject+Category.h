//
//  NSObject+Category.h
//  haofang
//
//  Created by PengFeiMeng on 4/19/14.
//  Copyright (c) 2014 平安好房. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Category)


//FIXME: 目前不支持基本数据类型的遍历，如果有基本数据类型，不要使用这个方法，会crash
/*!
 @method
 @abstract      打印所有实例变量
 */
- (void)logIvarList;


/*!
 @method
 @abstract      判断对象是否未nil或[NSNull null]对象
 @return        BOOL
 */
- (BOOL)isNilOrNull;

/*!
 @method
 @abstract      执行selector方法
 @param         aSelector: 要执行的方法
 @param         objects: 参数
 @return        id
 */
- (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects;

/*!
 @method
 @abstract      获取字符串值
 */
- (NSString *)stringValue;

/*!
 @method
 @abstract      获取图片对象的类型
 @param         data: 图片二进制对象
 @discussion    根据二进制对象的第一个字节来判断该图片类型
 @return        NSString
 */
+ (NSString *)contentTypeForImageData:(NSData *)data;

@end


@interface NSObject (Release)
- (void) paDealloc;
- (void) paRelease;
@end
