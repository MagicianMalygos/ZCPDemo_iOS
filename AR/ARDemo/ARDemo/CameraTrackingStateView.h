//
//  CameraTrackingStateView.h
//  ARDemo
//
//  Created by 朱超鹏 on 2017/11/15.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ARKit/ARKit.h>

@interface CameraTrackingStateView : UILabel

+ (instancetype)sharedInstance;
- (void)showInView:(UIView *)view;
- (void)hide;
- (void)updateWithTrackingState:(ARTrackingState)trackingState reason:(ARTrackingStateReason)trackingStateReason;

@end
