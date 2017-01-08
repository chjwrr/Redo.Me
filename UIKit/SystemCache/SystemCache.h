//
//  SystemCache.h
//  LoveYue
//
//  Created by apple on 15/4/8.
//  Copyright (c) 2015年 CHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemCache : NSObject
+ (void)setdefaultValue:(NSObject *)value forKey:(NSString *)key ;
+ (NSObject *)getdefaultValueForKey:(NSString *)key ;
+ (void)defaultRemoveValueForKey:(NSString *)key ;
@end
