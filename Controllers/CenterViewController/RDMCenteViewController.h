//
//  CenteViewController.h
//  ModelProduct
//
//  Created by apple on 16/8/19.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseViewController.h"

@interface RDMCenteViewController : BaseViewController

/**
 *  切换语录页面
 */
- (void)changeViewControllerToYuLuViewController;

/**
 *  切换文章页面
 */
- (void)changeViewControllerToWenZhangViewController;

/**
 *  跳转设置页面
 */
- (void)jumpSettingVCtrl;

@end
