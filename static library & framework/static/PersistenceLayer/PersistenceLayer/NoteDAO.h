//
//  NoteDAO.h
//  PersistenceLayer
//
//  Created by 朱超鹏 on 2017/6/13.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Note;

@interface NoteDAO : NSObject

@property (nonatomic, strong) NSMutableArray *listData;

+ (instancetype)sharedManager;
- (int)create:(Note *)model;
- (int)remove:(Note *)model;
- (int)modify:(Note *)model;
- (NSMutableArray *)findAll;
- (Note *)findByID:(Note *)model;

@end
