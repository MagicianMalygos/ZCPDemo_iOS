//
//  CAEAGLDemoView.m
//  Demo
//
//  Created by 朱超鹏 on 2018/8/20.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "CAEAGLDemoView.h"
#import <GLKit/GLKit.h>
#import <OpenGLES/EAGL.h>

@interface CAEAGLDemoView ()

@property (nonatomic, strong) EAGLContext *glContext;
@property (nonatomic, strong) CAEAGLLayer *glLayer;
@property (nonatomic, assign) GLuint framebuffer;
@property (nonatomic, assign) GLuint colorRenderbuffer;
@property (nonatomic, assign) GLint framebufferWidth;
@property (nonatomic, assign) GLint framebufferHeight;
@property (nonatomic, strong) GLKBaseEffect *effect;

@end

@implementation CAEAGLDemoView

// ----------------------------------------------------------------------
#pragma mark - life cycle
// ----------------------------------------------------------------------

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview == nil) {
        [self tearDownBuffers];
    }
}

- (void)dealloc {
    [self tearDownBuffers];
    [EAGLContext setCurrentContext:nil];
}

// ----------------------------------------------------------------------
#pragma mark - setup
// ----------------------------------------------------------------------

- (void)setup {
    // 初始化上下文
    self.glContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:self.glContext];
    
    // 初始化图层
    self.glLayer                    = [CAEAGLLayer layer];
    self.glLayer.frame              = self.bounds;
    [self.layer addSublayer:self.glLayer];
    self.glLayer.drawableProperties = @{kEAGLDrawablePropertyRetainedBacking: @NO,
                                        kEAGLDrawablePropertyColorFormat: kEAGLColorFormatRGBA8};
    
    // 初始化效果
    self.effect = [[GLKBaseEffect alloc] init];
    
    // 初始化缓冲
    [self setupBuffers];
    
    // 绘制
    [self drawFrame];
}

- (void)setupBuffers {
    // 初始化帧缓冲
    glGenFramebuffers(1, &_framebuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
    
    // 初始化颜色绘制缓冲
    glGenRenderbuffers(1, &_colorRenderbuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderbuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _colorRenderbuffer);
    [self.glContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:self.glLayer];
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &_framebufferWidth);
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &_framebufferHeight);
    
    // 检查是否成功
    if (glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE) {
        NSLog(@"Failed to make complete framebuffer object: %i", glCheckFramebufferStatus(GL_FRAMEBUFFER));
    }
}

- (void)drawFrame {
    // 绑定帧缓冲，设置视口
    glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
    glViewport(0, 0, _framebufferWidth, _framebufferHeight);
    
    // 绑定着色器
    [self.effect prepareToDraw];
    
    // 清除屏幕
    glClear(GL_COLOR_BUFFER_BIT);
    glClearColor(0.0, 0.0, 0.0, 1.0);
    
    // 初始化顶点vertices
    GLfloat vertices[] = {
        -0.5f, -0.5f, -1.0f,
        0.0f, 0.5f, -1.0f,
        0.5f, -0.5f, -1.0f
    };
    
    // 初始化颜色
    GLfloat colors[] = {
        0.0f, 0.0f, 1.0f, 1.0f,
        0.0f, 1.0f, 0.0f, 1.0f,
        1.0f, 0.0f, 0.0f, 1.0f
    };
    
    // 画三角形
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 0, vertices);
    glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, 0, colors);
    glDrawArrays(GL_TRIANGLES, 0, 3);
    
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderbuffer);
    [self.glContext presentRenderbuffer:GL_RENDERBUFFER];
}

- (void)tearDownBuffers {
    if (_framebuffer) {
        // 删除缓冲
        glDeleteFramebuffers(1, &_framebuffer);
        _framebuffer = 0;
    }
    if (_colorRenderbuffer) {
        // 删除颜色绘制缓冲
        glDeleteRenderbuffers(1, &_colorRenderbuffer);
        _colorRenderbuffer = 0;
    }
}

@end
