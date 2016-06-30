//
//  MyBasicDataConstructor.m
//  JumpToVC
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MyBasicDataConstructor.h"

@implementation MyBasicDataConstructor

#pragma mark - synthesize
@synthesize items = _items;


#pragma mark - generate data
- (void)constructData {
}

#pragma mark - setter / setter
- (NSMutableArray *)items {
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}


@end
