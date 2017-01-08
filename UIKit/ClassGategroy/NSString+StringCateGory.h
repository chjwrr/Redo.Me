//
//  NSString+StringCateGory.h
//  好友动态列表
//
//  Created by apple on 15/4/20.
//  Copyright (c) 2015年 CHJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (StringCateGory)

/**
 *  返回字符串的高度
 *
 *  @param width 给定的字符串宽度
 *  @param font  给定的字符串字体大小
 *
 *  @return 返回字符串高度
 */
- (CGFloat)getStringHeightSizeWidth:(CGFloat)width WithFontSize:(NSInteger)font;

/**
 *  返回字符串的宽度
 *
 *  @param width 给定的字符串高度
 *  @param font  给定的字符串字体大小
 *
 *  @return 返回字符串宽度
 */
- (CGFloat)getStringWidthSizeHeight:(CGFloat)height WithFontSize:(NSInteger)font;

/**
 *  返回图片的后缀名
 *
 *  @param data 图片数据流
 *
 *  @return 返回图片格式类型
 */
- (NSString *)contentTypeForImageData:(NSData *)data;


@end
