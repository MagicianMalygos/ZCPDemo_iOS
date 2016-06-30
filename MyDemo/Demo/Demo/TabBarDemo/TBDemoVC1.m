//
//  TBDemoVC1.m
//  Demo
//
//  Created by apple on 16/6/3.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "TBDemoVC1.h"

@interface TBDemoVC1 ()

@end

@implementation TBDemoVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self testBoundsAndFrame];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.view.frame = CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 20 - 44 - 46);
}
- (void)testBoundsAndFrame {
    
    UIView *view1 = [[UIView alloc] initWithFrame:({
        CGRectMake(20, 20, 200, 300);
    })];
    view1.bounds = CGRectMake(-10, -10, 200, 200);
    view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:view1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:({
        CGRectMake(0, 0, 30, 30);
    })];
    view2.backgroundColor = [UIColor blueColor];
    [view1 addSubview:view2];
    
    // 辅助视图
    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(20, 350, 100, 5)];
    v1.backgroundColor = [UIColor redColor];
    [self.view addSubview:v1];
    UIView *v2 = [[UIView alloc] initWithFrame:CGRectMake(120, 350, 100, 5)];
    v2.backgroundColor = [UIColor blueColor];
    [self.view addSubview:v2];
    UIView *v3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    v3.center = view1.center;
    v3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v3];
    
    view1.userInteractionEnabled = YES;
    [view1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        view1.bounds = CGRectMake(-10, -10, RANDOM(50, 200), RANDOM(50, 300));
    }]];
}

@end
