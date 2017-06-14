//
//  ViewController.m
//  PresentationLayer
//
//  Created by 朱超鹏 on 2017/6/13.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "ViewController.h"
#import "Note.h"
#import "NoteDAO.h"
#import "NoteBL.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Note *note = [Note new];
    NoteDAO *dao = [NoteDAO sharedManager];
    NoteBL *bl = [NoteBL new];
    
    
    note.content = @"abc";
    NSLog(@"%i", [dao create:note]);
    NSLog(@"%@", [bl createNote:note]);
}

@end
