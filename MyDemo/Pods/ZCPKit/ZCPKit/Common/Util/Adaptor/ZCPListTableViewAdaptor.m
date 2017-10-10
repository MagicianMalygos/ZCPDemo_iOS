//
//  ZCPListTableViewAdaptor.m
//  ZCPKit
//
//  Created by zhuchaopeng on 16/9/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPListTableViewAdaptor.h"
#import "ZCPTableViewCell.h"

@implementation ZCPListTableViewAdaptor

// ----------------------------------------------------------------------
#pragma mark - private method
// ----------------------------------------------------------------------

#pragma mark 使用cell数据模型item生成cell
- (ZCPTableViewCell *)generateCellForObject:(id<ZCPTableViewCellItemBasicProtocol>)object indexPath:(NSIndexPath *)indexPath identifier:(NSString *)identifier {
    ZCPTableViewCell * cell     = nil;
    
    if (object) {
        Class   cellClass       = [self cellClassForObject:object];
        
        if (object.useNib == YES) {
            UINib *nib = [UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil];
            cell = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
        } else {
            cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
    }
    return cell;
}

#pragma mark cell高度
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat rowHeight       = 0;
    
    UITableView * tableView = self.tableView;
    id object               = [self objectForRowAtIndexPath:indexPath];
    
    Class cellClass         = [self cellClassForIndexPath:indexPath];
    rowHeight               = [cellClass tableView:tableView rowHeightForObject:object];
    
    return rowHeight;
}

#pragma mark tableview的section个数
- (int)numberOfSections {
    return 1;
}

#pragma mark tableview的cell个数
- (NSInteger)numberOfRows {
    return self.items.count;
}

#pragma mark 通过item获取cell的Class
- (Class)cellClassForObject:(id<ZCPTableViewCellItemBasicProtocol>)object {
    Class cellClass = nil;
    
    if (object && [object respondsToSelector:@selector(cellClass)]) {
        cellClass = [object cellClass];
    }
    
    return cellClass;
}

#pragma mark 通过indexPath获取cell的Class
- (Class)cellClassForIndexPath:(NSIndexPath *)indexPath {
    Class cellClass                                 = nil;
    id<ZCPTableViewCellItemBasicProtocol> object    = [self objectForRowAtIndexPath:indexPath];
    
    cellClass                                       = [self cellClassForObject:object];
    
    return cellClass;
}
#pragma mark 通过indexpath获取item
- (id<ZCPTableViewCellItemBasicProtocol>)objectForRowAtIndexPath:(NSIndexPath *)indexPath {
    id object           = nil;
    
    if (self.items.count > indexPath.row) {
        object          = [self.items objectAtIndex:indexPath.row];
    }
    
    return object;
}

#pragma mark 通过indexPath获取cell的celltype
- (NSString *)cellTypeAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellType     = nil;
    
    id<ZCPTableViewCellItemBasicProtocol> object = [self objectForRowAtIndexPath:indexPath];
    if (object) {
        cellType            = [object cellType];
    }
    return cellType;
}

#pragma mark 通过indexPath获取cell的identifier
- (NSString *)identifierForCellAtIndexPath:(NSIndexPath *)indexPath {
    NSString * identifier       = nil;
    identifier                  = [self cellTypeAtIndexPath:indexPath];
    return identifier;
}

#pragma mark 通过celltype获取cell点击响应方法SEL
- (SEL)actionForCellType:(NSString *)cellType {
    SEL action      = nil;
    
    if ([self.cellActionDictionary objectForKey:cellType] && [[self.cellActionDictionary objectForKey:cellType] isKindOfClass:[NSValue class]]) {
        action  = [[self.cellActionDictionary objectForKey:cellType] pointerValue];
    }
    
    return action;
}

#pragma mark 通过indexPath获取cell点击响应方法SEL
- (SEL)actionForCellAtIndexPath:(NSIndexPath *)indexPath {
    SEL action          = nil;
    
    NSString * cellType = [self cellTypeAtIndexPath:indexPath];
    action              = [self actionForCellType:cellType];
    
    return action;
}

#pragma mark 通过celltype获取cell点击响应方法的执行者target
- (id)targetForCellType:(NSString *)cellType{
    id target           = nil;
    
    if ([self.cellTargetDictionary objectForKey:cellType]) {
        target          = [self.cellTargetDictionary objectForKey:cellType];
    }
    
    return target;
}

#pragma mark 通过indexPath获取cell点击响应方法的执行者target
- (id)targetForCellAtIndexPath:(NSIndexPath *)indexPath {
    id  target             = nil;
    
    NSString * cellType    = [self cellTypeAtIndexPath:indexPath];
    target                 = [self targetForCellType:cellType];
    
    return target;
}

// ----------------------------------------------------------------------
#pragma mark - UITableViewDataSource
// ----------------------------------------------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self numberOfRows];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self numberOfSections];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<ZCPTableViewCellItemBasicProtocol> object = [self objectForRowAtIndexPath:indexPath];
    
    NSString * identifier  = [self identifierForCellAtIndexPath:indexPath];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        //初始化cell
        cell = [self generateCellForObject:object indexPath:indexPath identifier:identifier];
    }
    
    if (!cell) {
        NSLog(@"Catch up a bug!!! row: %tu", indexPath.row);
    }
    
    //更新数据
    if ([cell isKindOfClass:[ZCPTableViewCell class]]) {
        [(ZCPTableViewCell *)cell setObject:(ZCPCellDataModel *)object];
    }
    
    if ([self.delegate respondsToSelector:@selector(tableView:didSetObject:cell:)]) {
        [self.delegate tableView:tableView didSetObject:object cell:cell];
    }
    
    return cell;
}

// ----------------------------------------------------------------------
#pragma mark - UITableViewDelegate
// ----------------------------------------------------------------------

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height      = 0;
    
    if (self.tableView == nil) {
        self.tableView  = tableView;
    }
    height = [self heightForRowAtIndexPath:indexPath];
    
    return height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id<ZCPTableViewCellItemBasicProtocol> object = [self objectForRowAtIndexPath:indexPath];
    SEL action          = [self actionForCellAtIndexPath:indexPath];
    id target           = [self targetForCellAtIndexPath:indexPath];
    if (action && target) {
        if ([target respondsToSelector:action]) {
            SuppressPerformSelectorLeakWarning({
                [target performSelector:action withObject:object withObject:indexPath];
            });
        }
    } else if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(tableView:didSelectObject:rowAtIndexPath:)]) {
            [self.delegate tableView:tableView didSelectObject:object rowAtIndexPath:indexPath];
        }
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)]) {
        return [self.delegate tableView:self.tableView canEditRowAtIndexPath:indexPath];
    }
    return NO;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView editingStyleForRowAtIndexPath:indexPath];
    }
    return UITableViewCellEditingStyleNone;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
        [self.delegate tableView:self.tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:)]) {
        return [self.delegate tableView:self.tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    }
    return @"Delete";
}

// ----------------------------------------------------------------------
#pragma mark - setter / getter
// ----------------------------------------------------------------------

- (NSMutableArray *)items {
    if (_items == nil) {
        self.items = [NSMutableArray array];
    }
    return _items;
}

- (NSMutableDictionary *)cellActionDictionary {
    if (_cellActionDictionary == nil) {
        _cellActionDictionary   = [NSMutableDictionary dictionary];
    }
    return _cellActionDictionary;
}

- (NSMutableDictionary *)cellTargetDictionary {
    if (_cellTargetDictionary == nil) {
        self.cellTargetDictionary   = [NSMutableDictionary dictionary];
    }
    return _cellTargetDictionary;
}

@end
