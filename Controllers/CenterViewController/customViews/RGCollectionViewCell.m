//
//  RGCollectionViewCell.m
//  RGCardViewLayout
//
//  Created by ROBERA GELETA on 1/23/15.
//  Copyright (c) 2015 ROBERA GELETA. All rights reserved.
//

#define left_space_width   10
#define top_space_height   10

#define center_space_height   20
#define bottom_space_height   10

#import "RGCollectionViewCell.h"
#import "RDMWenZhangModel.h"

@implementation RGCollectionViewCell

- (UIImageView *)imageview {
    if (_imageview == nil) {
        _imageview =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _imageview.contentMode=UIViewContentModeScaleAspectFill;
        _imageview.layer.masksToBounds=YES;
        
        _imageview.userInteractionEnabled=YES;
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headTap:)];
        [_imageview addGestureRecognizer:tap];

        
        self.layer.shadowColor = [UIColor blackColor].CGColor;//阴影颜色
        self.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
        self.layer.shadowOpacity = 0.5;//不透明度
        self.layer.shadowRadius = 5.0;//半径
        self.backgroundColor=[UIColor whiteColor];

        [self addSubview:_imageview];
    }
    return _imageview;
}


- (UIView *)bottomView {
    if (_bottomView== nil) {
        
        _bottomView =[[UIView alloc]initWithFrame:CGRectMake(0, self.imageview.frame.size.height-20-top_space_height*2, self.imageview.frame.size.width,40)];
        
        UIView *bgiview =[[UIView alloc]initWithFrame:CGRectMake(0, 0, _bottomView.frame.size.width,_bottomView.frame.size.height)];
        bgiview.backgroundColor=[UIColor blackColor];
        bgiview.alpha=0.5;
        
        [_bottomView addSubview:bgiview];

        
        [self.imageview addSubview:_bottomView];
        
    }
    return _bottomView;
    
}
- (UILabel *)lab_title {
    if (_lab_title == nil) {
        
        _lab_title =[[UILabel alloc]initWithFrame:CGRectMake(left_space_width,top_space_height,self.bottomView.frame.size.width-left_space_width*2,20)];
        _lab_title.numberOfLines=0;
        _lab_title.textColor=[UIColor whiteColor];
        [self.bottomView addSubview:_lab_title];
    }
    return _lab_title;

}

- (void)cellForData:(id)data {

    RDMWenZhangModel *model=(RDMWenZhangModel *)data;
    
    
    CGFloat height=[model.title boundingRectWithSize:CGSizeMake(self.bottomView.frame.size.width-left_space_width*2, 2000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height+10;
    
   
    self.lab_title.frame=CGRectMake(left_space_width,top_space_height,self.bottomView.frame.size.width-left_space_width*2,height);
    self.lab_title.text=model.title;
    
    
    self.bottomView.frame=CGRectMake(0, self.imageview.frame.size.height-top_space_height*2-height, self.imageview.frame.size.width,top_space_height*2+height);
    
    for (UIView *subview in [self.bottomView subviews]) {
        if (![subview isKindOfClass:[UILabel class]]) {
            subview.frame=CGRectMake(0, 0, self.bottomView.frame.size.width,_bottomView.frame.size.height);
        }
    }

    NSString *string=model.imageURL;
    
    string=[string stringByReplacingOccurrencesOfString:@"_320" withString:@"_640"];
    string=[string stringByReplacingOccurrencesOfString:@"_t" withString:@""];
    
    [_imageview sd_setImageWithURL:[NSURL URLWithString:string]];
}

//点击图片
- (void)headTap:(UITapGestureRecognizer *)tap {
    [_delegate didSelectRGCollectionViewCellImage:self.tag-100];
}




@end
