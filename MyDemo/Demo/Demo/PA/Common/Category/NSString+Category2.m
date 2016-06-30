//
//  NSString+Category.m
//  haofang
//
//  Created by Aim on 14-3-19.
//  Copyright (c) 2014年 平安好房. All rights reserved.
//

#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (Category2)

/* NSDate转换为日期字符串 */
+ (NSString *)stringFromDate:(NSDate *)date {
    return [self stringFromDate:date withDateFormat:@"yyyy-MM-dd"];
}
+ (NSString *)stringFromYDMHmsDate:(NSDate *)date {
    return [self stringFromDate:date withDateFormat:@"yyyy-MM-dd HH-mm-ss"];
}
+ (NSString *)stringFromDate:(NSDate *)date withDateFormat:(NSString *)format{
    NSDateFormatter *formatter = [NSDateFormatter staticDateFormatter];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}
/* 当前字符串转为NSDate */
- (NSDate *)toDate {
    return [NSDate dateFromString:self withDateFormat:@"yyyy-MM-dd HH-mm-ss"];
}




- (NSString *)maskedPhoneNumber {
    NSUInteger length = [self length];
    NSString *masks = @"****";
    
    if (length > 3 && length <= 7) {
        NSString *first = [self substringWithRange:NSMakeRange(0, 3)];
        return [[NSString stringWithFormat:@"%@%@", first, masks] substringWithRange:NSMakeRange(0, length)];
    }
    else if (length > 7){
        return [self stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:masks];
    }
    
    // 长度小于3时，直接返回
    return self;
}

-(NSString *) utf8ToUnicode{
    NSUInteger length = [self length];
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    for (int i = 0;i < length; i++){
        unichar _char = [self characterAtIndex:i];
        //判断是否为中文
        if(_char >= 913 && _char <= 65509){
            [s appendFormat:@"\\u%x",[self characterAtIndex:i]];
        }else{
            [s appendFormat:@"%@",[self substringWithRange:NSMakeRange(i, 1)]];
        }
    }
    return s;
    
}


NSString *fixIconString(NSString *iconString) {
    if (![iconString hasPrefix:@"0x"]) {
        iconString = [NSString stringWithFormat:@"0x%@", iconString];
    }
    
    unsigned int iconValue;
    NSScanner* scanner = [NSScanner scannerWithString:iconString];
    [scanner scanHexInt:&iconValue];
    return [[NSString alloc] initWithBytes:&iconValue length:4 encoding:NSUTF32LittleEndianStringEncoding];
}

//中英文长度，按字节来算
- (NSInteger)getValidLenth{
    if (self.trim.length==0) {
        return 0;
    }
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* da = [self dataUsingEncoding:enc];
    return [da length];
}

/**
 * 计算字符串的md5值
 *
 **/
- (NSString *)md5 {
	if(self == nil || [self length] == 0){
		return nil;
	}

	const char *src = [self UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];

	CC_MD5(src, (CC_LONG)strlen(src), result);

	return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
		result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
		result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
	];
}

/**
 * 去掉字符串两端的空白字符
 *
 **/
- (NSString *) trim {
	if(nil == self){
		return nil;
	}

	NSMutableString *re = [NSMutableString stringWithString:self];
	CFStringTrimWhitespace((CFMutableStringRef)re);
	return (NSString *)re;
}

/**
 * 对字符串URLencode编码
 **/
// FIX: error method
- (NSString *)urlEncoding {
	NSString *result = (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge CFStringRef)self,NULL,(CFStringRef)@"!#[]'*;/?:@&=$+{}<>,",kCFStringEncodingUTF8);
	return result;
}


/**
 * 对字符串URLdecode解码
 **/
- (NSString *)urlDecoding {
    NSString* result = [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	return result;
}

/**
 * 判断一个字符串是否全由字母组成
 *
 * @return NSString
 **/
- (BOOL)is_letters {
	NSString *regPattern = @"[a-zA-Z]+";
	NSPredicate *testResult = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regPattern];
	return [testResult evaluateWithObject:self];
}

/* 判断一个字符串是否全由数字组成 */
- (BOOL)is_numbers {
    NSString *regPattern = @"[0-9]+";
    NSPredicate *testResult = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regPattern];
    return [testResult evaluateWithObject:self];
}

/* 判断一个字符串是否是url */
- (BOOL)is_url {
    NSString *regex = @"^http://.+";
    NSPredicate *testResult = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [testResult evaluateWithObject:self];
}

-(NSString *)findNumStringIndexFromString
{
    // Intermediate
    NSMutableString *numberString = [[NSMutableString alloc] init];
    NSString *tempStr;
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    while (![scanner isAtEnd]) {
        // Throw away characters before the first number.
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        
        // Collect numbers.
        [scanner scanCharactersFromSet:numbers intoString:&tempStr];
        [numberString appendString:tempStr];
        tempStr = @"";
    }
    // Result.
    return numberString;
}

/**
 * 创建一个唯一的UDID
 *
 * @return NSString
 **/
+ (NSString *)createUDID {
	CFUUIDRef udid = CFUUIDCreate(nil);
	NSString *strUDID = (__bridge_transfer NSString *)CFUUIDCreateString(nil, udid);
	CFRelease(udid);
	return strUDID;
}

/**
 * 从UIColor对象生成一个字符串
 *
 * @return NSString
 **/
+ (NSString *)fromColor:(UIColor *)color {
	if (nil == color) {
		return nil;
	}

	CGColorRef c = color.CGColor;
	const CGFloat *components = CGColorGetComponents(c);
	size_t numberOfComponents = CGColorGetNumberOfComponents(c);
	NSMutableString *str = [NSMutableString stringWithCapacity:0];
    unsigned int hexC=0;

	[str appendString:@"#"];

    if (numberOfComponents != 2 && numberOfComponents != 4) {
        return nil;
    }

    for (size_t i = 0; i < numberOfComponents - 1; ++i) {
        hexC = (unsigned int)floor(255.0f * components[i]);
        [str appendString:[NSString stringWithFormat:@"%02x", hexC & 255]];
    }

    if (numberOfComponents == 2) {
        size_t padNum = 4 - numberOfComponents;

        for (size_t i = 0; i < padNum; ++i) {
            [str appendString:[NSString stringWithFormat:@"%02x", hexC & 255]];
        }
    }

    hexC = (unsigned int)floor(255.0f * components[numberOfComponents - 1]);
    hexC = (255 - hexC) & 255;

    if (hexC != 0) {
        [str appendString:[NSString stringWithFormat:@"%02x", hexC]];
    }

	return str;
}

/**
 * 从字符串生成一个UIColor对象
 *
 * @return UIColor
 **/
- (UIColor *)toColor {
	return [self toColorWithDefaultColor:[UIColor blackColor]];
}

/**
 * 从字符串生成一个UIColor对象，并指定一个默认颜色
 *
 * @return UIColor
 **/
- (UIColor *)toColorWithDefaultColor:(UIColor *)defaultColor {
	NSString *str = [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];

    if ([str contains:@"grouptableviewbackgroundcolor"]) {
        return [UIColor groupTableViewBackgroundColor];
    } else if ([str contains:@"black"]) {
        return [UIColor blackColor];
    } else if ([str contains:@"darkgray"]) {
        return [UIColor darkGrayColor];
    } else if ([str contains:@"lightgray"]) {
        return [UIColor lightGrayColor];
    } else if ([str contains:@"white"]) {
        return [UIColor whiteColor];
    } else if ([str contains:@"gray"]) {
        return [UIColor grayColor];
    } else if ([str contains:@"red"]) {
        return [UIColor redColor];
    } else if ([str contains:@"green"]) {
        return [UIColor greenColor];
    } else if ([str contains:@"blue"]) {
        return [UIColor blueColor];
    } else if ([str contains:@"cyan"]) {
        return [UIColor cyanColor];
    } else if ([str contains:@"yellow"]) {
        return [UIColor yellowColor];
    } else if ([str contains:@"magenta"]) {
        return [UIColor magentaColor];
    } else if ([str contains:@"orange"]) {
        return [UIColor orangeColor];
    } else if ([str contains:@"purple"]) {
        return [UIColor purpleColor];
    } else if ([str contains:@"brown"]) {
        return [UIColor brownColor];
    } else if ([str contains:@"clear"]) {
        return [UIColor clearColor];
    }

	if ([str hasPrefix:@"0x"]){
		str = [str substringFromIndex:2];
	} else if ([str hasPrefix:@"#"]){
		str = [str substringFromIndex:1];
	}

	if ([str length] != 6 && [str length] != 3 && [str length] != 8 && [str length] != 4){
		return defaultColor;
	}

	NSRange range;
	unsigned int r, g, b, a;

	if ([str length] == 3 || [str length] == 4) {
		range.length = 1;
	} else {
		range.length = 2;
	}

	range.location = 0 * range.length;
	if(![[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&r]){
		return defaultColor;
	}

	range.location = 1 * range.length;
	if(![[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&g]){
		return defaultColor;
	}

	range.location = 2 * range.length;
	if(![[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&b]){
		return defaultColor;
	}

	if ([str length] == 4 || [str length] == 8) {
		range.location = 3 * range.length;

		if(![[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&a]){
			return defaultColor;
		}
	} else {
		a = 0;
	}

	if ([str length] == 3 || [str length] == 4) {
        r = (r<<4|r);
        g = (g<<4|r);
        b = (b<<4|r);
        a = (a<<4|r);
    }

	return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:(255.0f - a) / 255.0f];
}

/**
 * 忽略大小写比较两个字符串
 *
 * @return BOOL
 **/
- (BOOL)equalsIgnoreCase:(NSString *)str {
	if (nil == str) {
		return NO;
	}

	return [[str lowercaseString] isEqualToString:[self lowercaseString]];
}

/* 是否包含特定字符串 */
- (BOOL)contains:(NSString *)str {
	if (nil == str || [str length] < 1) {
		return NO;
	}

	return [self rangeOfString:str].location != NSNotFound;
}

/* 把HTML转换为TEXT文本 */
- (NSString *)html2text {
	NSString *str = [NSString stringWithString:self];

	str = [str stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
	str = [str stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\n"];
	str = [str stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
	str = [str stringByReplacingOccurrencesOfString:@"<BR>" withString:@"\n"];
	str = [str stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
	str = [str stringByReplacingOccurrencesOfString:@"<BR />" withString:@"\n"];
	str = [str stringByReplacingOccurrencesOfString:@"<b>" withString:@" "];
	str = [str stringByReplacingOccurrencesOfString:@"<B>" withString:@" "];
	str = [str stringByReplacingOccurrencesOfString:@"</b>" withString:@" "];
	str = [str stringByReplacingOccurrencesOfString:@"</B>" withString:@" "];

	return str;
}

/* 移除一些HTML标签 */
- (NSString *)striptags {
	NSString *str = [NSString stringWithString:self];

	str = [str stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
	str = [str stringByReplacingOccurrencesOfString:@"\r\n" withString:@" "];
	str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
	str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@" "];
	str = [str stringByReplacingOccurrencesOfString:@"<br>" withString:@" "];
	str = [str stringByReplacingOccurrencesOfString:@"<BR>" withString:@" "];
	str = [str stringByReplacingOccurrencesOfString:@"<br />" withString:@" "];
	str = [str stringByReplacingOccurrencesOfString:@"<BR />" withString:@" "];
	str = [str stringByReplacingOccurrencesOfString:@"  " withString:@" "];
	str = [str stringByReplacingOccurrencesOfString:@"  " withString:@" "];
	str = [str stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];

	return str;
}

/* 格式化文本 */
- (NSString *)textindent {
	NSString *str = [self stringByReplacingOccurrencesOfString:@"\n" withString:@"\n    "];
	str = [NSString stringWithFormat:@"    %@", str];
	return str;
}

/* 获取文本大小 add by yuki */
- (NSString *)NumberSize2StringSize:(NSInteger)numberSize {
    if (numberSize < 1024.0f) {
		return [NSString stringWithFormat:@"%zd Bytes", numberSize];
	}else if (numberSize < 1024.0f * 1024.0f) {
		return [NSString stringWithFormat:@"%0.2f KB", (CGFloat)numberSize / 1024.0f];
	}else if (numberSize < 1024.0f * 1024.0f * 1024.0f) {
		return [NSString stringWithFormat:@"%0.2f MB", (CGFloat)numberSize / (1024.0f * 1024.0f)];
	}
    
	return [NSString stringWithFormat:@"%0.2f GB", (CGFloat)numberSize / (1024.0f * 1024.0f * 1024.0f)];
}

//字符串是不是一个纯整数型
- (BOOL)isPureInt{
    NSScanner* scan = [NSScanner scannerWithString:self]; 
    int val; 
    return[scan scanInt:&val] && [scan isAtEnd];
}

/* 获取 UTF8 编码的 NSData 值 */
- (NSData *)toUtf8Data {
    if ([self length] < 1) {
        return [NSData data];
    }

    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

//获取url里面的参数
- (NSDictionary *)getURLParams{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    NSRange range1  = [self rangeOfString:@"?"];
    NSRange range2  = [self rangeOfString:@"#"];
    NSRange range   ;
    if (range1.location != NSNotFound) {
        range = NSMakeRange(range1.location, range1.length);
    }else if (range2.location != NSNotFound){
        range = NSMakeRange(range2.location, range2.length);
    }else{
        range = NSMakeRange(-1, 1);
    }
    
    if (range.location != NSNotFound) {
        NSString * paramString = [self substringFromIndex:range.location+1];
        NSArray * paramCouples = [paramString componentsSeparatedByString:@"&"];
        for (int i = 0; i < [paramCouples count]; i++) {
            NSArray * param = [[paramCouples objectAtIndex:i] componentsSeparatedByString:@"="];
            if ([param count] == 2) {
                [dic setObject:[[param objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:[[param objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            }
        }
        return dic;
    }
    return nil;
}

// 获取Url里的隐藏域参数
- (NSString *)getHiddenInput{
    
    NSDictionary *params = [self getURLParams];
    
    NSMutableString *hiddenInput        = [NSMutableString new];
    for (NSString *key in [params allKeys]) {
        if ([key hasPrefix:@"hiddenInput_"]) {
            [hiddenInput appendFormat:@"&%@=%@", key, [params objectForKey:key]];
        }
    }
    
    if ([hiddenInput length] > 0) {
        return [hiddenInput substringFromIndex:1];
    }
    
    return nil;
}

// 对字符串添加url参数
- (NSString *)stringByAddingURLParams:(NSDictionary *)params{
    NSString * string           = self;
    
    if (params) {
        NSMutableArray * pairArray  = [NSMutableArray array];
        
        for (NSString * key in params) {
            NSString * value        = [[params objectForKey:key] stringValue];
            NSString * keyEscaped   = [key urlEncoding];
            NSString * valueEscaped = [value urlEncoding];
            NSString * pair         = [NSString stringWithFormat:@"%@=%@",keyEscaped,valueEscaped];
            [pairArray addObject:pair];
        }
        
        NSString * query            = [pairArray componentsJoinedByString:@"&"];
        string                      = [NSString stringWithFormat:@"%@?%@",self,query];
    }
    
    return string;
}


// 根据正则表达式截取字符串
- (NSArray *)getMatchesForRegex:(NSString *)regex{
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:1];
    
    NSError * error;
    NSRegularExpression * expression = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray * matches                = [expression matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    for (int i = 0; i < matches.count; i++) {
        NSTextCheckingResult * result = [matches objectAtIndex:i];
        
        for (int j = 0; j < result.numberOfRanges; j++) {
            NSRange range = [result rangeAtIndex:j];
            if (range.location == NSNotFound) {
                continue;
            }
            NSString * string = [self substringWithRange:range];
            [array addObject:string];
        }
    }
    
    return array;
}


// 将字符串中与正则表达式匹配的字符串替换成指定的字符串
- (NSString *)stringByReplaceRegex:(NSString *)regex withString:(NSString *)replace{
    NSError * error;
    NSRegularExpression * expression = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSString * string                = [expression stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:replace];
    
    return  string;
}

- (NSString *)substringByCutTail
{
    NSUInteger length = [self length];
    if (length > 1) {
        return [self substringToIndex:[self length] - 1];
    } else {
        return self;
    }
}

@end



@implementation NSString (PAPasswordAdditions)
//对密码进行加密
- (NSString *)passwdEncode {
    NSString *md5First =  [self md5];
    NSUInteger lenght = [md5First length];
    NSMutableString * reverse = [[NSMutableString alloc] initWithCapacity:lenght];
    for (NSInteger i = md5First.length-1; i >= 0; i--) {
        [reverse appendFormat:@"%c",[md5First characterAtIndex:i]];
    }
    [reverse appendString:@"paf"];
    NSString *md5Second = [reverse md5];
    return md5Second;
}

@end

#pragma mark - 金额格式化

@implementation NSString (Money)
- (NSString *)formateMoney{
    CGFloat fmoney = [self floatValue];
    if (fmoney<=0) {
        return @"";
    }// 211200120
    
    if (fmoney<99999) {
        return [NSMutableString stringWithFormat:@"%.2f",fmoney/100];
    }else{
        NSMutableString *formateString = [NSMutableString stringWithString:self];
        NSInteger totalLenth = [formateString length];
        NSInteger position = (totalLenth-2);
        [formateString insertString:@"." atIndex:position];

        while (position>3) {
            position -= 3;
            [formateString insertString:@"," atIndex:position];
        }
        return formateString;
    }
}

@end

@implementation NSString (VideoName)

+ (NSString *)createVideoName {
    NSString *fileName = [NSString stringWithFormat:@"ananzu_ios_%.0f.mp4", [[NSDate date] timeIntervalSince1970] * 1000];
    return fileName;
}

@end

