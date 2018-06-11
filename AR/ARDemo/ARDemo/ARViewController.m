//
//  ARViewController.m
//  ARDemo
//
//  Created by 朱超鹏 on 2017/10/16.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "ARViewController.h"
#import "PlaneNetNode.h"
#import "ARManager.h"

#define FPSLog 0

// 生成随机数
#define RANDOM(a, b)                    ((arc4random() % ((b) - (a) + 1)) + (a))
// 生成随机颜色
#define RANDOM_COLOR [UIColor colorWithRed:arc4random() % 10 / 10.0f green:arc4random() % 10 / 10.0f blue:arc4random() % 10 / 10.0f alpha:1.0f]

@interface ARViewController () <ARSCNViewDelegate, ARSessionDelegate, SCNPhysicsContactDelegate>

/**
 继承自SCNView<SceneKit -> UIView>用于展示相机视图和SceneKit内容的视图。
 当设置ARSession，并开启会话时，会自动获取相机的视频流作为scene的背景显示。
 视图的scenekit场景对应的世界坐标系会通过session configuration与ar世界坐标系建立起直接的联系
 真实世界设备的移动时，视图会自动移动SceneKit相机与之同步。
 */
@property (nonatomic, strong) ARSCNView *arSceneView;
/**
 管理相机和相机追踪配置。
 从传感器中读取数据，控制设备的内置摄像头，在相机捕获到的图像上做图像分析
 */
@property (nonatomic, weak) ARSession *arSession;
/**
 AR技术的描述和配置，用于配置追踪相机中的哪些东西，为ARSession服务。其子类分别对应了几种AR技术
 ARConfiguration有下面几个子类：
     ARWorldTrackingConfiguration：用于追踪现实世界中物体的位移和方向的配置（6自由度，xyz上的位移和xyz上的旋转）。主要用于追踪特征点，以及追踪平面。
     AROrientationTrackingConfiguration：用于追踪现实世界方向的配置（3自由度，xyz上的位移）
     ARFaceTrackingConfiguration：用于追踪人脸。主要用于追踪三维人脸详细的拓扑结构和面部表情。只有装备了True Depth前置景深摄像头的iPhone X才能使用
 */
@property (nonatomic, strong) ARConfiguration *arConfigure;
/**
 ar相机
 相关属性：世界坐标系中相机旋转和平移的变换矩阵、描述相机方向的矢量欧拉角、投影矩阵、相机追踪状态以及处于该状态的原因、相机分辨率
 */
@property (nonatomic, weak) ARCamera *arCamera;
/**
 记录给定时间所有被跟踪的ar对象的状态，提供了渲染一帧所需的所有数据。
 作为session中的一部分，记录session捕获的图像和跟踪信息
 追踪当前相机状态，图像帧以及时间
 */
@property (nonatomic, weak) ARFrame *arFrame;
/**
 表示一个真实世界中的位置和方向，可以用来在scene中放置物体。
 相关属性：世界坐标系中的旋转和平移的变换矩阵
 子类：
     ARPlaneAnchor：表示一个平面的位置和方向，相关属性：锚点坐标系中平面的中心
     ARFaceAnchor：
 */
@property (nonatomic, strong) ARAnchor *arAnchor;

@property (nonatomic, strong) SCNNode *planeNode; // 飞机模型
@property (nonatomic, strong) NSMutableDictionary *planeNetNodes;
@property (nonatomic, strong) NSMutableArray <SCNNode *>*boxNodes;

@end

@implementation ARViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加ar视图
    [self.view addSubview:self.arSceneView];
    
    // abyss
    SCNBox *abyss = [SCNBox boxWithWidth:1000 height:10 length:1000 chamferRadius:0];
    SCNMaterial *abyssMaterial = [SCNMaterial material];
    abyssMaterial.diffuse.contents = [UIColor clearColor];
    abyss.materials = @[abyssMaterial];
    SCNNode *abyssNode = [SCNNode nodeWithGeometry:abyss];
    abyssNode.position = SCNVector3Make(0, -20, 0);
    abyssNode.physicsBody = [SCNPhysicsBody bodyWithType:SCNPhysicsBodyTypeKinematic shape:nil];
    abyssNode.physicsBody.categoryBitMask = SCNPhysicsCollisionCategoryDefault;
    abyssNode.physicsBody.contactTestBitMask = SCNPhysicsCollisionCategoryStatic;
    [self.arSceneView.scene.rootNode addChildNode:abyssNode];
    self.arSceneView.scene.physicsWorld.contactDelegate = self;
    
    // gesture
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.view addGestureRecognizer:longPress];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (ARWorldTrackingConfiguration.isSupported) {
        // 开启ar会话
        [self.arSession runWithConfiguration:self.arConfigure];
        [[CameraTrackingStateView sharedInstance] showInView:self.view];
        return;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.arSession pause];
    [[CameraTrackingStateView sharedInstance] hide];
}

#pragma mark - gesture

- (void)tap:(UITapGestureRecognizer *)gesture {
    CGPoint touchPoint = [gesture locationInView:self.arSceneView];
    
    // 点击点沿方向的射线，FeaturePoint是获取附近特征点，ExistingPlane是获取射线穿透的平面node
    NSArray *hitTestResults = [self.arSceneView hitTest:touchPoint types:ARHitTestResultTypeFeaturePoint];
    ARHitTestResult *firstResult = hitTestResults.firstObject;
    if (firstResult) {
        [self insertGeometry:firstResult];
    }
}

- (void)longPress:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state != UIGestureRecognizerStateBegan) {
        return;
    }
    CGPoint pressPoint = [gesture locationInView:self.arSceneView];
    
    NSArray *hitTestResults = [self.arSceneView hitTest:pressPoint types:ARHitTestResultTypeExistingPlane];
    ARHitTestResult *firstResult = hitTestResults.firstObject;
    if (firstResult) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self explode:firstResult];
        });
    }
}

- (void)insertGeometry:(ARHitTestResult *)hitTestResult {
    CGFloat dimension   = 0.05;
    SCNBox *box         = [SCNBox boxWithWidth:dimension height:dimension length:dimension chamferRadius:RANDOM(0, 1)];
    SCNNode *node       = [SCNNode nodeWithGeometry:box];
    
    // 设置纹理
    SCNMaterial *material       = [SCNMaterial material];
    material.diffuse.contents   = RANDOM_COLOR;
    box.materials               = @[material, material, material, material, material, material];
    
    // 设置物理属性，会让SceneKit用物理引擎控制该几何体
    node.physicsBody                    = [SCNPhysicsBody bodyWithType:SCNPhysicsBodyTypeDynamic shape:[SCNPhysicsShape shapeWithGeometry:box options:nil]];
    node.physicsBody.mass               = 1;
    
    // 把几何体放在用户点击点再高一点，以便物体能够掉落到平面上
    CGFloat insertionYOffset = 0.5;
    node.position = SCNVector3Make(hitTestResult.worldTransform.columns[3].x, hitTestResult.worldTransform.columns[3].y + insertionYOffset, hitTestResult.worldTransform.columns[3].z);
    
    [self.arSceneView.scene.rootNode addChildNode:node];
    [self.boxNodes addObject:node];
}

- (void)explode:(ARHitTestResult *)hitTestResult {
    CGFloat explosionYOffset = 0.1;
    
    SCNVector3 position = SCNVector3Make(hitTestResult.worldTransform.columns[3].x, hitTestResult.worldTransform.columns[3].y - explosionYOffset, hitTestResult.worldTransform.columns[3].z);
    
    for (SCNNode *boxNode in self.boxNodes) {
        
        // 冲击波与几何体之间的距离
        SCNVector3 distance = SCNVector3Make(boxNode.worldPosition.x - position.x, boxNode.worldPosition.y - position.y, boxNode.worldPosition.z - position.z);
        
        float len = sqrtf(distance.x * distance.x + distance.y * distance.y + distance.z + distance.z);
        
        // 冲击波影响范围
        CGFloat maxDistance = 2;
        
        CGFloat scale = MAX(0, (maxDistance - len));
        scale = scale * scale * 2;
        
        distance.x = distance.x / len * scale;
        distance.y = distance.y / len * scale;
        distance.z = distance.z / len * scale;
        
        // 给几何体加力
        [boxNode.physicsBody applyForce:distance atPosition:SCNVector3Make(0.05, 0.05, 0.05) impulse:true];
    }
}

#pragma mark - ARSCNViewDelegate

// 根据给的锚点设置一个自定义的Node。如果没有实现此方法，则会自动创建 node；如果返回 nil，则会忽略此 anchor。
// 捕捉到平地会自动添加一个PlaneNode，然后会走didAddNode方法。如果重写会并返回nil会导致无添加PlaneNode，继而不会触发didAddNode
//- (nullable SCNNode *)renderer:(id <SCNSceneRenderer>)renderer nodeForAnchor:(ARAnchor *)anchor {
//    NSLog(@"nodeForAnchor");
//}

// 捕捉到平地会自动添加一个PlaneNode，然后会走didAddNode方法
- (void)renderer:(id<SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    NSLog(@"didAddNode");
    
    if ([anchor isMemberOfClass:[ARPlaneAnchor class]]) {
        NSLog(@"捕捉到平地");
        PlaneNetNode *plane = [[PlaneNetNode alloc] initWithAnchor:(ARPlaneAnchor *)anchor];
        // 要注意addChildNode决定了node所在的空间坐标系，加到哪个node上就处于哪个node的空间坐标系中
        [node addChildNode:plane];
        [self.planeNetNodes setObject:plane forKey:anchor.identifier];
    }
}

- (void)renderer:(id <SCNSceneRenderer>)renderer willUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    NSLog(@"willUpdateNode");
}

- (void)renderer:(id<SCNSceneRenderer>)renderer didUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    NSLog(@"didUpdateNode");
    
    // node的anchor更新，此时需要更新node
    if ([anchor isKindOfClass:[ARPlaneAnchor class]]) {
        PlaneNetNode *planeNetNode = [self.planeNetNodes objectForKey:anchor.identifier];
        [planeNetNode update:(ARPlaneAnchor *)anchor];
    }
}

- (void)renderer:(id<SCNSceneRenderer>)renderer didRemoveNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    NSLog(@"didRemoveNode");
    
    [self.planeNetNodes removeObjectForKey:anchor.identifier];
}


#pragma mark SCNSceneRendererDelegate
// sceneview的逐帧渲染回调
// 下面6个方法在每一帧会走一遍，1s大概走60次

- (void)renderer:(id<SCNSceneRenderer>)renderer updateAtTime:(NSTimeInterval)time {
    if (FPSLog) {
        NSLog(@"1.updateAtTime %lf", time);
    }
}

- (void)renderer:(id<SCNSceneRenderer>)renderer didApplyAnimationsAtTime:(NSTimeInterval)time {
    if (FPSLog) {
        NSLog(@"2.didApplyAnimationsAtTime %lf", time);
    }
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didSimulatePhysicsAtTime:(NSTimeInterval)time {
    if (FPSLog) {
        NSLog(@"3.didSimulatePhysicsAtTime %lf", time);
    }
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didApplyConstraintsAtTime:(NSTimeInterval)time {
    if (FPSLog) {
        NSLog(@"4.didApplyConstraintsAtTime %lf", time);
    }
}

- (void)renderer:(id<SCNSceneRenderer>)renderer willRenderScene:(SCNScene *)scene atTime:(NSTimeInterval)time {
    if (FPSLog) {
        NSLog(@"5.willRenderScene %lf", time);
    }
}

- (void)renderer:(id<SCNSceneRenderer>)renderer didRenderScene:(SCNScene *)scene atTime:(NSTimeInterval)time {
    if (FPSLog) {
        NSLog(@"6.didRenderScene %lf", time);
    }
}

#pragma mark ARSessionObserver

// ARSCNViewDelegate继承了ARSessionObserver。这样继承的目的是，由于使用ARSCNView需要设置session，所以session运行状态也可由delegate监听
// 同时ARSessionDelegate也继承了ARSessionObserver。经过测试：如果ARSCNView、ARSession的代理不是同一个对象，则ARSessionObserver的回调方法会走两次，且ARSCNView的delegate先走；如果ARSCNView、ARSession的代理是同一个对象，则ARSessionObserver的回调只会走一次。

#pragma mark - ARSessionDelegate

- (void)session:(ARSession *)session didUpdateFrame:(ARFrame *)frame {
    if (FPSLog) {
        NSLog(@"相机移动");
    }
}

- (void)session:(ARSession *)session didAddAnchors:(NSArray<ARAnchor*>*)anchors {
    NSLog(@"添加锚点");
}

- (void)session:(ARSession *)session didUpdateAnchors:(NSArray<ARAnchor*>*)anchors {
    NSLog(@"更新锚点");
}

- (void)session:(ARSession *)session didRemoveAnchors:(NSArray<ARAnchor*>*)anchors {
    NSLog(@"移除锚点");
}

#pragma mark ARSessionObserver

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
    NSLog(@"ARViewController didFailWithError: %@", session);
}

- (void)session:(ARSession *)session cameraDidChangeTrackingState:(ARCamera *)camera {
    NSLog(@"ARViewController cameraDidChangeTrackingState: %@", session);
    [[CameraTrackingStateView sharedInstance] updateWithTrackingState:camera.trackingState reason:camera.trackingStateReason];
}

- (void)sessionWasInterrupted:(ARSession *)session {
    NSLog(@"ARViewController sessionWasInterrupted: %@", session);
}

- (void)sessionInterruptionEnded:(ARSession *)session {
    NSLog(@"ARViewController sessionInterruptionEnded: %@", session);
}

- (void)session:(ARSession *)session didOutputAudioSampleBuffer:(CMSampleBufferRef)audioSampleBuffer {
    NSLog(@"ARViewController didOutputAudioSampleBuffer: %@", session);
}

#pragma mark - SCNPhysicsContactDelegate
// 当两个物体接触时会触发回调

- (void)physicsWorld:(SCNPhysicsWorld *)world didBeginContact:(SCNPhysicsContact *)contact {
    
}

- (void)physicsWorld:(SCNPhysicsWorld *)world didUpdateContact:(SCNPhysicsContact *)contact {
    
}

- (void)physicsWorld:(SCNPhysicsWorld *)world didEndContact:(SCNPhysicsContact *)contact {
    
}

#pragma mark - getters and setters

- (ARSCNView *)arSceneView {
    if (!_arSceneView) {
        _arSceneView = [[ARSCNView alloc] initWithFrame:self.view.bounds];
        // 设置会话
        _arSceneView.session = self.arSession;
        // 自动刷新灯光，ARKit在scene中自动创建并更新SceneKit灯光
        _arSceneView.automaticallyUpdatesLighting = YES;
        // debug选项，显示世界坐标系、显示特征点
        _arSceneView.debugOptions = /*SCNDebugOptionShowPhysicsShapes|SCNDebugOptionShowBoundingBoxes|SCNDebugOptionShowLightInfluences|SCNDebugOptionShowLightExtents|SCNDebugOptionShowPhysicsFields|SCNDebugOptionShowWireframe|SCNDebugOptionRenderAsWireframe|SCNDebugOptionShowSkeletons|SCNDebugOptionShowCreases|SCNDebugOptionShowConstraints|SCNDebugOptionShowCameras|*/ARSCNDebugOptionShowFeaturePoints|ARSCNDebugOptionShowWorldOrigin;
        _arSceneView.delegate = self;
    }
    return _arSceneView;
}

- (ARSession *)arSession {
    if (!_arSession) {
        _arSession = [ARManager sharedInstance].sharedSession;
        _arSession.delegate = self;
    }
    return _arSession;
}

- (ARConfiguration *)arConfigure {
    if (!_arConfigure) {
        // 创建世界追踪配置，ARWorldTrackingConfiguration需要A9芯片支持，官方建议AR应用使用ARWorldTrackingConfiguration
        ARWorldTrackingConfiguration *configure = [[ARWorldTrackingConfiguration alloc] init];
        // 设置平面追踪类型。有None和Horizontal两个选择，None表示不追踪平面，Horizontal表示追踪水平平面，（没有垂直平面）。
        // 当开启水平平面追踪后，一旦相机捕获到平面，会获取平面对应的锚点（ARPlaneAnchor），并根据锚点添加一个SCNNode到ARSCNView中。可在ARSCNViewDelegate的回调中进行自定义处理。
        // 当检测到多个平面时会进行合并处理
        configure.planeDetection    = ARPlaneDetectionHorizontal;
        _arConfigure                = configure;
        // 自适应灯光
        _arConfigure.lightEstimationEnabled = YES;
    }
    return _arConfigure;
}

- (NSMutableDictionary *)planeNetNodes {
    if (!_planeNetNodes) {
        _planeNetNodes = [NSMutableDictionary dictionary];
    }
    return _planeNetNodes;
}

- (NSMutableArray <SCNNode *>*)boxNodes {
    if (!_boxNodes) {
        _boxNodes = [NSMutableArray array];
    }
    return _boxNodes;
}

@end
