//
//  ViewController.m
//  ARDemo
//
//  Created by 朱超鹏 on 2017/10/16.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "ViewController.h"
#import "ARViewController.h"
#import "ARCapturePlaneViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *vcClassStrArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - event response

- (IBAction)clickOpenARButton {
    [self gotoVCWithIndex:0];
}

- (IBAction)clickCapturePlaneButton {
    [self gotoVCWithIndex:1];
}

- (IBAction)clickCameraTrackingButton {
    [self gotoVCWithIndex:2];
}

- (IBAction)clickObjectMoveButton {
    [self gotoVCWithIndex:3];
}

- (void)gotoVCWithIndex:(int)index {
    [self.navigationController pushViewController:[self vcInstanceWithVcClassStr:self.vcClassStrArr[index]] animated:YES];
}

- (id)vcInstanceWithVcClassStr:(NSString *)vcClassStr {
    return [[NSClassFromString(vcClassStr) alloc] init];
}

- (NSArray *)vcClassStrArr {
    if (!_vcClassStrArr) {
        _vcClassStrArr = @[@"ARViewController",
                        @"ARCapturePlaneViewController",
                        @"ARCameraTrackingViewController",
                        @"ARObjectMoveViewController"];
    }
    return _vcClassStrArr;
}

@end
