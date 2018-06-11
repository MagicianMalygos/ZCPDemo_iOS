//
//  ARObjectMoveViewController.m
//  ARDemo
//
//  Created by 朱超鹏 on 2017/11/15.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "ARObjectMoveViewController.h"
#import "ARManager.h"

@interface ARObjectMoveViewController () <ARSCNViewDelegate, ARSessionDelegate>

@property (nonatomic, strong) ARSCNView *arView;
@property (nonatomic, weak) ARSession *arSession;
@property (nonatomic, strong) ARConfiguration *arConfiguration;

@end

@implementation ARObjectMoveViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.arView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.arSession runWithConfiguration:self.arConfiguration];
    [[CameraTrackingStateView sharedInstance] showInView:self.view];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.arSession pause];
    [[CameraTrackingStateView sharedInstance] hide];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.arView.frame = self.view.bounds;
}

#pragma mark - ARSCNViewDelegate

#pragma mark - ARSessionDelegate

#pragma mark - ARSessionObserver

- (void)session:(ARSession *)session cameraDidChangeTrackingState:(ARCamera *)camera {
    [[CameraTrackingStateView sharedInstance] updateWithTrackingState:camera.trackingState reason:camera.trackingStateReason];
}

#pragma mark - getters and setters

- (ARSCNView *)arView {
    if (!_arView) {
        _arView = [[ARSCNView alloc] init];
        _arView.delegate = self;
        _arView.session = self.arSession;
        _arView.debugOptions = ARSCNDebugOptionShowFeaturePoints;
    }
    return _arView;
}

- (ARSession *)arSession {
    if (!_arSession) {
        _arSession = [ARManager sharedInstance].sharedSession;
        _arSession.delegate = self;
    }
    return _arSession;
}

- (ARConfiguration *)arConfiguration {
    if (!_arConfiguration) {
        ARWorldTrackingConfiguration *worldTrackingConfiguration = [[ARWorldTrackingConfiguration alloc] init];
        worldTrackingConfiguration.planeDetection = ARPlaneDetectionHorizontal;
        _arConfiguration = worldTrackingConfiguration;
        _arConfiguration.lightEstimationEnabled = YES;
    }
    return _arConfiguration;
}

@end
