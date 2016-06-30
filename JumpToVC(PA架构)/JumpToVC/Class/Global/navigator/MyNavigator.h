//
//  MyNavigator.h
//  JumpToVC
//
//  Created by apple on 15/12/4.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MyBaseNavigator.h"

@interface MyNavigator : MyBaseNavigator


DEF_SINGLETON(MyNavigator)


#pragma mark - jump
- (void)gotoViewWithIdentifier:(NSString *)identifier paramDictForInit:(NSDictionary *)paramDictForInit;

@end
