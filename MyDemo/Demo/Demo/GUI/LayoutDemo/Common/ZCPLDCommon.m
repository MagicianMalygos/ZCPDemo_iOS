//
//  ZCPLDCommon.m
//  Demo
//
//  Created by zcp on 2019/5/14.
//  Copyright © 2019 zcp. All rights reserved.
//

#import "ZCPLDCommon.h"

@implementation ZCPLDCommon

static NSArray *_textTemplates;

+ (NSArray *)textTemplates {
    if (!_textTemplates) {
        _textTemplates = @[@"", @"1",
                           @"12", @"123",
                           @"1234", @"12345",
                           @"123456", @"1234567",
                           @"12345678", @"123456789",
                           @"123456789a", @"123456789ab",
                           @"123456789abc", @"123456789abcd",
                           @"123456789abcde", @"123456789abcdef",
                           @"123456789abcdefg", @"123456789abcdefgh",
                           @"123456789abcdefghi", @"123456789abcdefghij",
                           @"123456789abcdefghijk", @"123456789abcdefghijkl",
                           @"123456789abcdefghijklm", @"123456789abcdefghijklmn",
                           @"123456789abcdefghijklmno", @"123456789abcdefghijklmnop",
                           @"123456789abcdefghijklmnopq", @"123456789abcdefghijklmnopqr",
                           @"123456789abcdefghijklmnopqrs", @"123456789abcdefghijklmnopqrst",
                           @"123456789abcdefghijklmnopqrstu", @"123456789abcdefghijklmnopqrstuv",
                           @"123456789abcdefghijklmnopqrstuvw", @"123456789abcdefghijklmnopqrstuvwx",
                           @"123456789abcdefghijklmnopqrstuvwxy", @"123456789abcdefghijklmnopqrstuvwxyz",
                           @"123456789abcdefghijklmnopqrstuvwxyz一",
                           @"123456789abcdefghijklmnopqrstuvwxyz一二",
                           @"123456789abcdefghijklmnopqrstuvwxyz一二三",
                           @"123456789abcdefghijklmnopqrstuvwxyz一二三四",
                           @"123456789abcdefghijklmnopqrstuvwxyz一二三四五",
                           @"123456789abcdefghijklmnopqrstuvwxyz一二三四五六",
                           @"123456789abcdefghijklmnopqrstuvwxyz一二三四五六七",
                           @"123456789abcdefghijklmnopqrstuvwxyz一二三四五六七八",
                           @"123456789abcdefghijklmnopqrstuvwxyz一二三四五六七八九",
                           @"123456789abcdefghijklmnopqrstuvwxyz一二三四五六七八九十"];
    }
    return _textTemplates;
}

@end
