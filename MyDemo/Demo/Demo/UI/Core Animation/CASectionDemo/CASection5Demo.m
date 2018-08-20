//
//  CASection5Demo.m
//  Demo
//
//  Created by 朱超鹏 on 2018/8/13.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "CASection5Demo.h"
#import <GLKit/GLKit.h>

@implementation CASection5Demo

// ----------------------------------------------------------------------
#pragma mark - demo
// ----------------------------------------------------------------------

#pragma mark - 仿射变换

- (void)demo1 {
    // “仿射”的意思是无论变换矩阵用什么值，图层中平行的两条线在变换之后任然保持平行
    // view.transform 对应 layer.affineTransform。CGAffineTransform类型，用于在二维空间做旋转，缩放和平移。
    
    // CGAffineTransform，Core Graphics框架中用于2D变换的矩阵结构体
    // 是一个3x2矩阵，二维空间向量与其做乘法进行变换
    CGFloat a=0, b=0, c=0, d=0, tx=0, ty=0;
    CGAffineTransform affineTransform = CGAffineTransformMake(a, b, c, d, tx, ty);
    if (affineTransform.a) {} // just for clean warning
    
    /*
             [a  b ]
     [x y] x |c  d | = ？
             [tx ty]
     
     1x2矩阵和3x2矩阵 无法做乘法
     
               [a  b  0]
     [x y 1] x |c  d  0| = [x` y` 1]
               [tx ty 1]
     
     向量(x, y)经过仿射变换后得到向量(x`, y`)
     为了使向量和矩阵能够符合矩阵乘法的规则，在做乘法前为向量和矩阵填充了没有意义的标志值。
     */
    
    // Core Graphics提供了一系列函数，可以使用它们做变换
    /*
     旋转，angle角弧度值
     CGAffineTransformMakeRotation(CGFloat angle)
     缩放，sx水平方向缩放比例；sy垂直方向缩放比例
     CGAffineTransformMakeScale(CGFloat sx, CGFloat sy)
     平移，tx水平方向平移距离；ty垂直方向平移值
     CGAffineTransformMakeTranslation(CGFloat tx, CGFloat ty)
     */
    
    // 旋转
    {
        // 原图
        UIView *view            = [[UIView alloc] init];
        view.frame              = CGRectMake(10, 10, 50, 50);
        view.backgroundColor    = [UIColor redColor];
        [self addSubview:view];
        // 旋转后
        UIView *view2           = [[UIView alloc] init];
        view2.frame             = view.frame;
        view2.backgroundColor   = [UIColor greenColor];
        view2.transform         = CGAffineTransformMakeRotation(M_PI_4);
        [self addSubview:view2];
    }
    
    // 缩放
    {
        // 原图
        UIView *view            = [[UIView alloc] init];
        view.frame              = CGRectMake(70, 10, 50, 50);
        view.backgroundColor    = [UIColor redColor];
        [self addSubview:view];
        // 缩放后
        UIView *view2           = [[UIView alloc] init];
        view2.frame             = view.frame;
        view2.backgroundColor   = [UIColor greenColor];
        view2.transform         = CGAffineTransformMakeScale(0.5, 0.5);
        [self addSubview:view2];
    }
    
    // 平移
    {
        // 原图
        UIView *view            = [[UIView alloc] init];
        view.frame              = CGRectMake(130, 10, 50, 50);
        view.backgroundColor    = [UIColor redColor];
        [self addSubview:view];
        // 平移后
        UIView *view2           = [[UIView alloc] init];
        view2.frame             = view.frame;
        view2.backgroundColor   = [UIColor greenColor];
        view2.transform         = CGAffineTransformMakeTranslation(10, 20);
        [self addSubview:view2];
    }
    
    
    // 混合变换。通过使用如下方法可以按照顺序组合变换
    /*
     在t的基础上旋转
     CGAffineTransformRotate(CGAffineTransform t, CGFloat angle)
     在t的基础上缩放
     CGAffineTransformScale(CGAffineTransform t, CGFloat sx, CGFloat sy)
     在t的基础上平移
     CGAffineTransformTranslate(CGAffineTransform t, CGFloat tx, CGFloat ty)
     
     常量：
     CGAffineTransformIdentity 单位矩阵
     */
    
    // 平移+旋转
    {
        // 原图
        UIView *view            = [[UIView alloc] init];
        view.frame              = CGRectMake(10, 100, 50, 50);
        view.backgroundColor    = [UIColor redColor];
        [self addSubview:view];
        // 变换后
        UIView *view2           = [[UIView alloc] init];
        view2.frame             = view.frame;
        view2.backgroundColor   = [UIColor greenColor];
        
        CGAffineTransform affineTransform = CGAffineTransformIdentity;
        affineTransform         = CGAffineTransformTranslate(affineTransform, 50, 0);
        affineTransform         = CGAffineTransformRotate(affineTransform, M_PI_4);
        view2.transform         = affineTransform;
        
        [self addSubview:view2];
    }
    // 旋转+平移
    {
        // 原图
        UIView *view            = [[UIView alloc] init];
        view.frame              = CGRectMake(150, 100, 50, 50);
        view.backgroundColor    = [UIColor redColor];
        [self addSubview:view];
        // 变换后
        UIView *view2           = [[UIView alloc] init];
        view2.frame             = view.frame;
        view2.backgroundColor   = [UIColor greenColor];
        
        CGAffineTransform affineTransform = CGAffineTransformIdentity;
        affineTransform         = CGAffineTransformRotate(affineTransform, M_PI_4);
        affineTransform         = CGAffineTransformTranslate(affineTransform, 50, 0);
        view2.transform         = affineTransform;
        
        [self addSubview:view2];
    }
    // 平移+旋转 与 旋转+平移 结果是不同的
    // 因为先旋转之后坐标系也会跟着旋转，后面再平移时是按照旋转后的坐标轴进行移动的，所以两个结果不同。
}

#pragma mark - 3D变换 (基础变换)

- (void)demo2 {
    // CATransform3D，QuartzCore框架中用于3D变换的矩阵结构体
    // 是一个4x4矩阵，二维空间向量与其做乘法进行变换
    
    /*
               [m11 m21 m31 m41]
     [x y z] x |m12 m22 m32 m42| = ?
               [m13 m23 m33 m43]
               [m14 m24 m34 m44]
     
     1x3矩阵和4x4矩阵 无法做乘法
     
                 [m11 m21 m31 m41]
     [x y z 1] x |m12 m22 m32 m42| = [x` y` z` 1]
                 [m13 m23 m33 m43]
                 [m14 m24 m34 m44]
     
     向量(x, y)经过仿射变换后得到向量(x`, y`)
     为了使向量和矩阵能够符合矩阵乘法的规则，在做乘法前为向量和矩阵填充了没有意义的标志值。
     */
    
    // 原图
    UILabel *view           = [self getTestLabelWithFrame:CGRectMake(10, 10, 50, 50)];
    view.backgroundColor    = [UIColor redColor];
    [self addSubview:view];
    
    // 旋转（正值为顺时针方向）
    {
        // x方向旋转
        UILabel *view1          = [self getTestLabelWithFrame:CGRectMake(70, 10, 50, 50)];
        [self addSubview:view1];
        CABasicAnimation *aniX  = [self getAnimationWithKeyPath:@"transform.rotation.x" fromValue:@(0) toValue:@(M_PI*2)];
        [view1.layer addAnimation:aniX forKey:nil];
        
        // y方向旋转
        UILabel *view2          = [self getTestLabelWithFrame:CGRectMake(130, 10, 50, 50)];
        [self addSubview:view2];
        CABasicAnimation *aniY  = [self getAnimationWithKeyPath:@"transform.rotation.y" fromValue:@(0) toValue:@(M_PI*2)];
        [view2.layer addAnimation:aniY forKey:nil];
        
        // z方向旋转
        UILabel *view3          = [self getTestLabelWithFrame:CGRectMake(190, 10, 50, 50)];
        [self addSubview:view3];
        CABasicAnimation *aniZ  = [self getAnimationWithKeyPath:@"transform.rotation.z" fromValue:@(0) toValue:@(M_PI*2)];
        [view3.layer addAnimation:aniZ forKey:nil];
    }
    // 缩放
    {
        // x方向缩放
        UILabel *view1          = [self getTestLabelWithFrame:CGRectMake(70, 100, 50, 50)];
        [self addSubview:view1];
        CABasicAnimation *aniX  = [self getAnimationWithKeyPath:@"transform.scale.x" fromValue:@(0) toValue:@(2)];
        [view1.layer addAnimation:aniX forKey:nil];
        // y方向缩放
        UILabel *view2          = [self getTestLabelWithFrame:CGRectMake(130, 100, 50, 50)];
        [self addSubview:view2];
        CABasicAnimation *aniY  = [self getAnimationWithKeyPath:@"transform.scale.y" fromValue:@(0) toValue:@(2)];
        [view2.layer addAnimation:aniY forKey:nil];
        // z方向缩放
        UILabel *view3          = [self getTestLabelWithFrame:CGRectMake(190, 100, 50, 50)];
        [self addSubview:view3];
        CABasicAnimation *aniZ  = [self getAnimationWithKeyPath:@"transform.scale.z" fromValue:@(0) toValue:@(2)];
        [view3.layer addAnimation:aniZ forKey:nil];
    }
    // 平移
    {
        // x方向平移
        UILabel *view1          = [self getTestLabelWithFrame:CGRectMake(70, 200, 50, 50)];
        [self addSubview:view1];
        CABasicAnimation *aniX  = [self getAnimationWithKeyPath:@"transform.translation.x" fromValue:@(0) toValue:@(10)];
        [view1.layer addAnimation:aniX forKey:nil];
        // y方向平移
        UILabel *view2          = [self getTestLabelWithFrame:CGRectMake(130, 200, 50, 50)];
        [self addSubview:view2];
        CABasicAnimation *aniY  = [self getAnimationWithKeyPath:@"transform.translation.y" fromValue:@(0) toValue:@(10)];
        [view2.layer addAnimation:aniY forKey:nil];
        // z方向平移
        UILabel *view3          = [self getTestLabelWithFrame:CGRectMake(190, 200, 50, 50)];
        [self addSubview:view3];
        CABasicAnimation *aniZ  = [self getAnimationWithKeyPath:@"transform.translation.z" fromValue:@(0) toValue:@(10)];
        [view3.layer addAnimation:aniZ forKey:nil];
    }
}

#pragma mark - 3D变换（透视投影）

- (void)demo3 {
    /*
     平行投影：相互平行的投射线所产生的投影。类似仿射变换
     中心投影：由一点放射的投射线所产生的投影。可以使图层做变换时更有3d效果
     
     对于中心投影，当视角相机与屏幕的距离(d)较近时会增强透视效果（我们知道，将物体放至离光源越近，灯光照射产生的阴影越大）
     可设置CATransform3D的m34值来改变投影效果，取值 m34 = -1.0 / d
     */
    
    // 透视投影
    {
        // 原图
        UILabel *view = [self getTestLabelWithFrame:CGRectMake(10, 10, 100, 100)];
        view.backgroundColor = [UIColor redColor];
        [self addSubview:view];
        CATransform3D transform     = CATransform3DIdentity;
        CABasicAnimation *animation = [self getAnimationWithKeyPath:@"transform" fromValue:[NSValue valueWithCATransform3D:CATransform3DRotate(transform, 0, 0, 1, 0)] toValue:[NSValue valueWithCATransform3D:CATransform3DRotate(transform, M_PI, 0, 1, 0)]];
        animation.duration = 60.0f;
        [view.layer addAnimation:animation forKey:nil];
        // 修改后
        UILabel *view1 = [self getTestLabelWithFrame:CGRectMake(120, 10, 100, 100)];
        [self addSubview:view1];
        CATransform3D transform1 = CATransform3DIdentity;
        transform1.m34 = -1.0 / 100;
        CABasicAnimation *animation1 = [self getAnimationWithKeyPath:@"transform" fromValue:[NSValue valueWithCATransform3D:CATransform3DRotate(transform1, 0, 0, 1, 0)] toValue:[NSValue valueWithCATransform3D:CATransform3DRotate(transform1, M_PI, 0, 1, 0)]];
        animation1.duration = 60.0f;
        [view1.layer addAnimation:animation1 forKey:nil];
        // 修改后
        UILabel *view2 = [self getTestLabelWithFrame:CGRectMake(230, 10, 100, 100)];
        [self addSubview:view2];
        CATransform3D transform2 = CATransform3DIdentity;
        transform2.m34 = -1.0 / 500;
        CABasicAnimation *animation2 = [self getAnimationWithKeyPath:@"transform" fromValue:[NSValue valueWithCATransform3D:CATransform3DRotate(transform2, 0, 0, 1, 0)] toValue:[NSValue valueWithCATransform3D:CATransform3DRotate(transform2, M_PI, 0, 1, 0)]];
        animation2.duration = 60.0f;
        [view2.layer addAnimation:animation2 forKey:nil];
    }
}

#pragma mark - 3D变换（其他）

- (void)demo4 {
    // sublayerTransform是子视图根据父视图的坐标系进行变换
    {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(10, 10, 100, 100);
        view.backgroundColor = [UIColor redColor];
        [self addSubview:view];
        
        UILabel *view1 = [self getTestLabelWithFrame:CGRectMake(10, 10, 20, 20)];
        view1.layer.transform = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
        [view addSubview:view1];
        
        UILabel *view2 = [self getTestLabelWithFrame:CGRectMake(10, 40, 20, 20)];
        view2.layer.transform = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
        [view addSubview:view2];
    }
    
    {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(120, 10, 100, 100);
        view.backgroundColor = [UIColor redColor];
        view.layer.sublayerTransform = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
        [self addSubview:view];
        
        UILabel *view1 = [self getTestLabelWithFrame:CGRectMake(10, 10, 20, 20)];
        [view addSubview:view1];
        
        UILabel *view2 = [self getTestLabelWithFrame:CGRectMake(10, 40, 20, 20)];
        [view addSubview:view2];
    }
    
    // 图层的背面
    {
        UILabel *view1          = [self getTestLabelWithFrame:CGRectMake(10, 120, 100, 100)];
        view1.layer.doubleSided = YES;
        [self addSubview:view1];
        CABasicAnimation *ani1  = [self getAnimationWithKeyPath:@"transform.rotation.y" fromValue:@(0) toValue:@(M_PI * 2)];
        [view1.layer addAnimation:ani1 forKey:nil];
        
        UILabel *view2          = [self getTestLabelWithFrame:CGRectMake(120, 120, 100, 100)];
        view2.layer.doubleSided = NO;
        [self addSubview:view2];
        CABasicAnimation *ani2  = [self getAnimationWithKeyPath:@"transform.rotation.y" fromValue:@(0) toValue:@(M_PI * 2)];
        [view2.layer addAnimation:ani2 forKey:nil];
    }
    
    // 扁平化。当图层进行3d变换的时候会将它和它的子图层都扁平化到一个平面中，而对于平面的图层来说并没有发生旋转
    // 当2d旋转的时候，两次反向的旋转使inView回到初始状态
    {
        UIView *outView = [[UIView alloc] init];
        outView.frame = CGRectMake(20, 250, 100, 100);
        outView.backgroundColor = [UIColor redColor];
        outView.layer.transform = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
        [self addSubview:outView];
        
        UIView *inView = [[UIView alloc] init];
        inView.frame = CGRectMake(25, 25, 50, 50);
        inView.backgroundColor = [UIColor greenColor];
        inView.layer.transform = CATransform3DMakeRotation(-M_PI_4, 0, 0, 1);
        [outView addSubview:inView];
    }
    // 当3d旋转的时候，outView的旋转与inView的旋转无关
    {
        UIView *outView = [[UIView alloc] init];
        outView.frame = CGRectMake(250, 250, 100, 100);
        outView.backgroundColor = [UIColor redColor];
        CATransform3D transform1 = CATransform3DIdentity;
        transform1.m34 = -1.0 / 100;
        transform1 = CATransform3DRotate(transform1, M_PI_4, 0, 1, 0);
        outView.layer.transform = transform1;
        [self addSubview:outView];
        
        UIView *inView = [[UIView alloc] init];
        inView.frame = CGRectMake(25, 25, 50, 50);
        inView.backgroundColor = [UIColor greenColor];
        CATransform3D transform2 = CATransform3DIdentity;
        transform2.m34 = -1.0 / 100;
        transform2 = CATransform3DRotate(transform2, -M_PI_4, 0, 1, 0);
        inView.layer.transform = transform2;
        [outView addSubview:inView];
    }
}

#pragma mark - 固体对象

- (void)demo5 {
    self.backgroundColor            = [UIColor lightGrayColor];
    
    UIView *cube1 = [self cube1];
    cube1.center = CGPointMake(100, 100);
    [self addSubview:cube1];
    
    UIView *cube2 = [self cube2];
    cube2.center = CGPointMake(self.width - 100, 100);
    [self addSubview:cube2];
}

- (UIView *)cube1 {
    UIView *cubeView            = [[UIView alloc] init];
    cubeView.frame              = CGRectMake(0, 0, 100, 100);
    CATransform3D transform     = CATransform3DIdentity;
    transform.m34               = -1.0 / 500;
    transform                   = CATransform3DRotate(transform, -M_PI_4, 1, 0, 0);
    transform                   = CATransform3DRotate(transform, -M_PI_4, 0, 1, 0);
    cubeView.layer.sublayerTransform = transform;
    
    CATransform3D faceTransform     = CATransform3DIdentity;
    UIView *face                    = nil;
    
    // face 1
    faceTransform = CATransform3DMakeTranslation(0, 0, 50);
    face = [self faceWithTitle:@"1" tansform:faceTransform];
    [cubeView addSubview:face];
    [self applyLightingToFace:face.layer];
    
    // face 2
    faceTransform = CATransform3DMakeTranslation(0, 0, -50);
    faceTransform = CATransform3DRotate(faceTransform, M_PI, 0, 1, 0);
    face = [self faceWithTitle:@"2" tansform:faceTransform];
    [cubeView addSubview:face];
    [self applyLightingToFace:face.layer];
    
    // face 3
    faceTransform = CATransform3DMakeTranslation(-50, 0, 0);
    faceTransform = CATransform3DRotate(faceTransform, -M_PI_2, 0, 1, 0);
    face = [self faceWithTitle:@"3" tansform:faceTransform];
    [cubeView addSubview:face];
    [self applyLightingToFace:face.layer];
    
    // face 4
    faceTransform = CATransform3DMakeTranslation(50, 0, 0);
    faceTransform = CATransform3DRotate(faceTransform, M_PI_2, 0, 1, 0);
    face = [self faceWithTitle:@"4" tansform:faceTransform];
    [cubeView addSubview:face];
    [self applyLightingToFace:face.layer];
    
    // face 5
    faceTransform = CATransform3DMakeTranslation(0, -50, 0);
    faceTransform = CATransform3DRotate(faceTransform, M_PI_2, 1, 0, 0);
    face = [self faceWithTitle:@"5" tansform:faceTransform];
    [cubeView addSubview:face];
    [self applyLightingToFace:face.layer];
    
    // face 6
    faceTransform = CATransform3DMakeTranslation(0, 50, 0);
    faceTransform = CATransform3DRotate(faceTransform, -M_PI_2, 1, 0, 0);
    face = [self faceWithTitle:@"6" tansform:faceTransform];
    [cubeView addSubview:face];
    [self applyLightingToFace:face.layer];
    
    return cubeView;
}

- (UIView *)cube2 {
    UIView *cubeView            = [[UIView alloc] init];
    cubeView.frame              = CGRectMake(0, 0, 100, 100);
    CATransform3D transform     = CATransform3DIdentity;
    transform.m34               = -1.0 / 500;
    transform                   = CATransform3DRotate(transform, -M_PI_4, 1, 0, 0);
    transform                   = CATransform3DRotate(transform, -M_PI_4, 0, 1, 0);
    cubeView.layer.sublayerTransform = transform;
    
    CATransform3D faceTransform = CATransform3DIdentity;
    UIView *face                = nil;
    CABasicAnimation *ani       = nil;
    
    // face 1
    faceTransform = CATransform3DMakeTranslation(0, 0, 50);
    face = [self faceWithTitle:@"1" tansform:faceTransform];
    [cubeView addSubview:face];

    ani = [self getAnimationWithKeyPath:@"transform.rotation.z" fromValue:@(face.layer.transformRotationZ) toValue:@(face.layer.transformRotationZ + M_PI * 2)];
    [face.layer addAnimation:ani forKey:nil];

    // face 2
    faceTransform = CATransform3DMakeTranslation(0, 0, -50);
    faceTransform = CATransform3DRotate(faceTransform, M_PI, 0, 1, 0);
    face = [self faceWithTitle:@"2" tansform:faceTransform];
    [cubeView addSubview:face];

    ani = [self getAnimationWithKeyPath:@"transform.rotation.z" fromValue:@(face.layer.transformRotationZ) toValue:@(face.layer.transformRotationZ + M_PI * 2)];
    [face.layer addAnimation:ani forKey:nil];

    // face 3
    faceTransform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
    face = [self faceWithTitle:@"3" tansform:faceTransform];
    face.layer.anchorPointZ = -50;
    [cubeView addSubview:face];
    
    ani = [self getAnimationWithKeyPath:@"transform.rotation.z" fromValue:@(face.layer.transformRotationZ) toValue:@(face.layer.transformRotationZ + M_PI * 2)];
    [face.layer addAnimation:ani forKey:nil];

    // face 4
    faceTransform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
    face = [self faceWithTitle:@"4" tansform:faceTransform];
    face.layer.anchorPointZ = -50;
    [cubeView addSubview:face];
    
    ani = [self getAnimationWithKeyPath:@"transform.rotation.z" fromValue:@(face.layer.transformRotationZ) toValue:@(face.layer.transformRotationZ + M_PI * 2)];
    [face.layer addAnimation:ani forKey:nil];
    
    // face 5
    faceTransform = CATransform3DIdentity;
    faceTransform = CATransform3DMakeRotation(M_PI_2, 1, 0, 0);
    face = [self faceWithTitle:@"5" tansform:faceTransform];
    face.layer.anchorPointZ = -50;
    [cubeView addSubview:face];

    ani = [self getAnimationWithKeyPath:@"transform.rotation.z" fromValue:@(face.layer.transformRotationZ) toValue:@(face.layer.transformRotationZ + M_PI * 2)];
    [face.layer addAnimation:ani forKey:nil];

    // face 6
    faceTransform = CATransform3DMakeRotation(M_PI_2, 1, 0, 0);
    faceTransform = CATransform3DRotate(faceTransform, M_PI, 0, 1, 0);
    face = [self faceWithTitle:@"6" tansform:faceTransform];
    face.layer.anchorPointZ = -50;
    [cubeView addSubview:face];

    ani = [self getAnimationWithKeyPath:@"transform.rotation.z" fromValue:@(face.layer.transformRotationZ) toValue:@(face.layer.transformRotationZ + M_PI * 2)];
    [face.layer addAnimation:ani forKey:nil];
    
    return cubeView;
}

- (UIView *)faceWithTitle:(NSString *)title tansform:(CATransform3D)transform {
    UILabel *faceView           = [[UILabel alloc] init];
    faceView.text               = title;
    faceView.frame              = CGRectMake(0, 0, 100, 100);
    faceView.layer.transform    = transform;
    faceView.textAlignment      = NSTextAlignmentCenter;
    faceView.font               = [UIFont systemFontOfSize:50.0f];
    faceView.backgroundColor    = [UIColor whiteColor];
    faceView.layer.doubleSided  = YES;
    
    faceView.userInteractionEnabled = YES;
    [faceView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        UITapGestureRecognizer *tapGesture = (UITapGestureRecognizer *)sender;
        UILabel *label = (UILabel *)tapGesture.view;
        if (label && [label isKindOfClass:[UILabel class]]) {
            NSLog(@"点击了%@面", label.text);
        }
        /*
         此处会发现，虽然我们看到的是 1、4、5面，但是点击之后却打印点击了6面。
         
         这是因为点击事件的处理由视图在父视图中的顺序决定的，并不是3D空间中的Z轴顺序。
         且设置doubleSided为NO不会影响点击事件，设置hidden为YES或alpha为0才会影响点击事件
         */
    }]];
    return faceView;
}

- (void)applyLightingToFace:(CALayer *)faceLayer {
    // lighting layer
    CALayer *lightingLayer = [CALayer layer];
    lightingLayer.frame = faceLayer.bounds;
    [faceLayer addSublayer:lightingLayer];
    
    //convert the face transform to matrix
    //(GLKMatrix4 has the same structure as CATransform3D)
    //译者注：GLKMatrix4和CATransform3D内存结构一致，但坐标类型有长度区别，所以理论上应该做一次float到CGFloat的转换，感谢[@zihuyishi](https://github.com/zihuyishi)同学~
    CATransform3D transform = faceLayer.transform;
    GLKMatrix4 matrix4 = GLKMatrix4Make(transform.m11, transform.m12, transform.m13, transform.m14, transform.m21, transform.m22, transform.m23, transform.m24, transform.m31, transform.m32, transform.m33, transform.m34, transform.m41, transform.m42, transform.m43, transform.m44);
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
    //get face normal
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
    normal = GLKVector3Normalize(normal);
    //get dot product with light direction
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(0, 1, -0.5));
    float dotProduct = GLKVector3DotProduct(light, normal);
    //set lighting layer opacity
    CGFloat shadow = 1 + dotProduct - 0.5;
    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
    lightingLayer.backgroundColor = color.CGColor;
}

// ----------------------------------------------------------------------
#pragma mark - help method
// ----------------------------------------------------------------------

- (UILabel *)getTestLabelWithFrame:(CGRect)frame {
    UILabel *label          = [[UILabel alloc] init];
    label.frame             = frame;
    label.backgroundColor   = [UIColor greenColor];
    label.text              = @"zcp";
    label.textAlignment     = NSTextAlignmentCenter;
    return label;
}

- (CABasicAnimation *)getAnimationWithKeyPath:(NSString *)keyPath fromValue:(NSValue *)fromValue toValue:(NSValue *)toValue {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.duration          = 5.0f;
    animation.fromValue         = fromValue;
    animation.toValue           = toValue;
    animation.repeatCount       = INTMAX_MAX;
    return animation;
}

@end
