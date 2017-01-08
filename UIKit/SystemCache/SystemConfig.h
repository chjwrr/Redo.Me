//
//  SystemConfig.h
//  LoveYue
//
//  Created by apple on 15/4/8.
//  Copyright (c) 2015年 CHJ. All rights reserved.
//

#ifndef LoveYue_SystemConfig_h
#define LoveYue_SystemConfig_h


#import "SystemConfig.h"
#import "SystemCache.h"

#pragma  信息保存设置
#define   ksetDefaultValueForKey(value,key)  ([SystemCache setdefaultValue:value forKey:key])
#define   kgetDefaultValueForKey(key)        ([SystemCache getdefaultValueForKey:key])
#define   kremoveDefaultForKey(key)          ([SystemCache defaultRemoveValueForKey:key])


#endif
