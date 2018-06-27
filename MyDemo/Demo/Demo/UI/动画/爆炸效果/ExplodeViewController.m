//
//  ExplodeViewController.m
//  Demo
//
//  Created by 朱超鹏 on 2018/6/25.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "ExplodeViewController.h"
#import "UIView+Explode.h"

@interface ExplodeViewController () <UIViewExplodeDelegate>

@property (weak, nonatomic) IBOutlet UIView         *testView;
@property (weak, nonatomic) IBOutlet UIImageView    *testImageView;
@property (weak, nonatomic) IBOutlet UILabel        *testLabel;
@property (weak, nonatomic) IBOutlet UIButton       *testButton;

@end

@implementation ExplodeViewController

- (instancetype)initWithQuery:(NSDictionary *)query {
    if ([self initWithNibName:@"ExplodeViewController" bundle:nil]) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.testView.userInteractionEnabled        = YES;
    self.testImageView.userInteractionEnabled   = YES;
    self.testLabel.userInteractionEnabled       = YES;
    self.testButton.userInteractionEnabled      = YES;
    
    self.testView.explodeDelegate       = self;
    self.testImageView.explodeDelegate  = self;
    self.testLabel.explodeDelegate      = self;
    self.testButton.explodeDelegate     = self;
    
    [self.testView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)]];
    [self.testImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)]];
    [self.testLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)]];
    [self.testButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)]];
}

- (void)tapView:(UITapGestureRecognizer *)tapGesture {
    UIView *view = tapGesture.view;
    [view explode];
}

- (IBAction)clickResetButton {
    [self.testView recoverUnexplodedState];
    [self.testImageView recoverUnexplodedState];
    [self.testLabel recoverUnexplodedState];
    [self.testButton recoverUnexplodedState];
}

- (IBAction)clickRemoveButton {
    [self.testView removeFromSuperview];
}

- (IBAction)clickOpenButton {
    [UIView openExplodeFunction];
}

- (IBAction)clickCloseButton {
    [UIView closeExplodeFunction];
}

- (void)didFinishExplode:(UIView *)view {
    NSLog(@"%@ finish Explode", view);
}

@end
