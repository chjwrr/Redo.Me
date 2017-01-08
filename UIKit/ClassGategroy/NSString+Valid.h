/************************************************************
 *  * EaseMob CONFIDENTIAL
 * __________________
 * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of EaseMob Technologies.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from EaseMob Technologies.
 */

#import <Foundation/Foundation.h>

@interface NSString (Valid)

/**
 *  判断是不是中文
 *
 *  @return 返回YES or NO
 */
-(BOOL)isChinese;

/**
 *  判断字符串是否为空
 *
 *  @return 返回YES or NO
 */
- (BOOL)isEmpty;

/**
 *  判断是否是邮箱
 *
 *  @return 返回YES or NO
 */
- (BOOL)isEmail;

/**
 *  判断是否是手机号
 *
 *  @return 返回YES or NO
 */
- (BOOL)isMobilePhone;

/**
 *  删除含有表情的字符串
 *
 *  @return 返回删除表情后的字符串
 */
- (NSString *)fromatterHasEmojiString;

/**
 *  得到一个富文本字符串
 *
 *  @param font  字体大小
 *  @param range 字符串范围
 *
 *  @return 返回富文本字符串
 */
- (NSMutableAttributedString *)getAttributeStringWithFont:(NSInteger)font WithRange:(NSRange)range;

/**
 *  得到一个范围内有颜色的富文本字符串
 *
 *  @param color 文本颜色
 *  @param range 文本范围
 *
 *  @return 返回一个范围内有颜色的富文本字符串
 */
- (NSMutableAttributedString *)setStringRangeColor:(UIColor *)color Range:(NSRange)range;


/**
 *  格式化时间
 *
 *  @return 返回几天前、几小时前、几分钟前等类型的字符串
 */
- (NSString *)formatterTime;

@end
