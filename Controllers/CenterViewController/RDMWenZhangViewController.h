//
//  RDMWenZhangViewController.h
//  ModelProduct
//
//  Created by apple on 16/8/19.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^RDMWenZhangViewControllerBlock)(void);
@interface RDMWenZhangViewController : BaseViewController

@property (nonatomic,copy)RDMWenZhangViewControllerBlock refreshEndBlock;

/**
 *  重新加载
 */
-(void)refrehData;


@end
