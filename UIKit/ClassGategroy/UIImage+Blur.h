//
//  UIImage+Blur.h
//  ModelProduct
//
//  Created by apple on 16/4/29.
//  Copyright © 2016年 chj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Blur)

- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;


/**
 *  添加毛玻璃效果
 *
 *  @param blurRadius            模糊半径
 *  @param tintColor             模糊颜色
 *  @param saturationDeltaFactor 饱和度
 *  @param maskImage             掩盖图
 *
 *  @return 返回模糊图片
 */
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;


/**
 *  获取屏幕截图
 *
 *  @param view 所需要截图的view
 *
 *  @return 返回截图
 */
- (UIImage *)getScreenImage:(UIView *)view;


/**
 *  返回圆角的图片
 *
 *  @param cornerRadius            圆角弧度
 *
 *  @return 返回一张圆角图片
 */
- (UIImage *)cutCircleImageCornersSize:(float)cornerRadius;

@end
