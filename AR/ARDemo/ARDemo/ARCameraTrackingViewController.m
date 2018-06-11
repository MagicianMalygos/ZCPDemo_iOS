//
//  ARCameraTrackingViewController.m
//  ARDemo
//
//  Created by 朱超鹏 on 2017/11/15.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "ARCameraTrackingViewController.h"
#import "ARManager.h"

@interface ARCameraTrackingViewController () <ARSCNViewDelegate, ARSessionDelegate>

@property (nonatomic, strong) ARSCNView *arView;
@property (nonatomic, weak) ARSession *arSession;
@property (nonatomic, strong) ARConfiguration *arConfiguration;

@property (nonatomic, strong) NSMutableArray <SCNNode *>* aircraftNodes;

@end

@implementation ARCameraTrackingViewController

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

#pragma mark - event response

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/ship.scn"];
    SCNNode *shipNode = scene.rootNode.childNodes[0];
    shipNode.position = SCNVector3Make(0, -0.1, -0.7);
    shipNode.scale = SCNVector3Make(0.5, 0.5, 0.5);
    
    SCNNode *node = [[SCNNode alloc] init];
    node.position = SCNVector3Make(0, 0, 0);
    
    [node addChildNode:shipNode];
    [self.arView.scene.rootNode addChildNode:node];
    [self.aircraftNodes addObject:node];
    
    // 旋转
    CABasicAnimation *moonRotationAnimation = [CABasicAnimation animationWithKeyPath:@"rotation"];
    moonRotationAnimation.duration = 30;
    moonRotationAnimation.toValue = [NSValue valueWithSCNVector4:SCNVector4Make(0, 1, 0, M_PI * 2)];
    moonRotationAnimation.repeatCount = FLT_MAX;
    [node addAnimation:moonRotationAnimation forKey:@"moon rotation around earth"];
}

#pragma mark - ARSCNViewDelegate

#pragma mark - ARSessionDelegate

// 处理每一帧
- (void)session:(ARSession *)session didUpdateFrame:(ARFrame *)frame {
    matrix_float4x4 transform = frame.camera.transform;
    
    for (SCNNode *node in self.aircraftNodes) {
        node.position = SCNVector3Make(transform.columns[3].x, transform.columns[3].y, transform.columns[3].z);
        
//        float qw = sqrt(1 + transform.columns[0][0] + transform.columns[1][1] + transform.columns[2][2]) / 2;
//        float w = 4 * qw * -1;
//        float x = (transform.columns[1][2] - transform.columns[2][1]) / w * -1;
//        float y = (transform.columns[2][0] - transform.columns[0][2]) / w * -1;
//        float z = (transform.columns[0][1] - transform.columns[1][0]) / w * -1;
//        node.rotation = SCNVector4Make(x, y, z, w);
        
//        SCNMatrix4 t;
//        t.m11 = transform.columns[0][0];
//        t.m12 = transform.columns[1][0];
//        t.m13 = transform.columns[2][0];
//        t.m14 = transform.columns[3][0];
//        t.m21 = transform.columns[0][1];
//        t.m22 = transform.columns[1][1];
//        t.m23 = transform.columns[2][1];
//        t.m24 = transform.columns[3][1];
//        t.m31 = transform.columns[0][2];
//        t.m32 = transform.columns[1][2];
//        t.m33 = transform.columns[2][2];
//        t.m34 = transform.columns[3][2];
//        t.m41 = transform.columns[0][3];
//        t.m42 = transform.columns[1][3];
//        t.m43 = transform.columns[2][3];
//        t.m44 = transform.columns[3][3];
//
//        node.transform = t;
    }
}

- (void)logTransform:(SCNMatrix4)transform {
    NSLog(@"\n%f %f %f %f\n%f %f %f %f\n%f %f %f %f\n%f %f %f %f\n",
          transform.m11, transform.m12, transform.m13, transform.m14,
          transform.m21, transform.m22, transform.m23, transform.m24,
          transform.m31, transform.m32, transform.m33, transform.m34,
          transform.m41, transform.m42, transform.m43, transform.m44);
}

- (void)logSimdTransform:(simd_float4x4)transform {
    NSLog(@"\n%f %f %f %f\n%f %f %f %f\n%f %f %f %f\n%f %f %f %f\n",
          transform.columns[0][0], transform.columns[1][0], transform.columns[2][0], transform.columns[3][0],
          transform.columns[0][1], transform.columns[1][1], transform.columns[2][1], transform.columns[3][1],
          transform.columns[0][2], transform.columns[1][2], transform.columns[2][2], transform.columns[3][2],
          transform.columns[0][3], transform.columns[1][3], transform.columns[2][3], transform.columns[3][3]);
}

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
    NSLog(@"%li %@", error.code, error.localizedDescription);
}

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
        _arView.debugOptions = ARSCNDebugOptionShowFeaturePoints | ARSCNDebugOptionShowWorldOrigin;
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

- (NSMutableArray<SCNNode *> *)aircraftNodes {
    if (!_aircraftNodes) {
        _aircraftNodes = [NSMutableArray array];
    }
    return _aircraftNodes;
}

@end
