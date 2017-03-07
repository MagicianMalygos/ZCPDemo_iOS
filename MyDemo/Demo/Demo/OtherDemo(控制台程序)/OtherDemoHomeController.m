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
                    @{@"title":@"MacroDemo", @"class":@"MacroDemo"},
                    @{@"title":@"RuntimeDemo", @"class":@"RuntimeDemo"},
                    @{@"title":@"RuntimeExampleDemo", @"class":@"RuntimeExampleDemo"},
                    @{@"title":@"EnumAndFormatDemo", @"class":@"EnumAndFormatDemo"},
                    @{@"title":@"OCClassPropertyDemo", @"class":@"OCClassPropertyDemo"},
                    @{@"title":@"OCClassMethodDemo", @"class":@"OCClassMethodDemo"},
                    @{@"title":@"AlgorithmDemo", @"class":@"AlgorithmDemo"},
                    @{@"title": @"RegexDemo", @"class": @"RegexDemo"}, nil];
    }
    return _infoArr;
}

- (void)didSelectCell:(NSIndexPath *)indexPath {
    NSString *classString = [[self.infoArr objectAtIndex:indexPath.row] valueForKey:@"class"];
    Class class = NSClassFromString(classString);
    if ([classString isEqualToString:@"RuntimeExampleDemo"]) {
        UIViewController *vc = [class new];
        if (class && vc) {
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else {
        NSObject *object = [class new];
        if (class && object) {
            [object performSelector:@selector(run)];
        }
    }
}

@end

