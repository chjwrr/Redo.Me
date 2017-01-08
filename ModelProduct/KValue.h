//
//  KValue.h
//  聚美商城
//
//  Created by apple on 13-11-29.
//  Copyright (c) 2013年 常会军. All rights reserved.
//

#import <Foundation/Foundation.h>


#define kAPP_System_Version       [[[UIDevice currentDevice] systemVersion] floatValue]

#define kAPP_Bundle_Version       [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define kDevice_Model             [[UIDevice currentDevice] model]



#define kSCREEN_HEIGHT            [UIScreen mainScreen].bounds.size.height

#define kSCREEN_WIDTH             [UIScreen mainScreen].bounds.size.width



#define kTABBAR_HEIGHT            49

#define kNAVIGATIONBAR_HEIGHT     44

#define kSTATUSBAR_HEIGHT         20



#define iPhone4      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6Plus  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)



#define kAPPDELEGATE (AppDelegate *)[UIApplication sharedApplication].delegate



#define kOPEN_URL(url)                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]]

#define kCALL_PHONE(numberphone)                  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",numberphone]]]

#define kSEND_MESSAGE_PHONE(numberphone)          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",numberphone]]]




#define kSYS_FONT(x)               [UIFont systemFontOfSize:x]

#define kSYS_BOLDFONT(x)           [UIFont boldSystemFontOfSize:x]

#define kColorWithRGB(R,G,B,ALPHA) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:ALPHA]

#define kColorHexString(color)     [UIColor hx_colorWithHexRGBAString:color]

#define kFormatterSring(string)    [NSString stringWithFormat:@"%@",string]

#define kFormatterInt(value)       [NSString stringWithFormat:@"%ld",value]

#define kFormatterFloat(value)     [NSString stringWithFormat:@"%f",value]

#define kImageName(imageName)      [UIImage imageNamed:imageName]

