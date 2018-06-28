//
//  ElasticViewController.m
//  Demo
//
//  Created by 朱超鹏 on 2018/6/27.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "ElasticViewController.h"
#import "UIView+Elastic.h"

@interface ElasticViewController ()

@property (weak, nonatomic) IBOutlet UIView *testView;
@property (weak, nonatomic) IBOutlet UILabel *testLabel;
@property (weak, nonatomic) IBOutlet UIButton *testButton;
@property (weak, nonatomic) IBOutlet UIImageView *testImageView;

@end

@implementation ElasticViewController

- (instancetype)initWithQuery:(NSDictionary *)query {
    if (self = [super initWithNibName:@"ElasticViewController" bundle:nil]) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.testView.layer.cornerRadius = self.testView.width / 2;
    self.testLabel.layer.cornerRadius = self.testLabel.width / 2;
    self.testLabel.layer.masksToBounds = YES;
    self.testButton.layer.cornerRadius = self.testButton.width / 2;
    self.testImageView.layer.cornerRadius = self.testImageView.width / 2;
    self.testImageView.layer.masksToBounds = YES;
    
    self.testView.elasticHelper = [self makeHelper:self.testView.frame];
    self.testLabel.elasticHelper = [self makeHelper:self.testLabel.frame];
    self.testButton.elasticHelper = [self makeHelper:self.testButton.frame];
    self.testImageView.elasticHelper = [self makeHelper:self.testImageView.frame];
}

- (UIViewElasticHelper *)makeHelper:(CGRect)frame {
    UIViewElasticHelper *helper = [[UIViewElasticHelper alloc] init];
    helper.lifeArea = CGRectMake(frame.origin.x - 20, frame.origin.y - 20, frame.size.width + 40, frame.size.height + 40);
    return helper;
}

@end
