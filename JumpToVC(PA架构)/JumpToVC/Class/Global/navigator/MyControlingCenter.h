//
//  MyControlingCenter.h
//  JumpToVC
//
//  Created by apple on 15/12/4.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyControlingCenter : NSObject

DEF_SINGLETON(MyControlingCenter)

- (UIViewController *)generateRootViewController;

@end
