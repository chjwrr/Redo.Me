//
//  BaseViewController.m
//  ModelProduct
//
//  Created by chj on 15/12/13.
//  Copyright (c) 2015年 chj. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"


@interface BaseViewController ()
@property (nonatomic,strong)MJRefreshNormalHeader *header;
@property (nonatomic,strong)MJRefreshBackNormalFooter *footer;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    if (kIOS_VERSION >= 7.0) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//        self.extendedLayoutIncludesOpaqueBars = NO;
//        self.modalPresentationCapturesStatusBarAppearance = NO;
//    }
//    

    /*
     
     在隐藏导航条的页面重写下面的方法
     
     - (BOOL)fd_prefersNavigationBarHidden {
        return YES;
     }
     
     */
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self initDataSource];
    
    [self initSubViews];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)initDataSource {
    
}
- (void)initSubViews {
    
}

- (void)initLeftNavigationBarButton {
    UIButton *btn_left=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btn_left addTarget:self action:@selector(BackAction) forControlEvents:UIControlEventTouchUpInside];
    [btn_left setImage:[UIImage imageNamed:@"rdm_back"] forState:UIControlStateNormal];

    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithCustomView:btn_left];
    
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width=-10;
    
    
    self.navigationItem.leftBarButtonItems=@[space,bar];
}

- (void)initLeftNavigationBarAnimalButtonWithImage:(NSString *)imageName {
    UIButton *_btn_left=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [_btn_left setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [_btn_left addTarget:self action:@selector(BackAction) forControlEvents:UIControlEventTouchUpInside];
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAX_CANON;
    
    [_btn_left.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithCustomView:_btn_left];
    
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width=-10;
    
    
    self.navigationItem.leftBarButtonItems=@[space,bar];
}

- (void)initLeftNavigationBarButtonWithImage:(NSString *)imageName {
    UIButton *_btn_left=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [_btn_left setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [_btn_left addTarget:self action:@selector(BackAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithCustomView:_btn_left];
    
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width=-10;
    
    
    self.navigationItem.leftBarButtonItems=@[space,bar];
}

- (void)initLeftNavigationBarButtonWithtTitle:(NSString *)title {
    UIButton *btn_left=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btn_left setTitle:title forState:UIControlStateNormal];
    btn_left.titleLabel.font=kSYS_FONT(14);

    [btn_left addTarget:self action:@selector(BackAction) forControlEvents:UIControlEventTouchUpInside];
    [btn_left setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithCustomView:btn_left];
    
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width=-10;
    
    
    self.navigationItem.leftBarButtonItems=@[space,bar];
}


- (void)initRithNavigationBarButtonWithTitle:(NSString *)title {
    UIButton *btn_right=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btn_right setTitle:title forState:UIControlStateNormal];
    [btn_right addTarget:self action:@selector(RightAction) forControlEvents:UIControlEventTouchUpInside];
    [btn_right setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn_right.titleLabel.font=kSYS_FONT(14);
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithCustomView:btn_right];
    
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width=-10;
    
    
    self.navigationItem.rightBarButtonItems=@[space,bar];
}

- (void)initRithNavigationBarButtonWithImage:(NSString *)imageName {
    UIButton *btn_right=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btn_right setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn_right addTarget:self action:@selector(RightAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithCustomView:btn_right];
    
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width=-10;
    
    
    self.navigationItem.rightBarButtonItems=@[space,bar];
}

- (void)initRithNavigationBarButtonWithDoubleImage:(NSString *)imageName1 otherImage:(NSString *)imageName2 {
    UIButton *btn_right=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    btn_right.tag=101;
    //[btn_right setImage:[UIImage imageNamed:imageName1] forState:UIControlStateNormal];
    [btn_right addTarget:self action:@selector(doubleRightAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btn_right1=[[UIButton alloc]initWithFrame:CGRectMake(44, 0, 44, 44)];
    [btn_right1 setBackgroundColor:[UIColor greenColor]];
    //[btn_right1 setImage:[UIImage imageNamed:imageName1] forState:UIControlStateNormal];
    [btn_right1 addTarget:self action:@selector(doubleRightAction:) forControlEvents:UIControlEventTouchUpInside];
    btn_right1.tag=100;

    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithCustomView:btn_right];
    UIBarButtonItem *bar1=[[UIBarButtonItem alloc]initWithCustomView:btn_right1];

    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width=-10;
    
    
    self.navigationItem.rightBarButtonItems=@[space,bar,space,bar1,space];
}

- (void)BackAction {
    self.leftNavBarBlock();
}
- (void)RightAction {
    self.rightNavBarBlock();
}
- (void)doubleRightAction:(UIButton *)button {
    if (button.tag == 100) {
        self.rightNavBarBlockLeft();
    }else
        self.rightNavBarBlockRight();
        
}


//tableview下拉刷新  上拉加载

/*
 self.tableview.mj_header=[self addTableViewRefreshHeaderWithTarget:self action:@selector(headerRefresh)];
 self.tableview.mj_footer=[self addTableViewRefreshFooterWithTarget:self action:@selector(footerRefresh)];

 */
- (MJRefreshNormalHeader *)addTableViewHeaderRefreshingTarget:(id)target refreshingAction:(SEL)action {
    _header=[MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
    return _header;
}

- (MJRefreshBackNormalFooter *)addTableViewFooterRefreshingTarget:(id)target refreshingAction:(SEL)action {
    _footer=[MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
    return _footer;
}
- (void)headerRefreshHiddent:(BOOL)hiddent {
    self.header.hidden=hiddent;
}
- (void)footerRefreshHiddent:(BOOL)hiddent {
    self.footer.hidden=hiddent;
}
- (void)headerEndRefresh {
    [self.header endRefreshing];
}
- (void)footerEndRefresh {
    [self.footer endRefreshing];
}
- (void)endRefresh {
    [self.header endRefreshing];
    [self.footer endRefreshing];
}


- (void)showMessage:(NSString *)msg {
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = msg;
    // 再设置模式
    hud.mode = MBProgressHUDModeText;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:1];
}


@end
