//
//  ZCPLDStackViewController.m
//  Demo
//
//  Created by zcp on 2019/5/14.
//  Copyright © 2019 zcp. All rights reserved.
//

#import "ZCPLDStackViewController.h"
#import "ZCPLDCommon.h"
#import "ZCPLDStackTagsView.h"
#import "ZCPLDStackEntranceView.h"

@interface ZCPLDStackViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ZCPLDStackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.scrollView];
    
    [self test2];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.scrollView.frame = self.view.bounds;
}

- (void)test1 {
    ZCPLDStackTagsView *view = [[ZCPLDStackTagsView alloc] init];
    view.frame = CGRectMake(0, 0, SCREENWIDTH, 0);
    view.layer.borderColor = [UIColor blackColor].CGColor;
    view.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    NSMutableArray *titles = [NSMutableArray array];
    for (int i = 0; i < 50; i++) {
        NSInteger randomIndex = RANDOM(0, 45);
        [titles addObject:[ZCPLDCommon textTemplates][randomIndex]];
    }
    view.tags = titles;
    view.frame = CGRectMake(0, 0, SCREENWIDTH, view.fitViewHeight);
    [self.scrollView addSubview:view];
    
    self.scrollView.contentSize = view.frame.size;
}

- (void)test2 {
    ZCPLDStackEntranceView *view = [[ZCPLDStackEntranceView alloc] init];
    view.frame = CGRectMake(0, 0, SCREENWIDTH, 0);
    view.layer.borderColor = [UIColor blackColor].CGColor;
    view.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    NSMutableArray *titles = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        NSInteger randomIndex = RANDOM(0, 45);
        [titles addObject:[ZCPLDCommon textTemplates][randomIndex]];
    }
    view.entranceArr = titles;
    view.frame = CGRectMake(0, 0, SCREENWIDTH, view.fitViewHeight);
    [self.scrollView addSubview:view];
    
    self.scrollView.contentSize = view.frame.size;
}

@end
