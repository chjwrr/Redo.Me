//
//  SystemCache.m
//  LoveYue
//
//  Created by apple on 15/4/8.
//  Copyright (c) 2015年 CHJ. All rights reserved.
//

#import "SystemCache.h"

#define  kUSERDEFALUT     [NSUserDefaults standardUserDefaults]

@implementation SystemCache


+ (void)setdefaultValue:(NSObject *)value forKey:(NSString *)key {
    if (value == [NSNull null]) {
        NSString *val=@"";
        [kUSERDEFALUT setObject:val forKey:key];
    }else
        [kUSERDEFALUT setObject:value forKey:key];
    
    [kUSERDEFALUT synchronize];
}

+ (NSObject *)getdefaultValueForKey:(NSString *)key {
    NSObject *value=[kUSERDEFALUT objectForKey:key];
    if (value == [NSNull null]) {
        value=[NSString string];
        return value;
    }else
        return value;
}
+ (void)defaultRemoveValueForKey:(NSString *)key {
    if (key && ![key isEqualToString:@""]) {
        [kUSERDEFALUT removeObjectForKey:key];
    }
    [kUSERDEFALUT synchronize];
}
@end
