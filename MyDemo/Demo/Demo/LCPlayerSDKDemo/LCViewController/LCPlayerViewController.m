//
//  LCPlayerViewController.m
//  LCPlayerSDKConsumerDemo
//  
//  Created by tingting on 16/3/31.
//  Copyright © 2016年 CC. All rights reserved.
//

#import "LCPlayerViewController.h"
#import "LCVodViewController.h"
#import "LCVodViewController+UI.h"
#import "LCPlayerViewController.h"
#import "LCVodView.h"


@interface LCPlayerViewController ()<VodStartPlayDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic , strong) LCVodView *lcVodView; // 点播View

@end

@implementation LCPlayerViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = self.viewTitle;

    
    [self initCreateUI];
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 加载UI
- (void)initCreateUI{
        self.lcVodView = [LCVodView instanceTextView];
        self.lcVodView.delegate = self;
        self.lcVodView.frame = CGRectMake(0, segmentY, ViewWidth, segmentH);
        [self.view addSubview:self.lcVodView];
}

#pragma mark - delegate
// 点播
- (void)vodStartPlayUU:(NSString *)uu vu:(NSString *)vu segType:(NSInteger)segType{
    
        if (self.playerType == LCVodViewType){
            if (uu.length != 0 && vu.length != 0) {
                LCVodViewController * viewController = [[LCVodViewController alloc] initWithNibName:@"LCVodViewController" bundle:nil];
                viewController.uu = uu;
                viewController.vu = vu;
                [self.navigationController pushViewController:viewController animated:YES];
            }
            else{
                [self showTips:@"参数不能为空！"];
            }

        }
        else if (self.playerType == LCVodUIViewType){
            if (uu.length != 0 && vu.length != 0) {

                LCVodViewController_UI * viewController = [[LCVodViewController_UI alloc] initWithNibName:@"LCVodViewController+UI" bundle:nil];
                viewController.uu = uu;
                viewController.vu = vu;
                [self.navigationController pushViewController:viewController animated:YES];
            }
        }
}


#pragma mark - 按钮事件
- (IBAction)backButtonClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 禁止转屏
- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
