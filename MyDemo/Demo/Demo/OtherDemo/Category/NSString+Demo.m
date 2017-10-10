//
//  NSString+Category.m
//  emoji
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "NSString+Demo.h"

// UTF16 -> Unicode (必须大于0x10000)
#define UTF16_TO_UNICODE(x, y) (((((x) ^ 0xD800) << 10) | ((y) ^ 0xDC00)) + 0x10000)
#define UnicodeToUTF16(x) (((((x - 0x10000) >>10) | 0xD800) << 16)  | (((x-0x10000)&0x3FF) | 0xDC00))

/**
 *  C字符串由char字符组成，NSString由unichar字符组成
 */

@implementation NSString (Demo)

// 1.unicode —> utf-8
// 2.unicode -> utf-16
// 3.unicode -> NSString
// 4.NSString ->unicode

+ (instancetype)stringToUTF16:(NSString *)string {
    NSString *str_UTF16 = @"";
    for (int i = 0; i < string.length; i++) {
        unichar uc = [string characterAtIndex:i];
        str_UTF16 = [str_UTF16 stringByAppendingString:[NSString stringWithFormat:@"0x%1X ", uc]];
    }
    return str_UTF16;
}
+ (instancetype)stringToUTF8:(NSString *)string {
    NSString *str_UTF8 = @"";
    for (int i = 0; i < strlen([string UTF8String]); i++) {
        char c = [string UTF8String][i];
        // ffffffff0 去除前面六个F，只保留最后两位，& 0xFF
        str_UTF8 = [str_UTF8 stringByAppendingString:[NSString stringWithFormat:@"0x%X ", c & 0xFF]];
    }
    return str_UTF8;
}
+ (instancetype)stringToUnicode:(NSString *)string {
    NSString *str_Unicode = @"";
    
    // 😊：该类表情length为2，🇨🇳：该类表情length为4
    if ([string length] >= 2) {
        for (int i = 0; i < [string length] / 2 && ([string length] % 2 == 0) ; i++)
        {
            // three bytes
            if (([string characterAtIndex:i*2] & 0xFF00) == 0 ) {
                str_Unicode = [str_Unicode stringByAppendingFormat:@"Ox%1X 0x%1X",[string characterAtIndex:i*2],[string characterAtIndex:i*2+1]];
            }
            else
            {// four bytes
                str_Unicode = [str_Unicode stringByAppendingFormat:@"U+%1X ",UTF16_TO_UNICODE([string characterAtIndex:i*2],[string characterAtIndex:i*2+1])];
            }
            
        }
    } else {
        str_Unicode = [str_Unicode stringByAppendingString:[NSString stringWithFormat:@"U+%1X", [string characterAtIndex:0]]];
    }
    return str_Unicode;
}

@end


#pragma mark - Remove Emoji
@implementation NSString (RemoveEmoji)

// 判断字符串中是否含有Emoji表情
- (BOOL)isIncludeEmoji {
    BOOL __block result = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              if ([substring isEmoji]) {
                                  *stop = YES;
                                  result = YES;
                              }
                          }];
    return result;
}
// 移除字符串中的Emoji表情
- (instancetype)stringRemoveEmoji {
    NSMutableString* __block buffer = [NSMutableString stringWithCapacity:[self length]];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              [buffer appendString:([substring isEmoji])? @"": substring];
                          }];
    
    return buffer;
}

// 判断字符是否是Emoji
- (BOOL)isEmoji {
    
    NSCharacterSet *variationSelectors = [NSCharacterSet characterSetWithRange:NSMakeRange(0xFE00, 16)];
    if ([self rangeOfCharacterFromSet:variationSelectors].location != NSNotFound) {
        return YES;
    }
    
    const unichar high = [self characterAtIndex: 0];
    
    // Surrogate pair (U+1D000-1F9FF)
    if (0xD800 <= high && high <= 0xDBFF) {
        const unichar low = [self characterAtIndex: 1];
        const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
        
        return (0x1D000 <= codepoint && codepoint <= 0x1F9FF);
        
        // Not surrogate pair (U+2100-27BF)
    } else {
        return (0x2100 <= high && high <= 0x27BF);
    }
}

@end
