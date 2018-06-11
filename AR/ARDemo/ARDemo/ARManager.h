//
//  ARManager.h
//  ARDemo
//
//  Created by 朱超鹏 on 2017/11/15.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import <ARKit/ARKit.h>
#import "CameraTrackingStateView.h"

@interface ARManager : NSObject

@property (nonatomic, strong) ARSession *sharedSession;
+ (instancetype)sharedInstance;

@end
