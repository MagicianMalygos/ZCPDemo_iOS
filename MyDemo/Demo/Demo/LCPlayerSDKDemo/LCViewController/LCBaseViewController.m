//
//  LCBaseViewController.m
//  LCPlayerSDKConsumerDemo
//
//  Created by CC on 15/12/15.
//  Copyright © 2015年 CC. All rights reserved.
//

#import "LCBaseViewController.h"

@interface LCBaseViewController ()

@end

@implementation LCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)showTips:(NSString *)tips
{
    __weak typeof(self) wSelf = self;
    UIAlertController * controller = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                         message:tips
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:controller
                        animated:YES
                      completion:^{
                          [wSelf performSelector:@selector(dismissAlertViewPage:)
                                      withObject:controller
                                      afterDelay:kDuration];
                      }];

}

- (void)dismissAlertViewPage:(UIAlertController *)controller
{
    [controller dismissViewControllerAnimated:YES
                                   completion:NULL];
}

- (NSString *)timeFormate:(NSTimeInterval)time
{
    int sec = time;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:sec];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:8];
    [formatter setTimeZone:GTMzone];
    NSString *timeStr = nil;
    if (sec < 60)
    {
        if (sec < 10)
        {
            timeStr = [NSString stringWithFormat:@"0%d",sec];
        }
        else
        {
            timeStr = [NSString stringWithFormat:@"%d",sec];
        }
        timeStr = [NSString stringWithFormat:@"00:00:%@",timeStr];
    }
    else if (sec < 3600)
    {
        [formatter setDateFormat:@"mm:ss"];
        timeStr = [formatter stringFromDate:date];
        timeStr = [NSString stringWithFormat:@"00:%@",timeStr];
    }
    else
    {
        [formatter setDateFormat:@"HH:mm:ss"];
        timeStr = [formatter stringFromDate:date];
    }
    return timeStr;
}

@end
