//
//  UIImage+Category.h
//  haofang
//
//  Created by Aim on 14-3-27.
//  Copyright (c) 2014年 平安好房. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)
//自定义长宽
- (UIImage *)reSizeImageToSize:(CGSize)reSize;
- (UIImage *)imageAtRect:(CGRect)rect;

/*!
 @method
 @abstract      图片大小调整
 @param         targetSize: 目标大小
 @discussion    按比例调整图片大小，以size中最大的边做依据调整
 @return        UIImage
 */
- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize;

/*!
 @brief  固定宽度
 */
- (UIImage *)imageByProportionallyScalingWidthTo:(CGFloat)length;
/*!
 @method
 @abstract      图片大小调整
 @param         targetSize: 目标大小
 @discussion    按比例调整图片大小
 @return        UIImage
 */
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;

/*!
 @method
 @abstract      图片大小调整
 @param         targetSize: 目标大小
 @discussion    强制调整图片大小，会造成图片比例失衡
 @return        UIImage
 */
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;


/*!
 @method
 @abstract      图片保持比例拉伸并保证最大一边不超过指定大小
 @param         length: 拉伸后最大一边的大小
 @discussion    拉伸的同时保证图片比例不变化
 @return        UIImage
 */
- (UIImage *)imageByProportionallyScalingMaximumEdgeTo: (CGFloat) length;

/*!
 @method
 @abstract      旋转图片
 @param         radians: 弧度值
 @discussion    根据弧度进行图片旋转
 @return        UIImage
 */
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;

/*!
 @method
 @abstract      旋转图片
 @param         degrees: 旋转的角度，单位是度数，0-360
 @discussion    根据度数进行图片旋转
 @return        UIImage
 */
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

/*!
 @method
 @abstract      合并两张图片
 @param         size: 合并的区域大小
 @param         overlayImage: 合并中盖在上层的图片
 @discussion    将两张图片合并成一张
 @return        UIImage
 */
- (UIImage *)getIconOfSize:(CGSize)size withOverlay:(UIImage *)overlayImage;

/*!
 @method
 @abstract      合并两个图片
 @param         rect: 合并的位置，大小
 @param         overlayImage: 覆盖层图片
 @discussion    合并两张图片
 @return        UIImage
 */
- (UIImage *)mergeRect:(CGRect)rect withOverlay:(UIImage *)overlayImage;

/*!
 @method
 @abstract      获取图片的每个点的颜色，以uicolor返回
 @param         image: 图片对象
 @param         xx: x坐标
 @param         yy: y坐标
 @param         count: 需要获取的像素点的个数
 @discussion
 @return        NSArray
 */
+ (NSArray*)getRGBAsFromImage:(UIImage*)image atX:(int)xx andY:(int)yy count:(int)count;

/*!
 @method
 @abstract      获取图片在某个像素点的alpha值
 @param         image: 图片对象
 @param         xx: x坐标
 @param         yy: y坐标
 @discussion
 @return        CGFloat
 */
+ (CGFloat)getAlphaFromImage:(UIImage*)image atX:(int)xx andY:(int)yy;

/*!
 @method
 @abstract      获取到一个图片的rgba值
 @param         image: image对象
 @discussion    通过这个方法可以获取到一个图片的每个像素点的rgba值，以c数组索引
 @return        指针
 */
+ (unsigned char *)getRawDataFromImage:(UIImage*)image;

// 判断两个图片是否是同一张图片
- (BOOL)isImageEqual:(UIImage *)image;

// 修复图片翻转问题（比如拍照，或者选择照片之后图片翻转）
- (UIImage *)fixOrientation;

/*!
 @method
 @abstract      给定颜色值获取一张图片
 @param         color: 图片颜色
 @discussion    给定一个颜色值，获取对应颜色值的图片
 @return        图片image
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
/*!
 @method
 @abstract      所有未加载出来的图片用统一样式
 @param         size:图片区域大小
 @discussion    主要处理图片未加载出来时候默认显示的问题
 @return        UIImage
 */
+ (UIImage *)defaultImageWithCGSize:(CGSize )size;
@end

@interface UIImage (ResizableImage)
/*!
 @method
 @abstract      图片比例拉伸方法，适配了iOS 6以下以及以上
 @param         insets: 拉伸固定边距
 @discussion    主要处理stretchableImageWithLeftCapWidth方法过期的问题
 @return        UIImage
 */
- (UIImage*) resizableImage:(UIEdgeInsets)insets;
@end


@interface UIImage (Grayscale)
/**
 *	@brief	Create a partially displayed image
 *
 *	@param 	percentage 	This defines the part to be displayed as original
 *	@param 	vertical 	If YES, the image is displayed bottom to top; otherwise left to right
 *	@param 	grayscaleRest 	If YES, the non-displaye part are in grayscale; otherwise in transparent
 *
 *	@return	A generated UIImage instance
 */
- (UIImage *) partialImageWithPercentage:(float)percentage vertical:(BOOL)vertical grayscaleRest:(BOOL)grayscaleRest;

@end


#define LOAD_SYNCHRONOUSLY 0 // Synchronous load is less code, easier to write - but poor for large images

#define ALLOW_2X_STYLE_SCALING_OF_SVGS_AS_AN_EXAMPLE 1 // demonstrates using the "SVGKImage.scale" property to scale an SVG *before it generates output image data*

#define ALLOW_SVGKFASTIMAGEVIEW_TO_DO_HIT_TESTING 1 // only exists because people ignore the docs and try to do this when they clearly shouldn't. If you're foolish enough to do this, this code will show you how to do it CORRECTLY. Look how much code this requires! It's insane! Use SVGKLayeredImageView instead if you need hit-testing!

#define SHOW_DEBUG_INFO_ON_EACH_TAPPED_LAYER 1 // each time you tap and select a layer, that layer's info is displayed on-screen
