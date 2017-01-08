//
//  NSString+StringCateGory.m
//  好友动态列表
//
//  Created by apple on 15/4/20.
//  Copyright (c) 2015年 CHJ. All rights reserved.
//

#import "NSString+StringCateGory.h"

@implementation NSString (StringCateGory)



- (CGFloat)getStringHeightSizeWidth:(CGFloat)width WithFontSize:(NSInteger)font{
    CGSize size=[self boundingRectWithSize:CGSizeMake(width, 2000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    return size.height;
}


- (CGFloat)getStringWidthSizeHeight:(CGFloat)height WithFontSize:(NSInteger)font{
    CGSize size=[self boundingRectWithSize:CGSizeMake(2000, height) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    return size.width;
}


//通过图片Data数据第一个字节 来获取图片扩展名
- (NSString *)contentTypeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
        case 0x4D:
            return @"tiff";
        case 0x52:
            if ([data length] < 12) {
                return nil;
            }
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"webp";
            }
            return nil;
    }
    return nil;
}

@end
