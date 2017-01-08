//
//  RDMYuLuCell.m
//  ModelProduct
//
//  Created by apple on 16/8/23.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "RDMYuLuCell.h"
#import "RDMYuLuModel.h"
#import "RDMCopyLabel.h"

#define kbottom_height   44

#define kspace_height   5

@interface RDMYuLuCell ()

@property (nonatomic,strong)UIImageView *imageV;
@property (nonatomic,strong)RDMCopyLabel *lab_content;
@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIView *labelView;

@property (nonatomic,strong)UIButton *btn_down;
@property (nonatomic,strong)UIButton *btn_share;

@end

@implementation RDMYuLuCell

- (void)initSubViews {
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    self.backgroundColor=kColorHexString(@"ededed");
    
    _imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, kspace_height, kSCREEN_WIDTH, 200)];
    [self addSubview:_imageV];
    _imageV.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headTap:)];
    [_imageV addGestureRecognizer:tap];
    
    _labelView=[[UIView alloc]initWithFrame:CGRectMake(0, _imageV.height+_imageV.y, kSCREEN_WIDTH, 80)];
    [self addSubview:_labelView];
    _labelView.backgroundColor=[UIColor whiteColor];

    _lab_content=[[RDMCopyLabel alloc]initWithFrame:CGRectMake(10, 0, kSCREEN_WIDTH-20, 80)];
    [_labelView addSubview:_lab_content];
    _lab_content.numberOfLines=0;
    _lab_content.font=kSYS_FONT(14);
    
    _bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, _labelView.height+_labelView.y, kSCREEN_WIDTH, kbottom_height)];
    [self addSubview:_bottomView];
    _bottomView.backgroundColor=[UIColor whiteColor];
    
    _btn_down=[[UIButton alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-44-20, 0, 44, 44)];
    [_bottomView addSubview:_btn_down];
    [_btn_down setImage:kImageName(@"rdm_down") forState:UIControlStateNormal];
    [_btn_down addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _btn_share=[[UIButton alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-20-44-20-44, 0, 44, 44)];
    [_bottomView addSubview:_btn_share];
    [_btn_share setImage:kImageName(@"rdm_share") forState:UIControlStateNormal];
    [_btn_share addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)setIsHiddent:(BOOL)isHiddent {
    _imageV.hidden=isHiddent;
}

- (void)cellForData:(id)data {
    _imageV.tag=self.tag+1;
    
    _btn_down.tag=self.tag+2;
    _btn_share.tag=self.tag+3;
    
    RDMYuLuModel *model=(RDMYuLuModel *)data;

    CGFloat imageH=kFormatterSring(model.imageHeight).floatValue;
    CGFloat imageW=kFormatterSring(model.imageWidht).floatValue;
    CGFloat height=kSCREEN_WIDTH*imageH/imageW;
    
    _imageV.frame=CGRectMake(0, kspace_height, kSCREEN_WIDTH, height);
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:kFormatterSring(model.imageURL)]];
    
    CGFloat contentH=[model.content getStringHeightSizeWidth:kSCREEN_WIDTH-20 WithFontSize:14]+20;
    _labelView.frame=CGRectMake(0, _imageV.height+_imageV.y, kSCREEN_WIDTH, contentH);
    _lab_content.frame=CGRectMake(10, 0, kSCREEN_WIDTH-20, contentH);

    self.lab_content.text=model.content;
    
    _bottomView.frame=CGRectMake(0, _labelView.height+_labelView.y, kSCREEN_WIDTH, kbottom_height);
    
}

+ (CGFloat)cellHeightForData:(id)data {
    RDMYuLuModel *model=(RDMYuLuModel *)data;
    
    CGFloat imageH=kFormatterSring(model.imageHeight).floatValue;
    CGFloat imageW=kFormatterSring(model.imageWidht).floatValue;
    CGFloat height=kSCREEN_WIDTH*imageH/imageW;
    
    CGFloat contentH=[model.content getStringHeightSizeWidth:kSCREEN_WIDTH-20 WithFontSize:14]+20;
    
    return kspace_height+height+contentH+kbottom_height+kspace_height;
}
//点击图片
- (void)headTap:(UITapGestureRecognizer *)tap {
    [_delegate didSelectRDMYuLuCellheadImage:tap.view.tag/10];
}

//点击分享、下载
- (void)buttonAction:(UIButton *)button {
    [_delegate didSelectRDMYuLuCellIndex:button.tag/10 ItemIndex:button.tag-self.tag];
}

@end
