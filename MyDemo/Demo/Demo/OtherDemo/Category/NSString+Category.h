//
//  NSString+Category.h
//  emoji
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)

+ (instancetype)stringToUTF16:(NSString *)string;
+ (instancetype)stringToUTF8:(NSString *)string;
+ (instancetype)stringToUnicode:(NSString *)string;

@end

#pragma mark - removeEmoji
@interface NSString (RemoveEmoji)

// 判断字符串中是否含有Emoji表情
- (BOOL)isIncludeEmoji;
// 移除字符串中的Emoji表情，不改变原字符串，返回移除后的字符串
- (instancetype)stringRemoveEmoji;

@end
