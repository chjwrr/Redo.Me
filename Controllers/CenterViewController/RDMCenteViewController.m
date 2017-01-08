//
//  CenteViewController.m
//  ModelProduct
//
//  Created by apple on 16/8/19.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "RDMCenteViewController.h"

#import "RDMYuLuViewController.h"
#import "RDMWenZhangViewController.h"
#import "RDMSettingViewController.h"

@interface RDMCenteViewController ()

@property (nonatomic,strong)RDMYuLuViewController *yuluVCtrl;
@property (nonatomic,strong)RDMWenZhangViewController *wenzhangVCtrl;

@property (nonatomic,strong)BaseViewController *currentVCtrl;


@end

@implementation RDMCenteViewController

- (void)initDataSource {
    _currentVCtrl=[[BaseViewController alloc]init];
}
- (void)initSubViews {
    
    self.title=@"Redo.Me";
    
    self.view.backgroundColor=[UIColor redColor];
    
    [self initRithNavigationBarButtonWithImage:@"rdm_open"];
    
    self.rightNavBarBlock=^{
        [[NSNotificationCenter defaultCenter] postNotificationName:kshowRightMenu object:nil];

    };
    
    //接受改变右边按钮title的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRightMenuTitle:) name:kchangeRightMenuButton object:nil];
    
    [self addChildViewControllers];
}

/**
 *  接受改变右边按钮title
 *
 */
- (void)changeRightMenuTitle:(NSNotification *)tification {
    NSDictionary *diction=tification.userInfo;
    
    
    if ([kFormatterSring([diction objectForKey:@"key"]) isEqualToString:@"1"]) {
        [self initRithNavigationBarButtonWithImage:@"rdm_open"];
    }else{
        [self initRithNavigationBarButtonWithImage:@"rdm_close"];

    }
}


/**
 *  添加子控制器
 */
- (void)addChildViewControllers {
    _yuluVCtrl=[[RDMYuLuViewController alloc]init];
    [self addChildViewController:_yuluVCtrl];
    
    _wenzhangVCtrl=[[RDMWenZhangViewController alloc]init];
    [self addChildViewController:_wenzhangVCtrl];
    
    [self.view addSubview:_yuluVCtrl.view];
    
    [_yuluVCtrl didMoveToParentViewController:self];
    
    _currentVCtrl=_yuluVCtrl;
    
}

/**
 *  切换视图动画
 *
 *  常规动画属性设置（可以同时选择多个进行设置）
 
 UIViewAnimationOptionLayoutSubviews：动画过程中保证子视图跟随运动。
 
 UIViewAnimationOptionAllowUserInteraction：动画过程中允许用户交互。
 
 UIViewAnimationOptionBeginFromCurrentState：所有视图从当前状态开始运行。
 
 UIViewAnimationOptionRepeat：重复运行动画。
 
 UIViewAnimationOptionAutoreverse ：动画运行到结束点后仍然以动画方式回到初始点。
 
 UIViewAnimationOptionOverrideInheritedDuration：忽略嵌套动画时间设置。
 
 UIViewAnimationOptionOverrideInheritedCurve：忽略嵌套动画速度设置。
 
 UIViewAnimationOptionAllowAnimatedContent：动画过程中重绘视图（注意仅仅适用于转场动画）。
 
 UIViewAnimationOptionShowHideTransitionViews：视图切换时直接隐藏旧视图、显示新视图，而不是将旧视图从父视图移除（仅仅适用于转场动画）
 UIViewAnimationOptionOverrideInheritedOptions ：不继承父动画设置或动画类型。
 
 2.动画速度控制（可从其中选择一个设置）
 
 UIViewAnimationOptionCurveEaseInOut：动画先缓慢，然后逐渐加速。
 
 UIViewAnimationOptionCurveEaseIn ：动画逐渐变慢。
 
 UIViewAnimationOptionCurveEaseOut：动画逐渐加速。
 
 UIViewAnimationOptionCurveLinear ：动画匀速执行，默认值。
 
 3.转场类型（仅适用于转场动画设置，可以从中选择一个进行设置，基本动画、关键帧动画不需要设置）
 
 UIViewAnimationOptionTransitionNone：没有转场动画效果。
 
 UIViewAnimationOptionTransitionFlipFromLeft ：从左侧翻转效果。
 
 UIViewAnimationOptionTransitionFlipFromRight：从右侧翻转效果。
 
 UIViewAnimationOptionTransitionCurlUp：向后翻页的动画过渡效果。
 
 UIViewAnimationOptionTransitionCurlDown ：向前翻页的动画过渡效果。
 
 UIViewAnimationOptionTransitionCrossDissolve：旧视图溶解消失显示下一个新视图的效果。
 
 UIViewAnimationOptionTransitionFlipFromTop ：从上方翻转效果。
 
 UIViewAnimationOptionTransitionFlipFromBottom：从底部翻转效果。
 */
- (void)changeViewControll:(BaseViewController *)oldVC newViewController:(BaseViewController *)newVC {
    
    if (oldVC== newVC) {
        return;
    }
    
    
    [self transitionFromViewController:oldVC toViewController:newVC duration:0.15 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        
    } completion:^(BOOL finished) {
        if (finished) {
            self.currentVCtrl = newVC;
        }else
            self.currentVCtrl=newVC;
    
        
    }];
}

/**
 *  切换语录页面
 */
- (void)changeViewControllerToYuLuViewController {
    [self changeViewControll:self.currentVCtrl newViewController:self.yuluVCtrl];
    
    self.navigationItem.leftBarButtonItems=nil;
}

/**
 *  切换文章页面
 */
- (void)changeViewControllerToWenZhangViewController {
    [self changeViewControll:self.currentVCtrl newViewController:self.wenzhangVCtrl];
    
    [self initLeftNavigationBarButtonWithImage:@"rdm_refresh"];
    __weak RDMCenteViewController *weakself=self;
    self.leftNavBarBlock=^{
        [weakself initLeftNavigationBarAnimalButtonWithImage:@"rdm_refresh"];

        [weakself.wenzhangVCtrl refrehData];
    };
    self.wenzhangVCtrl.refreshEndBlock=^{
        [weakself initLeftNavigationBarButtonWithImage:@"rdm_refresh"];

    };
}

/**
 *  跳转设置页面
 */
- (void)jumpSettingVCtrl {
    RDMSettingViewController *settingVC=[[RDMSettingViewController alloc]init];
    [self.navigationController pushViewController:settingVC animated:YES];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
