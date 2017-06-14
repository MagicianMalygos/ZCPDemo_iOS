//
//  NoteBL.h
//  BusinessLogicLayer
//
//  Created by 朱超鹏 on 2017/6/13.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Note;

@interface NoteBL : NSObject

- (NSMutableArray *)createNote:(Note *)model;
- (NSMutableArray *)remove:(Note *)model;
- (NSMutableArray *)findAll;

@end
