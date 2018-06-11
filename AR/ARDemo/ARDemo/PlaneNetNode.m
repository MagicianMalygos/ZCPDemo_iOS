//
//  PlaneNetNode.m
//  ARDemo
//
//  Created by 朱超鹏 on 2017/10/23.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "PlaneNetNode.h"


/*
 （1）Dynamic：可以被碰撞、力影响。适合场景中物理引擎可以完全接管的类型，如掉落的石块。
 （2）Static： 不受碰撞、力影响，且不能移动。适合场景中地面、墙体等。
 （3）Kinemat：不受碰撞、力影响，但移动的时候会影响其他body。适合场景中的角色，毕竟我们不想角色的移动不想被太多力影响。
 */

static CGFloat const GeoHeight = 0.05;

@interface PlaneNetNode ()

@property (nonatomic, strong) ARPlaneAnchor *anchor;
@property (nonatomic, strong) SCNBox *planeGeometry;

@end

@implementation PlaneNetNode

- (instancetype)initWithAnchor:(ARPlaneAnchor *)anchor {
    if (self = [super init]) {
        self.anchor = anchor;
        
        // 创建几何物体
        self.planeGeometry = [SCNBox boxWithWidth:anchor.extent.x height:GeoHeight length:anchor.extent.z chamferRadius:0];
        
        // 设置几何物体的显示样式
        SCNMaterial *material       = [SCNMaterial material];
        material.diffuse.contents   = [UIImage imageNamed:@"tron_grid"];
        
        /*
         materials index对应的面：前 右 后 左 上 下
         1.各个面需要手机移动角度去看到对应的颜色 2.如果我在一面设置了透明，是不能看到另一面的颜色的，而是直接透明看到实景
        */
        SCNMaterial *transparentMaterial        = [SCNMaterial material];
        transparentMaterial.diffuse.contents    = [UIColor clearColor];
        
        SCNMaterial *redMaterial                = [SCNMaterial material];
        redMaterial.diffuse.contents            = [UIColor redColor];
        
        self.planeGeometry.materials = @[redMaterial, transparentMaterial, transparentMaterial, transparentMaterial, material, transparentMaterial];
        
        // 创建node
        SCNNode *planeNode = [SCNNode nodeWithGeometry:self.planeGeometry];
        planeNode.position = SCNVector3Make(0, -GeoHeight / 2, 0);
        
        // 设置node物理属性
        planeNode.physicsBody = [SCNPhysicsBody bodyWithType:SCNPhysicsBodyTypeKinematic shape:[SCNPhysicsShape shapeWithGeometry:self.planeGeometry options:nil]];
        
        [self setTextureScale];
        [self addChildNode:planeNode];
    }
    return self;
}


/**
 当node的更新materials
 */
- (void)setTextureScale {
    CGFloat width   = self.planeGeometry.width;
    CGFloat height  = self.planeGeometry.length;

    SCNMaterial *material = self.planeGeometry.materials[4];
    if (material) {
        material.diffuse.contentsTransform = SCNMatrix4MakeScale(width, height, 1);
        material.diffuse.wrapS = SCNWrapModeRepeat;
        material.diffuse.wrapT = SCNWrapModeRepeat;
    }
}

#pragma mark - public


/**
 根据新锚点，更新平地的长宽
 */
- (void)update:(ARPlaneAnchor *)anchor {
    self.planeGeometry.width    = anchor.extent.x;
    self.planeGeometry.length   = anchor.extent.z;
    self.position               = SCNVector3Make(anchor.center.x, 0, anchor.center.z);
    
    SCNNode *node = self.childNodes.firstObject;
    node.physicsBody = [SCNPhysicsBody bodyWithType:SCNPhysicsBodyTypeKinematic shape:[SCNPhysicsShape shapeWithGeometry:self.planeGeometry options:nil]];
    
    [self setTextureScale];
}

@end
