//
//  ClassA+Category.m
//  AccessOCPrivateMethod
//
//  Created by apple on 15/12/1.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ClassA+Category.h"

@implementation ClassA (Category)

- (void)categoryPublicMethod {
    NSLog(@"categoryPublicMethod");
}
- (void)categoryPrivateMethod {
    NSLog(@"categoryPrivateMethod");
}

@end
