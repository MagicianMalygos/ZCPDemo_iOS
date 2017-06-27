//
//  MyAnnotation.m
//  Demo
//
//  Created by 朱超鹏 on 2017/6/23.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    _coordinate = newCoordinate;
}

@end
