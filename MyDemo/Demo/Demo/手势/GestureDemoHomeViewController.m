//
//  GestureDemoHomeViewController.m
//  Demo
//
//  Created by zhuchaopeng on 2019/9/12.
//  Copyright © 2019 zcp. All rights reserved.
//

#import "GestureDemoHomeViewController.h"
#import "GestureRecognizerFactory.h"
#import <Masonry.h>

@interface GestureDemoHomeViewController ()

@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) UIGestureRecognizer *activatedGestureRecognizer;

@end

@implementation GestureDemoHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.segment];
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
    }];
    
    NSArray *infos = @[@"tap", @"longpress", @"swipe", @"pan", @"pinch", @"rotation"];
    for (int i = 0; i < infos.count; i++) {
        [self.segment setTitle:infos[i] forSegmentAtIndex:i];
    }
}

- (void)segmentValueChanged:(UISegmentedControl *)segment {
    [self.view removeGestureRecognizer:self.activatedGestureRecognizer];
    
    UIGestureRecognizer *gestureRecognizer = [GestureRecognizerFactory createGestureRecognizerWithType:segment.selectedSegmentIndex];
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (UISegmentedControl *)segment {
    if (!_segment) {
        _segment = [[UISegmentedControl alloc] init];
        [_segment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _segment;
}

@end
