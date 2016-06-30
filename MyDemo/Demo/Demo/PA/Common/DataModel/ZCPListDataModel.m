//
//  ZCPListDataModel.m
//  Apartment
//
//  Created by apple on 16/2/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPListDataModel.h"

@implementation ZCPListDataModel

#pragma mark - synthesize
@synthesize items           = _items;
@synthesize page            = _page;
@synthesize rows            = _rows;
@synthesize hasMore         = _hasMore;
@synthesize start           = _start;
@synthesize max             = _max;
@synthesize totalRecords    = _totalRecords;

#pragma mark - Public Method
// 获取列表中对应下标的对象
- (id)objectAtIndex:(NSUInteger)index {
    if (index < [self.items count]) {
        return [self.items objectAtIndex:index];
    }
    return nil;
}

#pragma mark - getter / setter
- (NSMutableArray *)items {
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

@end
