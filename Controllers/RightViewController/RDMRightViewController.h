//
//  RightViewController.h
//  ModelProduct
//
//  Created by apple on 16/8/19.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseViewController.h"
#import "RDMCenterAdnRightDelegate.h"

@interface RDMRightViewController : BaseViewController

@property (nonatomic,weak)id<RDMCenterAdnRightProtocol>delegate;

@end
