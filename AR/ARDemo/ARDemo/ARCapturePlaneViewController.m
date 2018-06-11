//
//  ARCapturePlaneViewController.m
//  ARDemo
//
//  Created by 朱超鹏 on 2017/11/13.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "ARCapturePlaneViewController.h"
#import "ARManager.h"

@interface ARCapturePlaneViewController () <ARSCNViewDelegate, ARSessionDelegate>

@property (nonatomic, strong) ARSCNView *arView;
@property (nonatomic, weak) ARSession *arSession;
@property (nonatomic, strong) ARConfiguration *arConfiguration;

@property (nonatomic, strong) NSMutableArray *planeNodes;

@end

@implementation ARCapturePlaneViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.arView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"捕获平地";
    
    [self.arSession runWithConfiguration:self.arConfiguration];
    [[CameraTrackingStateView sharedInstance] showInView:self.view];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.arView.frame = self.view.bounds;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.arSession pause];
    [[CameraTrackingStateView sharedInstance] hide];
}

#pragma mark - ARSCNViewDelegate

//- (nullable SCNNode *)renderer:(id <SCNSceneRenderer>)renderer nodeForAnchor:(ARAnchor *)anchor {
//
//}

- (void)renderer:(id <SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    if ([anchor isKindOfClass:[ARPlaneAnchor class]]) {
        NSLog(@">>>> 捕获到平地");
        
        ARPlaneAnchor *planeAnchor = (ARPlaneAnchor *)anchor;
        SCNMaterial *material = [[SCNMaterial alloc] init];
        UIImage *img = [UIImage imageNamed:@"scanBackground"];
        material.diffuse.contents = img;
        SCNBox *geometry    = [SCNBox boxWithWidth:0.3 height:0 length:0.3 chamferRadius:0];
        geometry.materials  = @[material];
        SCNNode *planeNode = [SCNNode nodeWithGeometry:geometry];
        planeNode.position = SCNVector3Make(planeAnchor.center.x, 0, planeAnchor.center.z);
        [node addChildNode:planeNode];
        [self.planeNodes addObject:node];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            SCNScene *shipScene = [SCNScene sceneNamed:@"art.scnassets/ship.scn"];
            SCNNode *shipNode = shipScene.rootNode.childNodes[0];
            shipNode.position = SCNVector3Make(planeAnchor.center.x, 0, planeAnchor.center.z);
            shipNode.scale = SCNVector3Make(0.5, 0.5, 0.5);
            [node addChildNode:shipNode];
        });
    }
}

- (void)renderer:(id <SCNSceneRenderer>)renderer willUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    if ([anchor isKindOfClass:[ARPlaneAnchor class]]) {
        NSLog(@"平地锚点更新");
        
        // plane发生合并，在原有基础上更新
        ARPlaneAnchor *planeAnchor = (ARPlaneAnchor *)anchor;
        for (SCNNode *childNode in node.childNodes) {
            childNode.position = SCNVector3Make(planeAnchor.center.x, 0, planeAnchor.center.z);
        }
    }
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didRemoveNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    
}

#pragma mark - ARSessionDelegate

- (void)session:(ARSession *)session didUpdateFrame:(ARFrame *)frame {
    
}

- (void)session:(ARSession *)session didAddAnchors:(NSArray<ARAnchor*>*)anchors {
    
}

- (void)session:(ARSession *)session didUpdateAnchors:(NSArray<ARAnchor*>*)anchors {
    
}

- (void)session:(ARSession *)session didRemoveAnchors:(NSArray<ARAnchor*>*)anchors {
    
}

#pragma mark - ARSessionObserver
- (void)session:(ARSession *)session cameraDidChangeTrackingState:(ARCamera *)camera {
    
    ARTrackingState trackingState = camera.trackingState;
    ARTrackingStateReason trackingStateReason = camera.trackingStateReason;
    [[CameraTrackingStateView sharedInstance] updateWithTrackingState:trackingState reason:trackingStateReason];
}


#pragma mark - getters and setters

- (ARSCNView *)arView {
    if (!_arView) {
        _arView                 = [[ARSCNView alloc] init];
        _arView.delegate        = self;
        _arView.session         = self.arSession;
        _arView.debugOptions    = ARSCNDebugOptionShowFeaturePoints|ARSCNDebugOptionShowWorldOrigin;
    }
    return _arView;
}

- (ARSession *)arSession {
    if (!_arSession) {
        _arSession          = [ARManager sharedInstance].sharedSession;
        _arSession.delegate = self;
    }
    return _arSession;
}

- (ARConfiguration *)arConfiguration {
    if (!_arConfiguration) {
        ARWorldTrackingConfiguration *configuration = [[ARWorldTrackingConfiguration alloc] init];
        configuration.planeDetection                = ARPlaneDetectionHorizontal;
        _arConfiguration                            = configuration;
        _arConfiguration.lightEstimationEnabled     = YES;
    }
    return _arConfiguration;
}

- (NSMutableArray *)planeNodes {
    if (!_planeNodes) {
        _planeNodes = [NSMutableArray array];
    }
    return _planeNodes;
}

@end
