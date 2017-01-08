//
//  MWDViewController.m
//  ModelProduct
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "RDMHomeViewController.h"
#import "RDMCenteViewController.h"
#import "RDMRightViewController.h"
#import "BaseNavigationController.h"
#import "RDMCenterAdnRightDelegate.h"

@interface RDMHomeViewController ()<RDMCenterAdnRightProtocol>

@property (nonatomic,strong)RDMCenteViewController *centerVCtrl;
@property (nonatomic,strong)RDMRightViewController *rightVCtrl;

@property (nonatomic,strong) BaseNavigationController *centerNavCtl;

@property (nonatomic,strong) UIView *centerView;
@property (nonatomic,strong) UIView *rightView;

@property (nonatomic)BOOL isOpen;

@end

@implementation RDMHomeViewController

-(id)initWithCenterViewController:(BaseViewController *)centerVC WithRightViewController:(BaseViewController *)rightVC {
    self=[super init];
    if (self) {
        
        self.centerVCtrl = (RDMCenteViewController *)centerVC;
        
        self.rightVCtrl = (RDMRightViewController *)rightVC;
        
        self.centerNavCtl = [[BaseNavigationController alloc]initWithRootViewController:centerVC];
        
        
        //主页点击右边按钮出来右侧视图通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animalShowNormal) name:kshownormalMenu object:nil];
        //主页点击右边按钮出来右侧视图通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRightView:) name:kshowRightMenu object:nil];
        
    }
    return self;
}

- (void)initDataSource {
    self.rightVCtrl.delegate=self;
    
}

- (void)initSubViews{
    
    [self.view addSubview:self.centerView];
    [self.view addSubview:self.rightView];
    
    [self addRightPanGestureRecognizer];
    
    [self addTapGestureRecognizerWithCenterView];
}


- (UIView *)centerView {
    if (_centerView == nil) {
        
        _centerView=[[UIView alloc]initWithFrame:self.view.bounds];
        
        self.centerNavCtl.view.frame=self.view.bounds;
        
        [_centerView addSubview:self.centerNavCtl.view];//中间的view加载的导航控制器的view
        
        [self addChildViewController:self.centerNavCtl];
        
        [self.centerNavCtl didMoveToParentViewController:self];
    }
    return _centerView;
}

- (UIView *)rightView {
    if (_rightView == nil) {
        
        _rightView=[[UIView alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
        
        self.rightVCtrl.view.frame=self.view.bounds;
        
        [_rightView addSubview:self.rightVCtrl.view];
        
        [self addChildViewController:self.rightVCtrl];
        
        [self.rightVCtrl willMoveToParentViewController:self];
    }
    return _rightView;
}

/**
 *  添加左滑手势，显示右侧视图
 */
- (void)addRightPanGestureRecognizer {
    
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognizerRightMenu:)];
    self.view.userInteractionEnabled=YES;
    [self.view addGestureRecognizer:pan];
}

/**
 *  给centerView添加点击手势，点击隐藏右侧视图
 */
- (void)addTapGestureRecognizerWithCenterView {
    
    UITapGestureRecognizer *tapGestureRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognizer:)];
    self.centerView.userInteractionEnabled=YES;
    [self.centerView addGestureRecognizer:tapGestureRecognizer];
}

/**
 *  点击手势触发事件
 */
- (void)tapGestureRecognizer:(UITapGestureRecognizer *)tapGestureRecognizer {
    if (self.isOpen) {
        [self animalShowNormal];
    }
}

/**
 *  拖动手势触发事件
 */
- (void)panGestureRecognizerRightMenu:(UIPanGestureRecognizer *)recognizer {
    if (![self.centerNavCtl.visibleViewController isKindOfClass:[RDMCenteViewController class]]) {
    }else{
        if (!self.isOpen) {
            CGPoint translatedPoint = [recognizer translationInView:self.view];
                        
            if ([(UIPanGestureRecognizer *)recognizer state] == UIGestureRecognizerStateBegan) {
                
                
                
            }
            
            if ([(UIPanGestureRecognizer *)recognizer state] == UIGestureRecognizerStateChanged) {
                
                if (translatedPoint.x <=-10 && translatedPoint.x >=-kright_space_width) {
                    self.centerView.frame=CGRectMake(translatedPoint.x, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
                    self.rightView.frame=CGRectMake(kSCREEN_WIDTH+translatedPoint.x, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
                }
                
            }
            
            if (([(UIPanGestureRecognizer *)recognizer state] == UIGestureRecognizerStateEnded) || ([(UIPanGestureRecognizer *)recognizer state] == UIGestureRecognizerStateCancelled)) {
                
                if (translatedPoint.x <-kright_space_width/2) {
                    
                    [self animalShowRightView];
                    
                }else{
                    [self animalShowNormal];
                }
                
                
            }
            
        }
    }
}

/**
 *  动画回到原始状态
 */
- (void)animalShowNormal {
    [UIView animateWithDuration:0.15 animations:^{
        self.centerView.frame=CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
        self.rightView.frame=CGRectMake(kSCREEN_WIDTH, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        if (finished) {
            self.isOpen=NO;
        }
    }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kchangeRightMenuButton object:nil userInfo:@{@"key":@YES}];
    
}

/**
 *  动画显示右侧视图
 */
- (void)animalShowRightView {
    [UIView animateWithDuration:0.15 animations:^{
        self.centerView.frame=CGRectMake(-kright_space_width, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
        self.rightView.frame=CGRectMake(kSCREEN_WIDTH-kright_space_width, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        if (finished) {
            self.isOpen=YES;
        }
    }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kchangeRightMenuButton object:nil userInfo:@{@"key":@NO}];
    
}

/**
 *  接受右侧按钮的通知
 *
 *  @param tification 显示右侧视图
 */
- (void)showRightView:(NSNotification *)tification {
    
    if (self.isOpen) {
        [self animalShowNormal];
        
    }else{
        [self animalShowRightView];
    }
    
}
/**
 *  RDMCenterAdnRightProtocol
 *
 *  @param index 右边点击语录、文章、设置
 */
- (void)didSelectRDMCenterAdnRightProtocolWithIndex:(NSInteger)index {
    [self animalShowNormal];

    if (index == 101) {
        [self.centerVCtrl changeViewControllerToYuLuViewController];
    }else if (index == 102) {
        [self.centerVCtrl changeViewControllerToWenZhangViewController];
    }else{
        [self.centerVCtrl jumpSettingVCtrl];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
