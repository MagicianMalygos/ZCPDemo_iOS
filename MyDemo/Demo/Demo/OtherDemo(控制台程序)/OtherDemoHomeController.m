//
//  OtherDemoHomeController.m
//  Demo
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "OtherDemoHomeController.h"
#import <objc/runtime.h>

@implementation OtherDemoHomeController

@synthesize infoArr = _infoArr;

- (NSMutableArray *)infoArr {
    if (_infoArr == nil) {
        _infoArr = [NSMutableArray arrayWithObjects:
                    @{@"title":@"MacroDemo", @"class":@"MacroDemo"}
                    , @{@"title":@"RuntimeDemo", @"class":@"RuntimeDemo"}
                    , @{@"title":@"EnumAndFormatDemo", @"class":@"EnumAndFormatDemo"}
                    , @{@"title":@"OCClassMethodDemo", @"class":@"OCClassMethodDemo"}
                    , @{@"title":@"AlgorithmDemo", @"class":@"AlgorithmDemo"}
                    , nil];
    }
    return _infoArr;
}

- (void)didSelectCell:(NSIndexPath *)indexPath {
    Class class = NSClassFromString([[self.infoArr objectAtIndex:indexPath.row] valueForKey:@"class"]);
    NSObject *object = [class new];
    if (class && object) {
        [object performSelector:@selector(run)];
    }
}

@end

