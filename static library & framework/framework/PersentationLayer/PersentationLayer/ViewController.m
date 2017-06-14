//
//  ViewController.m
//  PersentationLayer
//
//  Created by 朱超鹏 on 2017/6/13.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "ViewController.h"
#import <PersistenceLayer.framework/Headers/Note.h>
#import <PersistenceLayer.framework/Headers/NoteDAO.h>
#import <BusinessLogicLayer.framework/Headers/NoteBL.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    Note *note = [Note new];
    NoteDAO *dao = [NoteDAO sharedManager];
    NoteBL *bl = [NoteBL new];
    
    
    note.content = @"abc";
    NSLog(@"%i", [dao create:note]);
    NSLog(@"%@", [bl createNote:note]);
}

@end
