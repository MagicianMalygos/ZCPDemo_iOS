//
//  ZCPLDFrameViewController.m
//  Demo
//
//  Created by zcp on 2019/5/14.
//  Copyright © 2019 zcp. All rights reserved.
//

#import "ZCPLDFrameViewController.h"
#import "ZCPLDCommon.h"
#import "ZCPLDFrameTagsView.h"

@interface ZCPLDFrameViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ZCPLDFrameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    [self test1];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.scrollView.frame = self.view.bounds;
}

- (void)test1 {
    ZCPLDFrameTagsView *tagsView = [[ZCPLDFrameTagsView alloc] init];
    tagsView.frame = CGRectMake(0, 0, SCREENWIDTH, 0);
    tagsView.layer.borderColor = [UIColor blackColor].CGColor;
    tagsView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    NSMutableArray *tags = [NSMutableArray array];
    for (int i = 0; i < 50; i++) {
        NSInteger randomIndex = RANDOM(0, 45);
        [tags addObject:[ZCPLDCommon textTemplates][randomIndex]];
    }
    tagsView.tags = tags;
    tagsView.frame = CGRectMake(0, 0, SCREENWIDTH, tagsView.fitViewHeight);
    [self.scrollView addSubview:tagsView];
    
    self.scrollView.contentSize = tagsView.frame.size;
}

#pragma mark - getters

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

@end
