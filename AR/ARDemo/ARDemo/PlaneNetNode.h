//
//  PlaneNetNode.h
//  ARDemo
//
//  Created by 朱超鹏 on 2017/10/23.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import <ARKit/ARKit.h>
#import <SceneKit/SceneKit.h>

@interface PlaneNetNode : SCNNode

- (instancetype)initWithAnchor:(ARPlaneAnchor *)anchor;
- (void)update:(ARPlaneAnchor *)anchor;

@end
