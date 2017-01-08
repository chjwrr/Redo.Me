//
//  RightViewController.m
//  ModelProduct
//
//  Created by apple on 16/8/19.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "RDMRightViewController.h"

@interface RDMRightViewController ()


@end

@implementation RDMRightViewController
- (void)initSubViews {
    self.view.backgroundColor=[UIColor blueColor];

    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kright_space_width, kSCREEN_HEIGHT)];
    [self.view addSubview:imageView];
    imageView.contentMode=UIViewContentModeBottom;
    imageView.image=kImageName(@"rdm_right_bg_image");
    
    UIImageView *bgimageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kright_space_width, kSCREEN_HEIGHT)];
    [self.view addSubview:bgimageView];
    bgimageView.backgroundColor=[UIColor blackColor];
    bgimageView.alpha=0.7;
    
        
    UIButton *button1=[[UIButton alloc]initWithFrame:CGRectMake(0, kSCREEN_HEIGHT/2, kright_space_width, 60)];
    [self.view addSubview:button1];
    button1.tag=101;
    
    UILabel *lab_1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, button1.width, button1.height)];
    [button1 addSubview:lab_1];
    lab_1.text=@"一句情话\n一段回忆";
    lab_1.numberOfLines=0;
    lab_1.textColor=[UIColor whiteColor];
    lab_1.textAlignment=NSTextAlignmentCenter;
    
    UIButton *button2=[[UIButton alloc]initWithFrame:CGRectMake(0, button1.y+button1.height+20, button1.width, button1.height)];
    [self.view addSubview:button2];
    button2.tag=102;
    
    UILabel *lab_2=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, button2.width, button2.height)];
    [button2 addSubview:lab_2];
    lab_2.text=@"一篇文章\n一个曾经";
    lab_2.numberOfLines=0;
    lab_2.textColor=[UIColor whiteColor];
    lab_2.textAlignment=NSTextAlignmentCenter;

  
    //Redo.Me
    
    UIButton *button3=[[UIButton alloc]initWithFrame:CGRectMake(0, kSCREEN_HEIGHT-kright_space_width, kright_space_width, kright_space_width)];
    [self.view addSubview:button3];
    button3.tag=103;
    
    UILabel *lab_3=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, button3.width, button3.height)];
    [button3 addSubview:lab_3];
    lab_3.text=@"Redo.Me\n设置";
    lab_3.numberOfLines=0;
    lab_3.textColor=[UIColor whiteColor];
    lab_3.textAlignment=NSTextAlignmentCenter;

    
    [button1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [button2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [button3 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

}
- (void)buttonAction:(UIButton *)button {
    [_delegate didSelectRDMCenterAdnRightProtocolWithIndex:button.tag];
}


@end
