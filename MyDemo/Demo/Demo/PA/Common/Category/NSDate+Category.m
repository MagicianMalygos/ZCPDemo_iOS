//
//  NSDate+Category.m
//  haofang
//
//  Created by Aim on 14-3-19.
//  Copyright (c) 2014年 平安好房. All rights reserved.
//

@implementation NSDate (Category)

/**
 *  日期字符串转换为 NSDate
 *
 *     输入的日期字符串形如：@"2010-05-21"
 */
+ (NSDate *)dateFromString:(NSString *)dateString {
    return [self dateFromString:dateString withDateFormat:@"yyyy-MM-dd"];
}
+ (NSDate *)dateFromYDMHmsString:(NSString *)dateString {
    return [self dateFromString:dateString withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
}
+ (NSDate *)dateFromString:(NSString *)dateString withDateFormat:(NSString *)format {
    NSDateFormatter *formatter = [NSDateFormatter staticDateFormatter];
    [formatter setDateFormat:format];
    return [formatter dateFromString:dateString];
}
/**
 *  当前NSDate转为字符串
 *
 *  输出的日期字符串形如：@"2010-05-21"
 */
- (NSString *)toString {
    return [NSString stringFromDate:self];
}





/* 获取yyyy/mm/dd 格式日期 */
+ (NSString *)getYMDByInterval:(NSTimeInterval)interval
{
    NSString *timeDes = @"";
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter* formatter = [NSDateFormatter staticDateFormatter];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    timeDes = [formatter stringFromDate:date];
    if (interval == 0) {
        timeDes = @"";
    }
    return timeDes;
}
/* 获取yyyy/mm/dd 格式日期 */
- (NSString *)getYMDShortString {
    NSDateFormatter *formatter = [NSDateFormatter staticDateFormatter];
    
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSString *retStr = [formatter stringFromDate:self];
    
    return retStr;
}

//获取月-天-时-分
+ (NSString *)getMDHM:(long)timestamps{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale systemLocale]];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    NSString *msgDate = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timestamps]];
    return msgDate;
}

/* 比较两个时间之间差距的绝对值 */
- (NSTimeInterval)absIntervalSinceDate:(NSDate *)date {
    return fabs([self timeIntervalSinceDate:date]);
}

/* 当前时间对象和现在时间差的绝对值 */
- (NSTimeInterval)absIntervalSinceNow {
    return fabs([self timeIntervalSinceNow]);
}

/* 根据时间戳计算天、小时、时、分 */
// 今天和昨天显示yyyy-MM-dd，两天以前显示yyyy-MM-dd HH:mm:ss
+ (NSString *)getTimeByInterval:(NSTimeInterval)interval{
    NSString *timeDes = @"";
    NSDate* now  = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter* formatter = [NSDateFormatter staticDateFormatter];
    
    NSTimeInterval timeBetween = [now timeIntervalSinceDate:date];
    if (timeBetween > 2 * 24 * 60 * 60) {
        [formatter setDateFormat:@"yyyy-MM-dd"];
        timeDes = [formatter stringFromDate:date];
    }else{
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        timeDes = [formatter stringFromDate:date];
    }
    
    if (interval == 0) {
        timeDes = @"";
    }
    
    return timeDes;
}

+ (NSString *)getTimeWithoutSecondByInterval:(NSTimeInterval)interval{
    NSString *timeDes = @"";
    NSDate* now  = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter* formatter = [NSDateFormatter staticDateFormatter];
    
    NSTimeInterval timeBetween = [now timeIntervalSinceDate:date];
    if (timeBetween > 2 * 24 * 60 * 60) {
        [formatter setDateFormat:@"yyyy-MM-dd"];
        timeDes = [formatter stringFromDate:date];
    }else{
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        timeDes = [formatter stringFromDate:date];
    }
    
    if (interval == 0) {
        timeDes = @"";
    }
    
    return timeDes;
}

+ (NSString *)getTimeStamp {
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSString *timeString = [NSString stringWithFormat:@"%ld", (long)[dat timeIntervalSince1970]];
    
    return timeString;
}

- (NSString *)getMDDateString{
    NSUInteger componentFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:componentFlags fromDate:self];
    
    NSString *months,*days;
    
    NSInteger month = [components month];
    NSInteger day = [components day];
    
    if (month<10) {
        months = [NSString stringWithFormat:@"0%zd",month];
    }else{
        months = [NSString stringWithFormat:@"%zd",month];
    }
    
    if (day<10) {
        days = [NSString stringWithFormat:@"0%zd",day];
    }else{
        days = [NSString stringWithFormat:@"%zd",day];
    }
    return [NSString stringWithFormat:@"%@-%@",months,days];
}


- (NSString *) an_friendlyDateString {
    NSString *friendlyString = @"";
    NSDate *now = [NSDate date];
    NSCalendar *systemCalendar = [NSCalendar currentCalendar];
    NSInteger currentYear = [systemCalendar components:NSCalendarUnitYear fromDate:now].year;
    
    NSDateComponents *selfComponents = [systemCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                                                         fromDate:self];
    
    friendlyString = [NSString stringWithFormat:@"%@月%@日", @(selfComponents.month), @(selfComponents.day)];
    if (currentYear != selfComponents.year) {
        friendlyString = [NSString stringWithFormat:@"%@年%@", @(selfComponents.year), friendlyString];
    }
    return friendlyString;
}

- (NSString *)getYMDString{
    
    NSUInteger componentFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:componentFlags fromDate:self];
    
    NSInteger year = [components year];
    
    NSInteger month = [components month];
    
    NSInteger day = [components day];
    
    return [NSString stringWithFormat:@"%zd年%zd月%zd日",year,month,day];
}


//生成年
- (NSString *)getYear
{
    NSUInteger componentFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:componentFlags fromDate:self];
    
    NSInteger year = [components year];
    return [NSString stringWithFormat:@"%lu", year];
}

//生成月
- (NSString *)getMonth
{
    NSUInteger componentFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:componentFlags fromDate:self];
    
    NSString *months;
    NSInteger month = [components month];
    
    if (month<10) {
        months = [NSString stringWithFormat:@"0%zd",month];
    }else{
        months = [NSString stringWithFormat:@"%zd",month];
    }
    return [NSString stringWithFormat:@"%@",months];
}

// 生成日
- (NSString *)getDay
{
    NSUInteger componentFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:componentFlags fromDate:self];
    NSString *days;
    NSInteger day = [components day];
    
    if (day<10) {
        days = [NSString stringWithFormat:@"0%zd",day];
    }else{
        days = [NSString stringWithFormat:@"%zd",day];
    }
    return [NSString stringWithFormat:@"%@",days];
}

- (NSString *)getDateStringYYYYMMddHHmmss {
    NSDateFormatter* formatter = [NSDateFormatter staticDateFormatter];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    return [formatter stringFromDate:self];
}

- (NSDate *)groupDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                                               fromDate:self];
    return [calendar dateFromComponents:components]; // 当天中午
}

@end
