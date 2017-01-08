//
//  LocationManager.h
//  ModelProduct
//
//  Created by apple on 16/1/13.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationManager : NSObject

+ (id)shareInStance;

- (void)startUserLocation;

- (void)stopUserLocation;
@end
