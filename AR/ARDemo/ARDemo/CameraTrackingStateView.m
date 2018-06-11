//
//  CameraTrackingStateView.m
//  ARDemo
//
//  Created by 朱超鹏 on 2017/11/15.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "CameraTrackingStateView.h"

@implementation CameraTrackingStateView

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static CameraTrackingStateView *instance;
    dispatch_once(&onceToken, ^{
        instance = [[CameraTrackingStateView alloc] init];
        instance.textAlignment = NSTextAlignmentCenter;
        instance.font = [UIFont systemFontOfSize:14.0f];
        instance.textColor = [UIColor redColor];
        instance.numberOfLines = 0;
    });
    return instance;
}

- (void)showInView:(UIView *)view {
    if (self.superview) {
        [self removeFromSuperview];
    }
    self.frame = CGRectMake(0, view.frame.size.height - 20, view.frame.size.width, 20);
    [view addSubview:self];
    [view bringSubviewToFront:self];
}

- (void)hide {
    if (self.superview) {
        self.text = @"";
        [self removeFromSuperview];
    }
}

- (void)updateWithTrackingState:(ARTrackingState)trackingState reason:(ARTrackingStateReason)trackingStateReason {
    NSString *msg = @"";
    
    switch (trackingState) {
        case ARTrackingStateNotAvailable: {
            msg = @"Camera tracking is not available.";
            break;
        }
        case ARTrackingStateLimited: {
            msg = @"Camera tracking is limited.";
            break;
        }
        case ARTrackingStateNormal: {
            msg = @"Camera tracking is normal.";
            break;
        }
        default:
            break;
    }
    
    switch (trackingStateReason) {
        case ARTrackingStateReasonNone: {
            break;
        }
        case ARTrackingStateReasonInitializing: {
            msg = [msg stringByAppendingString:@"Due to initialization in progress."];
            break;
        }
        case ARTrackingStateReasonExcessiveMotion: {
            msg = [msg stringByAppendingString:@"Due to a excessive motion of the camera."];
            break;
        }
        case ARTrackingStateReasonInsufficientFeatures: {
            msg = [msg stringByAppendingString:@"Due to a lack of features visible to the camera."];
            break;
        }
        default:
            break;
    }
    self.text = msg;
}

@end
