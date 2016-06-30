//
//  NSDate+Category.h
//  haofang
//
//  Created by Aim on 14-3-19.
//  Copyright (c) 2014年 平安好房. All rights reserved.
//


/**
 *  为SDK自带的 NSDate 类添加一些实用方法
 */
@interface NSDate (Category)

/* 日期字符串转换为 NSDate */
+ (NSDate *)dateFromString:(NSString *)dateString;
+ (NSDate *)dateFromYDMHmsString:(NSString *)dateString;
+ (NSDate *)dateFromString:(NSString *)dateString withDateFormat:(NSString *)format;
/* 当前NSDate转为字符串 */
- (NSString *)toString;


/* 获取yyyy/mm/dd 格式日期 */
- (NSString *)getYMDShortString;
//获取月-天-时-分
+ (NSString *)getMDHM:(long)timestamps;
/* 比较两个时间之间差距的绝对值 */
- (NSTimeInterval)absIntervalSinceDate:(NSDate *)date;
/* 当前时间对象和现在时间差的绝对值 */
- (NSTimeInterval)absIntervalSinceNow;
/* 根据时间戳计算天、小时、时、分 秒*/
+ (NSString *)getTimeByInterval:(NSTimeInterval)interval;
/* 根据时间戳计算天、小时、时、分 */
+ (NSString *)getTimeWithoutSecondByInterval:(NSTimeInterval)interval;
/* 获取当前时间戳*/
+ (NSString *)getTimeStamp;
//生成xx年xx月xx日格式
- (NSString *)getYMDString;
//生成xx月-xx日格式
- (NSString *)getMDDateString;
// 获取X月X日格式的字符串，如果不是当年日期，返回的字符串为XXXX年X月X日
- (NSString *) an_friendlyDateString;
//生成年
- (NSString *)getYear;
//生成月
- (NSString *)getMonth;
// 生成日
- (NSString *)getDay;
- (NSString *)getDateStringYYYYMMddHHmmss;
/*!
 @brief  获取分组时间
 
 @return 新的NSDate对象
 */
- (NSDate *)groupDate;
/* 根据时间戳计算年 月 日*/
+ (NSString *)getYMDByInterval:(NSTimeInterval)interval;

@end
