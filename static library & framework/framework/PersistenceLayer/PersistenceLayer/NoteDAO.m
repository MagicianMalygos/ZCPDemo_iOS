//
//  NoteDAO.m
//  PersistenceLayer
//
//  Created by 朱超鹏 on 2017/6/13.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "NoteDAO.h"
#import "Note.h"

@implementation NoteDAO

+ (instancetype)sharedManager {
    static NoteDAO *dao;
    
    if (!dao) {
        dao = [[NoteDAO alloc] init];
    }
    
    return dao;
}
- (int)create:(Note *)model {
    return 0;
}
- (int)remove:(Note *)model {
    return 1;
}
- (int)modify:(Note *)model {
    return 2;
}
- (NSMutableArray *)findAll {
    Note *note = [Note new];
    note.date = [NSDate date];
    note.content = @"Hello World！";
    return @[note].mutableCopy;
}

- (Note *)findByID:(Note *)model {
    Note *note = [Note new];
    note.date = [NSDate date];
    note.content = @"Hello World！";
    return note;
}

@end
