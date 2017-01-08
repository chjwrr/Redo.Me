//
//  BaseNavigationController.m
//  ModelProduct
//
//  Created by chj on 15/12/13.
//  Copyright (c) 2015年 chj. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.translucent=NO;
    self.navigationBar.titleTextAttributes=@{NSFontAttributeName:kSYS_FONT(20),NSForegroundColorAttributeName:[UIColor blackColor]};

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
